i = 0
while(TRUE){
  #running the web scraping Perl script which will deliver the number of watchers for each of the streams, and will mark them with timestamps for plotting
  system("perl streaming.pl")

  #reading the data and the names of streams
  streams <- read.table("streaming.txt", h=FALSE, sep="\t", stringsAsFactors=TRUE)
  stats <- read.table("streamingcounter.txt", h=FALSE, sep="\t", stringsAsFactors=TRUE)
  names(stats) <- c("olddate", as.character(streams[,2]))
  stats$date <- strptime(stats[,1], format="%F %H:%M:%S")

  #subsetting the data from the last 24h
  recent <- subset(stats, (max(stats$date) - stats$date) <= 86400)

  #plotting the data from the last 24h
  png("streaming.png", width=1920, height=1080)
  par(mar=c(6,6,4,2)+0.1)
  plot(recent$date, recent[,2],
    type="b",
    pch=20,
    main="Selected media livestreams at YouTube as currently watched by...",
    xlab="Time",
    ylab="Viewers online",
    ylim=c(min(rbind(recent[,2:(ncol(recent)-1)])),
           max(rbind(recent[,2:(ncol(recent)-1)]))),
    col="white")
  for(i in 2:ncol(stats)){
    points(recent$date, recent[,i],
      type="l",
      pch=20,
      col=i)
  }
  legend("topright",
         levels(streams[,2]),
         col=as.numeric(order(streams[,2])) + 1,
         lty=1,
         lwd=3,
         pch="",
         bty="n",
         box.lwd=par("lwd"),
         box.lty=par("lty"),
         box.col=par("fg"),
         horiz=TRUE,
         title=NULL)
  dev.off()

  #wait five minutes and do everything again: scrape, store, read to dataframes, plot
  i = i + 300
  Sys.sleep(300)
}
