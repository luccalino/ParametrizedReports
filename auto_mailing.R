#devtools::install_github('omegahat/RDCOMClient')
library(RDCOMClient)

# Load mailing list
load("data/EmailList.RData")

# Loop through the participant list
for (i in 1:nrow(EmailList)) {
  
  ## Init com api
  OutApp <- COMCreate("Outlook.Application")
  
  ## Create an email
  outMail = OutApp$CreateItem(0)
  
  ## Configure email parameter
  outMail[["To"]] = EmailList$email[i]
  outMail[["subject"]] = ifelse(EmailList$startlanguage[i] == "de", "Feedback: Weinbau Umfrage 2022 der ETH Z?rich",
                                ifelse(EmailList$startlanguage[i] == "fr", "Feedback: Sondage viticole 2022 de l'EPF Zurich", 
                                                        "Feedback: Indagine viticola del Politecnico di Zurigo 2022"))
  outMail[["body"]] = ifelse(EmailList$startlanguage[i] == "de", paste0("Liebe Winzerin, lieber Winzer\n\nSie haben an unserer Umfrage über den Schweizer Weinbau teilgenommen. Dafür m?chten wir uns bedanken. Sie habe in der Umfrage angegeben, dass Sie Feedback zur Umfrage wünschen. Wir senden Ihnen im Anhang gerne ihren individuellen Bericht mit Auswertungen der Umfrage.\n\nWir haben zudem eine kurze Folgeumfrage erstellt, welche lediglich 10 Minuten dauert und wichtige Erkenntnise für Sie und die Forschung liefern wird. Sie k?nnen unter folgendem Link ganz einfach und unkompliziert an der Umfrage teilnehmen:\n\nhttps://surveyaecp.ethz.ch/index.php/756865?token=",EmailList$token[i],"&lang=",EmailList$startlanguage[i],"\n\nVielen herzlichen Dank!\n\nFreundliche Grüsse,\nLucca Zachmann, Chloe McCallum und Robert Finger"),
                             ifelse(EmailList$startlanguage[i] == "fr", paste0("Chère viticultrice, cher viticulteur\n\nVous avez participé à notre enquête sur la viticulture suisse. Nous tenons à vous en remercier. Vous aviez exprimé le souhait d'avoir un retour sur l'enquête réalisée. Vous trouverez donc ci-joint votre rapport personnalisé avec les résultats de l'inquête.\n\nNous avons également créé une courte enquête de suivi qui ne prend que 10 minutes et qui fournira des informations importantes pour vous et pour la recherche. Vous pouvez y participer très facilement en cliquant sur le lien suivant:\n\nhttps://surveyaecp.ethz.ch/index.php/756865?token=",EmailList$token[i],"&lang=",EmailList$startlanguage[i],"\n\nMerci beaucoup!\n\nBien cordialement,\nLucca Zachmann, Chloe McCallum et Robert Finger"),
                                    paste0("Caro viticoltore\n\nHai partecipato al nostro sondaggio sulla viticoltura svizzera. Vorremmo ringraziarvi per questo. Nel sondaggio avete indicato che avreste voluto un feedback sul sondaggio. Saremo lieti di inviarvi il vostro rapporto individuale con l'analisi del sondaggio in allegato.\n\nAbbiamo anche creato un breve sondaggio di follow-up, che richiede solo 10 minuti e fornirà importanti spunti per voi e per la ricerca. Potete partecipare facilmente al sondaggio al seguente link:\n\nhttps://surveyaecp.ethz.ch/index.php/756865?token=",EmailList$token[i],"&lang=",EmailList$startlanguage[i],"\n\nGrazie mille!\n\nBuoni saluti,\nLucca Zachmann, Chloe McCallum e Robert Finger")))
  
  ## Add report
  outMail[["attachments"]]$Add(paste0("reports\\", ifelse(EmailList$startlanguage[i] == "de",paste0("Ihr Bericht (Nr. ", EmailList$id[i],").pdf"),
                                                          ifelse(EmailList$startlanguage[i] == "fr",paste0("Votre Rapport (Nr. ", EmailList$id[i],").pdf"),paste0("Vostro Rapporto (Nr. ",EmailList$id[i],").pdf"))
                                                          )
                                      )
                               )

  ## Send it                    
  outMail$Send()
  
  ## Show progress
  cat("Mail sent to: ", EmailList$email[i],'\n')
  
}
