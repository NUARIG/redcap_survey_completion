# Empty memory and read the surveys 
# (need to be downloaded from REDCap and stored input/survey.csv)
rm(list=ls())

formname <- paste('key_fields','timestamp',sep = '_')

#truncates data. Starts plotting at start date not start of data
mystart <- as.POSIXct("2017-03-01")
myend <- as.POSIXct("2020-12-31")

mysurveys <- read.csv("input/mysurvey.csv", stringsAsFactors=FALSE )
mytimes <- mysurveys[[formname]]
mytimes <- mytimes[mytimes!='[not completed]']
mytimes <- mytimes[mytimes>=mystart & mytimes<=myend]
mytimes <- as.POSIXct(mytimes)
mytimes <- sort(mytimes)

mycumulative = seq(length(mytimes))

mydataframe = data.frame(mytimes = mytimes, total = mycumulative, row.names = NULL)

mymaintitle = paste("Number of Completed User Agreements:",
                    as.character(length(mytimes)))
mysubtitle = paste("Start Date:",mystart,
                   "-",
                   "Current Time:",Sys.time())

png(filename="output/surveyresponse.png",width=1280,height=960,res=150)
plot(mydataframe$mytimes,mydataframe$total,
     bty="n", main=mymaintitle, col.main = '#4E2A84', sub = mysubtitle,
     type="s", lwd=4, col='#4E2A84',
     ylab="# of Survey Responses Completed", ylim=c(0,max(mycumulative)+200), yaxt="n", yaxs="r",
     xlab="Time (UTC)", xlim=c(mystart,max(mytimes)+7*24*60*60), xaxt="n", xaxs="r")

axis.POSIXct(1, at=seq(mystart,max(mytimes)+90*24*60*60,"quarters"), format="%b %y")
axis(2, seq(0,max(mycumulative)+200,500), tick=FALSE, las=2)

abline(h=seq(0,4000,1000),lwd=2,lty=1)
abline(h=seq(0,4000,500),lwd=0.5,lty=2)
abline(v=as.POSIXct("2017-05-19 23:59:59"), lwd=2, lty=2) #When accounts suspend
text(as.POSIXct("2017-05-19 23:59:59"),3550, "Response Deadline",
     col='#4E2A84',srt=270,adj = c(0,-0.6),font=2)
dev.off()