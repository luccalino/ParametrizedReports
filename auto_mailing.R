# Make sure you have R 3.5 installed and in use (older R versions available under https://cran.r-project.org/bin/windows/base/old/)
# Then, install RDCOMClient directly from omegahat: install.packages("RDCOMClient", repos = "http://www.omegahat.net/R")
# Install RTools from: https://cran.r-project.org/bin/windows/Rtools/

# Load the package
library(RDCOMClient)

# Load mailing list
load("data/EmailList.RData")

# Loop through the participant list
for (i in 1:nrow(EmailList)) {
  
  ## Init com api
  OutApp <- COMCreate("Outlook.Application")  
  
  ## Create an email
  outMail = OutApp$CreateItem(0)
  
  ## Get the signature from HTML body (you can specifiy the look of the signature e.g. with a logo in your outlook settings)
  outMail$Display()
  signature = outMail[["HTMLBody"]]
  
  ## Configure email parameter
  outMail[["To"]] = EmailList$email[i]
  outMail[["subject"]] = ifelse(EmailList$startlanguage[i] == "de", "Feedback: Weinbau Umfrage 2022 der ETH Zürich",
                                ifelse(EmailList$startlanguage[i] == "fr", "Feedback: Sondage viticole 2022 de l'EPF Zurich", 
                                                        "Feedback: Indagine viticola del Politecnico di Zurigo 2022")
                               )

  custom_message <- ifelse(
      EmailList$startlanguage[i] == "de",
      paste0("Liebe Winzerin, lieber Winzer<br><br>Sie haben an unserer Umfrage über den Schweizer Weinbau teilgenommen. Dafür möchten wir uns bedanken. Sie habe in der Umfrage angegeben, dass Sie Feedback zur Umfrage wünschen. Wir senden Ihnen im Anhang gerne ihren individuellen Bericht mit Auswertungen der Umfrage.<br><br>Wir haben zudem eine kurze Folgeumfrage erstellt, welche lediglich 10 Minuten dauert und wichtige Erkenntnise für Sie und die Forschung liefern wird. Sie können unter folgendem Link ganz einfach und unkompliziert an der Umfrage teilnehmen:<br><br>https://surveyaecp.ethz.ch/index.php/756865?token=",EmailList$token[i],"&lang=",EmailList$startlanguage[i],"<br><br>Vielen herzlichen Dank!<br><br>Freundliche Grüsse,<br>Lucca Zachmann, Chloe McCallum und Robert Finger"),
    ifelse(
      EmailList$startlanguage[i] == "fr",
      paste0("Chère viticultrice, cher viticulteur<br><br>Vous avez participé à notre enquête sur la viticulture suisse. Nous tenons à vous en remercier. Vous aviez exprimé le souhait d'avoir un retour sur l'enquête réalisée. Vous trouverez donc ci-joint votre rapport personnalisé avec les résultats de l'inquête.<br><br>Nous avons également créé une courte enquête de suivi qui ne prend que 10 minutes et qui fournira des informations importantes pour vous et pour la recherche. Vous pouvez y participer très facilement en cliquant sur le lien suivant:<br><br>https://surveyaecp.ethz.ch/index.php/756865?token=",EmailList$token[i],"&lang=",EmailList$startlanguage[i],"<br><br>Merci beaucoup!<br><br>Bien cordialement,<br>Lucca Zachmann, Chloe McCallum et Robert Finger"),
    ifelse(
      EmailList$startlanguage[i] == "it",
        paste0("Caro viticoltore<br><br>Hai partecipato al nostro sondaggio sulla viticoltura svizzera. Vorremmo ringraziarvi per questo. Nel sondaggio avete indicato che avreste voluto un feedback sul sondaggio. Saremo lieti di inviarvi il vostro rapporto individuale con l'analisi del sondaggio in allegato.<br><br>Abbiamo anche creato un breve sondaggio di follow-up, che richiede solo 10 minuti e fornirà importanti spunti per voi e per la ricerca. Potete partecipare facilmente al sondaggio al seguente link:<br><br>https://surveyaecp.ethz.ch/index.php/756865?token=",EmailList$token[i],"&lang=",EmailList$startlanguage[i],"<br><br>Grazie mille!<br><br>Buoni saluti,<br>Lucca Zachmann, Chloe McCallum e Robert Finger")
      )
    )
  )

  ## Combine message and signature
  outMail[["HTMLBody"]] <- paste0("<p>", custom_message, "</p>", signature)
  
  ## Add report
  filename <- ifelse(
    EmailList$startlanguage[i] == "de",
    paste0("Ihr Bericht (Nr. ", EmailList$id[i], ").pdf"),
    ifelse(
      EmailList$startlanguage[i] == "fr",
      paste0("Votre Rapport (Nr. ", EmailList$id[i], ").pdf"),
      paste0("Vostro Rapporto (Nr. ", EmailList$id[i], ").pdf")
    )
  )
  
  # Build full path safely
  filepath <- file.path(getwd(), "reports", filename)
  
  # Debug check: does the file exist?
  if (!file.exists(filepath)) {
    stop(paste("Attachment not found:", filepath))
  }
  
  # Add attachment
  outMail[["attachments"]]$Add(filepath)
  
  ## Send it                    
  outMail$Send()
  
  ## Show progress
  cat("Mail sent to: ", EmailList$email[i],'\n')
  
}
