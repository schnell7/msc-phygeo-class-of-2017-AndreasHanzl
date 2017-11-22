clean.place <- function(x){
# Split place into comma separated entries
ort <- strsplit(as.character(x$Ort), ",")

# Write separate entries to data frame
ort_df <- lapply(ort, function(i){
  p1 <- sub("^\\s+", "", i[1])  # Trim leading white spaces
  if(length(i) > 2){
    p2 <- sub("^\\s+", "", i[2])
    p3 <- sub("^\\s+", "", i[3])
  } else if (length(i) > 1){
    p2 <- sub("^\\s+", "", i[2])
    p3 <- NA
  } else {
    p2 <- NA
    p3 <- NA
  }
  data.frame(A = p1,
             B = p2,
             C = p3)
})
ort_df <- do.call("rbind", ort_df)
ort_df$ID <- x$ID 
ort_df$Jahr <- x$Jahr

# Swap second and third column
ort_df[!is.na(ort_df$C),] <- ort_df[!is.na(ort_df$C), c(1, 3, 2, 4, 5)]

# Take care of "Landkreise"
for(r in seq(nrow(ort_df))){
  if(is.na(ort_df$B[r]) &
     grepl("kreis", tolower(ort_df$A[r]))){
    ort_df$B[r] <- "Landkreis"
  }
}

# Take care of federal states and country
ort_df$B[is.na(ort_df$B) & nchar(as.character(ort_df$ID) == 2)] <- "Bundesland"
ort_df$B[ort_df$ID == "DG"] <- "Land"

# Merge back into original data frame
x_sep <- merge(x, ort_df, by = c("ID", "Jahr"))

# Remove initial place column and move the new place information further left
x_clean <- x_sep[, -3]
names(x_clean)[(ncol(x_clean)-2):ncol(x_clean)] <- c("Place", "Admin_unit", "Admin_misc")
x_clean <- x_clean[, c(1:2, (ncol(x_clean)-2):ncol(x_clean), 3:(ncol(x_clean)-3))]

return(x_clean)
}