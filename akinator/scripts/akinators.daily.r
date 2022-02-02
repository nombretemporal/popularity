#we need one argument, viz. the number such that for each day, only characters with a greater number of samplings will be plotted (to keep the plot legible and to confine the legend to manageable length); therefore, run it in terminal with Rscript akinators.daily.r <n>
args = commandArgs(trailingOnly=TRUE)

library(dplyr)

#English
en.lastplayed.all <- read.table("en.lastplayed.txt", h=FALSE, sep="\t", stringsAsFactors=TRUE)

en.lastplayed.ne <- subset(en.lastplayed.all, en.lastplayed.all[,3] != "")
en.srt <- en.lastplayed.ne %>% count(en.lastplayed.ne[,1], en.lastplayed.ne[,3], sort=TRUE)
en.srt.max <- subset(en.srt, en.srt$n > args[1])
first <- subset(en.srt.max, en.srt.max[,2] == 1)

png("en.akinator.png", width=1920, height=1080)
par(mar=c(5,5,4,20), xpd=TRUE)

plot(as.numeric(first[,3]) ~ as.POSIXct(first[,1],
    format="%F"),
    col="white",
    xlim=c(min(as.POSIXct(en.srt.max[,1])), max(as.POSIXct(en.srt.max[,1]))),
    ylim=c(min(as.numeric(en.srt.max[,3])), max(as.numeric(en.srt.max[,3]))),
    main="Dynamics of popularity at English Akinator",
    xlab="Days",
    ylab="Times sampled")
for(i in 1:length(levels(en.srt.max[,2]))){
    nth <- subset(en.srt.max, en.srt.max[,2] == levels(droplevels(en.srt.max[,2]))[i])
    lines(as.numeric(nth[,3]) ~ as.POSIXct(nth[,1], format="%F"), col=colors()[i], type="b", pch=20)
}

legend("topright",
       levels(droplevels(en.srt.max[,2])),
       col=colors(),
       inset=c(-.13,0),
       border="black",
       lty=2,
       lwd=2,
       pch=20,
       bty="n",
       box.lwd=par("lwd"),
       box.lty=par("lty"),
       box.col=par("fg"),
       cex=.75,
       horiz=FALSE,
       title=NULL)

dev.off()

#Russian
ru.lastplayed.all <- read.table("ru.lastplayed.txt", h=FALSE, sep="\t", stringsAsFactors=TRUE)

ru.lastplayed.ne <- subset(ru.lastplayed.all, ru.lastplayed.all[,3] != "")
ru.srt <- ru.lastplayed.ne %>% count(ru.lastplayed.ne[,1], ru.lastplayed.ne[,3], sort=TRUE)
ru.srt.max <- subset(ru.srt, ru.srt$n > args[1])
first <- subset(ru.srt.max, ru.srt.max[,2] == 1)

png("ru.akinator.png", width=1920, height=1080)
par(mar=c(5,5,4,25), xpd=TRUE)

plot(as.numeric(first[,3]) ~ as.POSIXct(first[,1],
    format="%F"),
    col="white",
    xlim=c(min(as.POSIXct(ru.srt.max[,1])), max(as.POSIXct(ru.srt.max[,1]))),
    ylim=c(min(as.numeric(ru.srt.max[,3])), max(as.numeric(ru.srt.max[,3]))),
    main="Dynamics of popularity at Russian Akinator",
    xlab="Days",
    ylab="Times sampled")
for(i in 1:length(levels(ru.srt.max[,2]))){
    nth <- subset(ru.srt.max, ru.srt.max[,2] == levels(droplevels(ru.srt.max[,2]))[i])
    lines(as.numeric(nth[,3]) ~ as.POSIXct(nth[,1], format="%F"), col=colors()[i], type="b", pch=20)
}

legend("topright",
       levels(droplevels(ru.srt.max[,2])),
       col=colors(),
       inset=c(-.23,0),
       border="black",
       lty=2,
       lwd=2,
       pch=20,
       bty="n",
       box.lwd=par("lwd"),
       box.lty=par("lty"),
       box.col=par("fg"),
       cex=.75,
       horiz=FALSE,
       title=NULL)

dev.off()
