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

rm(MBMSData_Filter)
rm(MBMS_PrePost_PANASIOS)

#empirical growth plots per individual#
PreOnlyData_Filter %>%
  ggplot(aes(x=Session, y=PANAS_Start_Pos))+
  geom_point() +
  coord_cartesian(xlim=c(1,7)) +
  theme(panel.grid = element_blank()) +
  facet_wrap(~Record_ID)
PreOnlyData_Filter %>%
  ggplot(aes(x=Session, y=PANAS_Start_Neg))+
  geom_point() +
  theme(panel.grid = element_blank()) +
  facet_wrap(~Record_ID)
PreOnlyData_Filter %>%
  ggplot(aes(x=Session, y=IOS_Pre))+
  geom_point() +
  theme(panel.grid = element_blank()) +
  facet_wrap(~Record_ID)
  
#OLS plots#

  #sort by Id and nest#
by_id <-
  PreOnlyData_Filter %>%
  group_by(Record_ID) %>%
  nest()

  #OLS plot#
PreOnlyData_Filter %>% 
  ggplot(aes(x=Session,y=PANAS_Start_Pos))+
  stat_smooth(aes(group= Record_ID),
              method="lm",se=F, size=1/6)+
  stat_smooth(method="lm", se=F, size=2)+
  xlim(1,7) +
  theme(panel.grid = element_blank())
  #individual OLS models#

by_id_PANASPos <-
  PreOnlyData_Filter %>%
  group_by(Record_ID) %>%
  nest() %>%
  mutate(model=map(data, ~lm(data=., PANAS_Start_Pos~Session)))
 
head (by_id)

by_id_PANASPos<-
  by_id_PANASPos %>%
  mutate(tidy= map(model,tidy),
         glance=map(model,glance))
head(by_id_PANASPos)

#descriptive statistics3
summary(PreOnlyData_Filter)



PANAS_Pos_mixed =lmer(PANAS_Start_Pos ~ Session + (1|Record_ID), data=PreOnlyData_An1)

summary(PANAS_Pos_mixed)

PANAS_Pos_lm=lm(PANAS_Start_Pos ~ Session, data=PreOnlyData_An1)
summary(PANAS_Pos_lm)

PANAS_Neg_mixed =lmer(PANAS_Start_Neg ~ Session + (1|Record_ID), data=PreOnlyData_An1)
summary(PANAS_Neg_mixed)
