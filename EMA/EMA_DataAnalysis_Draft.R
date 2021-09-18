library(tibble)
library(dplyr)
library(data.table)

EMA<- as_tibble(MBMS_EMA_20210622)

head(EMA)
EMA <- EMA%>%
  select(`Record ID`,`Event Name`,`Repeat Instance`, `Survey Timestamp`, Distressed, Excited, Upset, Scared, Enthusiastic, Alert, Inspired, Nervous, Determined, Afraid)

library(bReeze)
#Try 1#
Date <- Date %>%
   mutate(day<-weekdays(as.Date(`Survey Timestamp`)))

#Try 2, rename#
Date <- Date %>%
  mutate(DayofWeek = weekdays(as.Date(`Survey Timestamp`))


#Add to EMA df#
EMA_v2 <- EMA %>%
  mutate(DayofWeek = weekdays(as.Date(`Survey Timestamp`)), .after= `Survey Timestamp`)


#Add variable to classify "Weekday" or "Weekend"#

EMA_v2%>%
  Monday <- "Monday"
  Tuesday <- "Tuesday"
  Wednesday <- "Wednesday"
  Thursday <- "Thursday"
  Friday <- "Friday"
  Saturday <- "Saturday"
  Sunday <- "Sunday"
  
attach(EMA_v2)
  Cat_DayofWeek[DayofWeek==Monday] <- "Weekday"
  Cat_DayofWeek [DayofWeek==Tuesday]<-"Weekday"
  Cat_DayofWeek [DayofWeek==Wednesday]<-"Weekday"
  Cat_DayofWeek [DayofWeek==Thursday]<-"Weekday"
  Cat_DayofWeek [DayofWeek==Friday]<-"Weekday"
  Cat_DayofWeek [DayofWeek==Saturday]<-"Weekend"
  Cat_DayofWeek [DayofWeek==Sunday]<-"Weekend"

EMA_v2 <- EMA_v2 %>%
  mutate(Cat_DayofWeek=Cat_DayofWeek, .after=DayofWeek)
  
 





