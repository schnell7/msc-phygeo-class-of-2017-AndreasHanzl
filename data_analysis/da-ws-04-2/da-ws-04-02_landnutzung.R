# Set path ---------------------------------------------------------------------
filepath_base <- "C:/Users/Andreas/Documents/Physische Geographie/WiSe 2017/"
path_data <- paste0(filepath_base, "data/")
path_csv <- paste0(path_data, "csv/")
path_rdata <- paste0(path_data, "rdata/")
path_scripts <- paste0(filepath_base, "fun/")
path_temp <- paste0(filepath_base, "temp/")

# Pre-clean crop data ----------------------------------------------------------
# Read data
lu <- read.table(paste0(path_csv, "AI001_gebiet_flaeche.txt"),
                skip = 4, header = TRUE, sep = ";", dec = ",", 
                fill = TRUE, encoding="ANSI")

names(lu) <- c("Jahr", "ID", "Ort", "Anteil Siedlungs- und Verkehrsfläche an Gesamtfläche", 
               "Anteil Erholungsfläche an Gesamtfläche", "Anteil Landwirtschaftsfläche an Gesamtfläche",
              "Anteil Waldfläche an Gesamtfläche")

# Cut off tail
tail(lu)
lu <- lu[1:5250,]

# Numbers as numbers, not characters/factors
for(c in colnames(lu)[4:7]){
  lu[, c][lu[, c] == "." | 
           lu[, c] == "-" | 
           lu[, c] == "," | 
           lu[, c] == "/"] <- NA
  lu[, c] <- as.numeric(sub(",", ".", as.character(lu[, c])))
}

# Load clean_place function file
source(paste0(path_scripts, "clean_place.R"))

# Run clean.place function
lu_clean <- clean.place(lu)

# Show first rows
head(lu_clean)

# Save as RDS
saveRDS(lu_clean, file = paste0(path_rdata, "lu_clean.rds"))