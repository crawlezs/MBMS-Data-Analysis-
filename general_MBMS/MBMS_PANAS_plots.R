library(ggplot2)
library(plyr)

# after I exported the raw PANAS data from redcap, I added a "session_number" column that just had the numbers 1-7 (based on the redcap_event_name)
# then I added a column "id_session" in excel where I just concatenated the record_id column and the session_number column to get a 6 digit number
# e.g. 12013 session 6 would be 120136 in the "id_session" column 
df <- read.csv('/Users/talia/Downloads/MBMS_PANAS.csv')

# drop 12002 (pilot)
df <- subset(df, record_id != 12002)

# Start to End
df <- plyr::rename(df, c("iospreom"="START", "iospostom"="END"))

df$dummy <- 1
early <-  df[ which(df$session_number==0), ]
mid <-  df[ which(df$session_number==1), ]
late <-  df[ which(df$session_number==2), ]

# PANAS POSITIVE AFFECT
panas_pos <- df[c('id_session', 'dummy', 'panas_start_pos', 'panas_end_pos')]
panas_pos <- plyr::rename(panas_pos, c("panas_start_pos"="START", "panas_end_pos"="END"))

# convert data to long form
panas_pos <- melt(panas_pos, id.vars=c("id_session", "dummy"))

panas_pos_plot <- ggplot(data = panas_pos, aes(x = variable, y = value))
panas_pos_plot + geom_line(aes( group=id_session), size=0.1, color="blue") + geom_line(aes(group=dummy), size=2, stat="summary", color="blue") + scale_x_discrete(name ="Timepoint") + ylab("PANAS Positive Affect Score")  +theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(), panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"), text = element_text(size=20, face="bold"))

#PANAS NEGATIVE AFFECT                                                                   
panas_neg <- df[c('id_session', 'dummy', 'panas_start_neg', 'panas_end_neg')]
panas_neg <- plyr::rename(panas_neg, c("panas_start_neg"="START", "panas_end_neg"="END"))
# convert data to long form
panas_neg <- melt(panas_neg, id.vars=c("id_session", "dummy"))

panas_neg_plot <- ggplot(data = panas_neg, aes(x = variable, y = value))
panas_neg_plot + geom_line(aes( group=id_session), size=0.1, color="red") + geom_line(aes(group=dummy), size=2, stat="summary", color="red") + scale_x_discrete(name ="Timepoint") + ylab("PANAS Negative Affect Score")  +theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(), panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"), text = element_text(size=20, face="bold"))

# PANAS ACROSS EACH WEEK
pos_across_sessions <- ggplot(data = df, aes(x = session_number, y = panas_start_pos))
#pos_across_sessions + geom_line(aes( group=record_id), color="blue") + scale_x_continuous(breaks=seq(1, 7, 1), name="Session Number")+ ylab("PANAS Positive Affect Score")  +theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(), panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"), text = element_text(size=20, face="bold"))
pos_across_sessions + geom_line(aes( group=record_id), size=0.1, color="blue") + geom_line(aes(group=dummy), size=2, stat="summary", color="blue") + scale_x_continuous(breaks=seq(1, 7, 1), name="Session Number")+ ylab("PANAS Positive Affect Score")  +theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(), panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"), text = element_text(size=20, face="bold"))

#panas_pos_avg <- aggregate(panas_pos[, 4:5], list(df_subset$parentid), FUN=mean, na.rm=TRUE)

neg_across_sessions <- ggplot(data = df, aes(x = session_number, y = panas_start_neg))
neg_across_sessions + geom_line(aes( group=record_id), size=0.1, color="red") + geom_line(aes(group=dummy), size=2, stat="summary", color="red") + scale_x_continuous(breaks=seq(1, 7, 1), name="Session Number")+ ylab("PANAS Negative Affect Score")  +theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(), panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"), text = element_text(size=20, face="bold"))