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




