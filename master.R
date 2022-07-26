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

# Load test data
load("data/SynData.RData")

# Loop through participants
for (i in 3:15) {
  
  # Render report
  render('compile.Rmd', 
          params = list(
            id = SynData$id[i],
            token = SynData$token[i],
            language = SynData$startlanguage[i],
            wine_region = SynData$wine_region[i]
          ), 
          output_file = paste('reports/',ifelse(SynData$startlanguage[i] == "de","Ihr Bericht (",ifelse(SynData$startlanguage[i] == "fr","Votre Rapport (","Vostro Rapporto (")),'Nr. ',SynData$id[i],').pdf', sep = ''),
          quiet = T,
          encoding = 'UTF-8')
  
  # Print progress
  print(paste0("Report created for id: ",SynData$id[i]))
  
}
