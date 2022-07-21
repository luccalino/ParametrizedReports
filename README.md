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
4. data: Contains some dummy data.
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
- Customised figures and tables.
- [Feedback from you]

## User guide
Soon there will be a user guide how this script can be used. For example: Prepare an R dataframe with the following format:
- First column: ID
- Second column: email address
- Third column: langauge
- etc.

## Preview
This can look like shown [here](/reports/Votre%20Rapport%20(Nr.%20100).pdf).

### Author: 
Lucca Zachmann (lzachmann[at]ethz.ch)  
**ETH Zürich**, Agricultural Economics and Policy Group