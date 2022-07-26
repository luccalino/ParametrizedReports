# Parametrised reports for survey participant feedback
This repository includes material to generate automated an personalised reports in multiple languages for survey participants. This is done to i) provide the survey participants with *individual* feedback in which they see their position relative to peers in ii) their preferred language and iii) in an automated manner. Moreover, the repository includes a script to send the reports automatically via R, given that Outlook 10 is installed on a Windows machine.

## Prerequisites
The proper functioning of the repo hinges ono the availability of several installed bits of software:
- pandoc: [https://pandoc.org](https://pandoc.org)
- R packages (rmarkdown, conflicted, tidyverse, ggpubr, ggpattern, wesanderson)
- TinyTeX: [https://yihui.org/tinytex/](https://yihui.org/tinytex/)

## Material
This repo consists of these main files:
1. master.R: Loops through participant id and renders pdf reports.
2. compile:Rmd: Compiles a report file for the correct language and includes meta data. 
3. [language]_text.Rmd: Style document/script for the language-specific report files.
3. auto_mailing.R: Script that sends list of participants their individual report (via Outlook).
4. data: Contains some dummy data. We use synthdata according to Nowok et al. (2016) and the synthpop package (DOI:10.18637/jss.v074.i11) available at https://www.jstatsoft.org/article/view/v074i11.
5. reports: The generated reports will be saved here.

## Features :sparkles:
Done :white_check_mark:
- Individual and region specific scatter plots
- Individual and region specific bar graphs
- Table of contents in several languages
- Script that sends automated e-mail from Outlook to individual participant (with attached automated individual report)
- Invitation to participate in follow-up survey in preferred language including personalised token to match earlier results with new survey
- Reports (and all figures therein) are compiled in the language the participant has used to complete the survey

To do :interrobang:
- Let me know what you would like to see added.

## User guide
Using the repo is straightforward. First, fork it to your local machine. Second, open *master.R* and run the entire script. This will, if all prerequisities (see above) are installed properly, generate 15 reports in french, german or italian and save the pdfs into the *reports* folder. Third, add your dataset (manditory variables are id, token, startlanguage, wine_region) and modify the scripts (*german_text.Rmd*, *french_text.Rmd* and *italian_text.Rmd*) to your liking.

## Preview
This can look like shown [here](/reports/Votre%20Rapport%20(Nr.%20100).pdf).

### Author: 
Lucca Zachmann (lzachmann[at]ethz.ch)  
**ETH Zürich**  
Agricultural Economics and Policy Group