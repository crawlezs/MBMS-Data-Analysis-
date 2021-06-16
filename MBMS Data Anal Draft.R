library(tibble)
library(dplyr)
filter(PrePostData, Record_ID != "12002" & Record_ID != "12009")
PrePostData %>%
  select(Record_ID, Session, PANAS_Start_Pos, PANAS_Start_Neg, IOS_Pre) %>%
  filter(Record_ID != "12002" & Record_ID != "12009")
PreOnlyData_Filter <- PrePostData %>%
  select(Record_ID, Session, PANAS_Start_Pos, PANAS_Start_Neg, IOS_Pre) %>%
  filter(Record_ID != "12002" & Record_ID != "12009")
