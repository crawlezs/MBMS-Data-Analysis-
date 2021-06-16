library(tibble)
library(dplyr)
library(data.table)
#practice filters for un-used IDs and Pre-only#
filter(PrePostData, Record_ID != "12002" & Record_ID != "12009")
PrePostData %>%
  select(Record_ID, Session, PANAS_Start_Pos, PANAS_Start_Neg, IOS_Pre) %>%
  filter(Record_ID != "12002" & Record_ID != "12009")
#create new data set with filtered data#
PreOnlyData_Filter <- PrePostData %>%
  select(Record_ID, Session, PANAS_Start_Pos, PANAS_Start_Neg, IOS_Pre) %>%
  filter(Record_ID != "12002" & Record_ID != "12009")
#remove missing data#
PreOnlyData_Filter %>%
  filter(!is.na(PANAS_Start_Pos),
         !is.na(PANAS_Start_Neg),
         !is.na(IOS_Pre))
PreOnlyData_Filter<- PreOnlyData_Filter %>%
  filter(!is.na(PANAS_Start_Pos),
         !is.na(PANAS_Start_Neg),
         !is.na(IOS_Pre))
#check data table#
setDT(PreOnlyData_Filter)
data.table(PreOnlyData_Filter ,keep.rownames = TRUE)


