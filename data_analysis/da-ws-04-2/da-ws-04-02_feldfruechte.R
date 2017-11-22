# Set path ---------------------------------------------------------------------
filepath_base <- "C:/Users/Andreas/Documents/Physische Geographie/WiSe 2017/"
path_data <- paste0(filepath_base, "data/")
path_csv <- paste0(path_data, "csv/")
path_rdata <- paste0(path_data, "rdata/")
path_scripts <- paste0(filepath_base, "fun/")
path_temp <- paste0(filepath_base, "temp/")

# Pre-clean crop data ----------------------------------------------------------
# Read data
cp <- read.table(paste0(path_csv, "115-46-4_feldfruechte.txt"),
                skip = 6, header = TRUE, sep = ";", dec = ",", 
                fill = TRUE, encoding="ANSI")

names(cp) <- c("Jahr", "ID", "Ort", "Winterweizen", "Roggen", "Wintergerste",
              "Frühlingsgerste", "Hafer", "Triticale", "Kartoffeln", "Zuckerrüben",
              "Raps", "Silomais")

# Cut off tail
tail(cp)
cp <- cp[1:8925,]

# Numbers as numbers, not characters/factors
for(c in colnames(cp)[4:13]){
  cp[, c][cp[, c] == "." | 
           cp[, c] == "-" | 
           cp[, c] == "," | 
           cp[, c] == "/"] <- NA
  cp[, c] <- as.numeric(sub(",", ".", as.character(cp[, c])))
}

# Load clean_place function file
source(paste0(path_scripts, "clean_place.R"))

# Run clean.place function
cp_clean <- clean.place(cp)

# Show first rows
head(cp_clean)

# Save as RDS
saveRDS(cp_clean, file = paste0(path_rdata, "cp_clean.rds"))