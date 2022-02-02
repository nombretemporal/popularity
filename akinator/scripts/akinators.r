i = 0
while(TRUE){
  #running the web scraping Perl script which will deliver text strings for recently played characters at the six Akinators studied here, and will mark them with timestamps for day-by-day plotting
  system("perl akinators.pl")

  #creating dataframes for six Akinators for the present day (older data is not deleted and will be used to plot time series in akinators.daily.r); discarding buggy empty strings from data to be used
  de.lastplayed.all <- read.table("de.lastplayed.txt", h=FALSE, sep="\t", quote="\"", stringsAsFactors=TRUE)
  de.lastplayed <- subset(de.lastplayed.all,  de.lastplayed.all[,3] != "" & as.character(de.lastplayed.all[,1]) == Sys.Date())

  en.lastplayed.all <- read.table("en.lastplayed.txt", h=FALSE, sep="\t", quote="\"", stringsAsFactors=TRUE)
  en.lastplayed <- subset(en.lastplayed.all,  en.lastplayed.all[,3] != "" & as.character(en.lastplayed.all[,1]) == Sys.Date())

  es.lastplayed.all <- read.table("es.lastplayed.txt", h=FALSE, sep="\t", quote="\"", stringsAsFactors=TRUE)
  es.lastplayed <- subset(es.lastplayed.all,  es.lastplayed.all[,3] != "" & as.character(es.lastplayed.all[,1]) == Sys.Date())

  fr.lastplayed.all <- read.table("fr.lastplayed.txt", h=FALSE, sep="\t", quote="\"", stringsAsFactors=TRUE)
  fr.lastplayed <- subset(fr.lastplayed.all,  fr.lastplayed.all[,3] != "" & as.character(fr.lastplayed.all[,1]) == Sys.Date())

  it.lastplayed.all <- read.table("it.lastplayed.txt", h=FALSE, sep="\t", quote="\"", stringsAsFactors=TRUE)
  it.lastplayed <- subset(it.lastplayed.all,  it.lastplayed.all[,3] != "" & as.character(it.lastplayed.all[,1]) == Sys.Date())

  ru.lastplayed.all <- read.table("ru.lastplayed.txt", h=FALSE, sep="\t", quote="\"", stringsAsFactors=TRUE)
  ru.lastplayed <- subset(ru.lastplayed.all,  ru.lastplayed.all[,3] != "" & as.character(ru.lastplayed.all[,1]) == Sys.Date())

  #counting occurrences of each character in each of the six samples
  library(plyr)

  de.counted <- as.data.frame(lapply(de.lastplayed[3], count))
  de.counted <- de.counted[order(de.counted[2], decreasing=TRUE),]
  de.counted[,3] <- "German"
  names(de.counted) <- c("Character", "Frequency", "Language")

  en.counted <- as.data.frame(lapply(en.lastplayed[3], count))
  en.counted <- en.counted[order(en.counted[2], decreasing=TRUE),]
  en.counted[,3] <- "English"
  names(en.counted) <- c("Character", "Frequency", "Language")

  es.counted <- as.data.frame(lapply(es.lastplayed[3], count))
  es.counted <- es.counted[order(es.counted[2], decreasing=TRUE),]
  es.counted[,3] <- "Spanish"
  names(es.counted) <- c("Character", "Frequency", "Language")

  fr.counted <- as.data.frame(lapply(fr.lastplayed[3], count))
  fr.counted <- fr.counted[order(fr.counted[2], decreasing=TRUE),]
  fr.counted[,3] <- "French"
  names(fr.counted) <- c("Character", "Frequency", "Language")

  it.counted <- as.data.frame(lapply(it.lastplayed[3], count))
  it.counted <- it.counted[order(it.counted[2], decreasing=TRUE),]
  it.counted[,3] <- "Italian"
  names(it.counted) <- c("Character", "Frequency", "Language")

  ru.counted <- as.data.frame(lapply(ru.lastplayed[3], count))
  ru.counted <- ru.counted[order(ru.counted[2], decreasing=TRUE),]
  ru.counted[,3] <- "Russian"
  names(ru.counted) <- c("Character", "Frequency", "Language")

  #to avoid overloaded plots, taking 25 most frequently sampled characters for each language
  de.top <- head(de.counted, n=25)
  en.top <- head(en.counted, n=25)
  es.top <- head(es.counted, n=25)
  fr.top <- head(fr.counted, n=25)
  it.top <- head(it.counted, n=25)
  ru.top <- head(ru.counted, n=25)

  #plotting 25 most frequently sampled characters for the present day for each of the six chosen Akinators (all on the same canvas)
  png(paste("akinators.", Sys.Date(), ".png", sep=""), width=1920, height=1080)
  par(mar=c(6,24,4,2)+0.1,
    las=1,
    mfcol=c(2,3),
    cex=.8)
  barplot(de.top$Frequency,
      horiz=TRUE,
      xlab="Times sampled",
      main="Most popular characters at German Akinator",
      names.arg=c(as.character(de.top$Character)))
  barplot(en.top$Frequency,
      horiz=TRUE,
      xlab="Times sampled",
      main="Most popular characters at English Akinator",
      names.arg=c(as.character(en.top$Character)))
  barplot(es.top$Frequency,
      horiz=TRUE,
      xlab="Times sampled",
      main="Most popular characters at Spanish Akinator",
      names.arg=c(as.character(es.top$Character)))
  barplot(fr.top$Frequency,
      horiz=TRUE,
      xlab="Times sampled",
      main="Most popular characters at French Akinator",
      names.arg=c(as.character(fr.top$Character)))
  barplot(it.top$Frequency,
      horiz=TRUE,
      xlab="Times sampled",
      main="Most popular characters at Italian Akinator",
      names.arg=c(as.character(it.top$Character)))
  barplot(ru.top$Frequency,
      horiz=TRUE,
      xlab="Times sampled",
      main="Most popular characters at Russian Akinator",
      names.arg=c(as.character(ru.top$Character)))
  dev.off()

  #wait one minute and do everything again: scrape, store, read to dataframes, plot
  i = i + 60
  Sys.sleep(60)

}
