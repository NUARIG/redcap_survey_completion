# Empty memory and read the surveys 
# (need to be downloaded from REDCap and stored input/survey.csv)
rm(list=ls())

formname <- paste('key_fields','timestamp',sep = '_')

#truncates data. Starts plotting at start date not start of data
mystart <- as.POSIXct("2017-03-06")
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
                   "End Date:",myend,
                   "-",
                   "Current Time:",Sys.time())

png(filename="output/surveyresponse.png",width=1280,height=960,res=150)
plot(mydataframe$mytimes,mydataframe$total,
     bty="n", main=mymaintitle, sub = mysubtitle,
     type="s", lwd=3, col='red',
     ylab="# of Survey Responses Completed", ylim=c(0,1200), yaxt="n", yaxs="r",
     xlab="Time (UTC)", xlim=c(mystart,max(mytimes)+7*24*60*60), xaxt="n", xaxs="r")

axis.POSIXct(1, at=seq(mystart, max(mytimes)+7*24*60*60, 7*24*60*60), format="%D")
axis(2, seq(0,1200,100), tick=FALSE, las=2)

abline(h=seq(0,2000,500),lwd=2,lty=1)
abline(h=seq(0,2000,100),lwd=1,lty=2)
# abline(v=as.POSIXct("2013-09-11 21:30:00")) #When the survey went out
# abline(v=as.POSIXct("2013-09-16 15:00:00"),lty="dashed") #When the session 001 was opened
# abline(v=as.POSIXct("2014-06-02 13:00:00"),lty="dashed") #When the session 002 was opened
# abline(v=as.POSIXct("2014-10-27 13:00:00"),lty="dashed") #When the session 003 was opened
dev.off()