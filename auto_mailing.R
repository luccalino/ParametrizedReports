#devtools::install_github('omegahat/RDCOMClient')
library(RDCOMClient)

# Load mailing list
load("data/email_list.RData")

# Loop through the participant list
for (i in 1:nrow(email_list)) {
  
  ## Init com api
  OutApp <- COMCreate("Outlook.Application")
  
  ## Create an email
  outMail = OutApp$CreateItem(0)
  
  ## Configure email parameter
  outMail[["To"]] = email_list$email[i]
  outMail[["subject"]] = ifelse(email_list$startlanguage[i] == "de", "Feedback: Weinbau Umfrage 2022 der ETH Z?rich",
                                ifelse(email_list$startlanguage[i] == "fr", "Feedback: Sondage viticole 2022 de l'EPF Zurich", 
                                                        "Feedback: Indagine viticola del Politecnico di Zurigo 2022"))
  outMail[["body"]] = ifelse(email_list$startlanguage[i] == "de", paste0("Liebe Winzerin, lieber Winzer\n\nSie haben an unserer Umfrage über den Schweizer Weinbau teilgenommen. Dafür m?chten wir uns bedanken. Sie habe in der Umfrage angegeben, dass Sie Feedback zur Umfrage wünschen. Wir senden Ihnen im Anhang gerne ihren individuellen Bericht mit Auswertungen der Umfrage.\n\nWir haben zudem eine kurze Folgeumfrage erstellt, welche lediglich 10 Minuten dauert und wichtige Erkenntnise für Sie und die Forschung liefern wird. Sie k?nnen unter folgendem Link ganz einfach und unkompliziert an der Umfrage teilnehmen:\n\nhttps://surveyaecp.ethz.ch/index.php/756865?token=",email_list$token[i],"&lang=",email_list$startlanguage[i],"\n\nVielen herzlichen Dank!\n\nFreundliche Grüsse,\nLucca Zachmann, Chloe McCallum und Robert Finger"),
                             ifelse(email_list$startlanguage[i] == "fr", paste0("Chère viticultrice, cher viticulteur\n\nVous avez participé à notre enquête sur la viticulture suisse. Nous tenons à vous en remercier. Vous aviez exprimé le souhait d'avoir un retour sur l'enquête réalisée. Vous trouverez donc ci-joint votre rapport personnalisé avec les résultats de l'inquête.\n\nNous avons également créé une courte enquête de suivi qui ne prend que 10 minutes et qui fournira des informations importantes pour vous et pour la recherche. Vous pouvez y participer très facilement en cliquant sur le lien suivant:\n\nhttps://surveyaecp.ethz.ch/index.php/756865?token=",email_list$token[i],"&lang=",email_list$startlanguage[i],"\n\nMerci beaucoup!\n\nBien cordialement,\nLucca Zachmann, Chloe McCallum et Robert Finger"),
                                    paste0("Caro viticoltore\n\nHai partecipato al nostro sondaggio sulla viticoltura svizzera. Vorremmo ringraziarvi per questo. Nel sondaggio avete indicato che avreste voluto un feedback sul sondaggio. Saremo lieti di inviarvi il vostro rapporto individuale con l'analisi del sondaggio in allegato.\n\nAbbiamo anche creato un breve sondaggio di follow-up, che richiede solo 10 minuti e fornirà importanti spunti per voi e per la ricerca. Potete partecipare facilmente al sondaggio al seguente link:\n\nhttps://surveyaecp.ethz.ch/index.php/756865?token=",email_list$token[i],"&lang=",email_list$startlanguage[i],"\n\nGrazie mille!\n\nBuoni saluti,\nLucca Zachmann, Chloe McCallum e Robert Finger")))
  
  ## Add report
  outMail[["attachments"]]$Add(paste0("reports\\", ifelse(email_list$startlanguage[i] == "de",paste0("Ihr Bericht (Nr. ", email_list$id[i],").pdf"),
                                                          ifelse(email_list$startlanguage[i] == "fr",paste0("Votre Rapport (Nr. ", email_list$id[i],").pdf"),paste0("Vostro Rapporto (Nr. ",email_list$id[i],").pdf"))
                                                          )
                                      )
                               )

  ## Send it                    
  outMail$Send()
  
  ## Show progress
  cat("Mail sent to: ", email_list$email[i],'\n')
  
}
