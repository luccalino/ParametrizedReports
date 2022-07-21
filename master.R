# The master file loops through the compile.Rmd via participant ids
# [sending of the reports is administered in the auto_mailing.R file]

# Load (and install) required libraries
library(rmarkdown)
library(conflicted)
library(tidyverse)
library(ggpubr)
library(ggpattern)
library(wesanderson)
library(lorem)
#tinytex::install_tinytex()
#devtools::install_github("gadenbuie/lorem")

conflict_prefer("filter", "dplyr")
conflict_prefer("select", "dplyr")
conflict_prefer("summarise", "dplyr")
conflict_prefer("mutate", "dplyr")
conflict_prefer("count", "dplyr")
conflict_prefer("fa", "fontawesome")

# Working directory
setwd("~/ParametrizedReports")

# Load test data
load("data/data.RData")

# Loop through participants
for (i in 1:15) {
  
  # Render report
  render('compile.Rmd', 
          params = list(
            id = data$id[i],
            token = data$token[i],
            language = data$startlanguage[i],
            gender = data$gender[i],
            wine_region = data$wine_region[i]
          ), 
          output_file = paste('reports/',ifelse(data$startlanguage[i] == "de","Ihr Bericht (",ifelse(data$startlanguage[i] == "fr","Votre Rapport (","Vostro Rapporto (")),'Nr. ',data$id[i],').pdf', sep = ''),
          quiet = T,
          encoding = 'UTF-8')
  
  # Print progress
  print(paste0("Report created for id: ",data$id[i]))
  
}
