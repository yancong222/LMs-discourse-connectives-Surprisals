library(ggplot2)
mydata = read.csv('italian_conc_data_surp.csv', header = TRUE)
# select relevant columns
df = mydata[, c('ITEM_ID', 
                'CONDITION', 
                'Plausibility', 
                'Connective',
                'TARGET_WORD',
                'SENT_COND', 
                'gpt2Italian_sum', 
                'gpt2Italian_tokens_len')]

#https://rstudio-pubs-static.s3.amazonaws.com/5312_98fc1aba2d5740dd849a5ab797cc2c8d.html
######inter surp######

p2 <- ggplot(df, aes(x=factor(CONDITION), 
                     y=gpt2Italian_sum, 
                     fill=factor(CONDITION))) +
  geom_boxplot(alpha=0.7) +
  stat_summary(fun.y=mean, geom="point", shape=20, size=7, color="yellow", fill="yellow") +
  scale_fill_brewer(palette="Purples") + 
  theme_classic()+
  theme(axis.text.x = element_blank(),
        axis.text.y = element_text(face="bold", color="#993333", 
                                   size=12, angle=360),
        axis.title.x = element_blank(),
        axis.title.y = element_text(size=12,face="bold")) + 
  ylab("Italian Surp-Sum Concessive") +
  theme(legend.position="none")
p2



########################################
mydata = read.csv('italian_contr_data_surp.csv', header = TRUE)
# select relevant columns
df = mydata[, c('ITEM_ID', 
                'CONDITION', 
                'Plausibility', 
                'Connective',
                'TARGET_WORD',
                'SENT_COND', 
                'gpt2Italian_sum', 
                
                'gpt2Italian_tokens_len')]

######inter surp######

p4 <- ggplot(df, aes(x=factor(CONDITION), 
                     y=gpt2Italian_sum, 
                     fill=factor(CONDITION))) +
  geom_boxplot(alpha=0.7) +
  stat_summary(fun.y=mean, geom="point", shape=20, size=7, color="yellow", fill="yellow") +
  scale_fill_brewer(palette="Purples") + #Set1
  theme_classic()+
  theme(axis.text.x = element_blank(),
        axis.text.y = element_text(face="bold", color="#993333", 
                                   size=12, angle=360),
        axis.title.x = element_blank(),
        axis.title.y = element_text(size=12,face="bold")) + 
  ylab("Italian Surp-Sum Contrastive") +
  theme(legend.position="none")
p4


########################################
mydata = read.csv('chi_conc_data_surp.csv', header = TRUE)
# select relevant columns
df = mydata[, c('ITEM_ID', 
                'CONDITION', 
                'Plausibility', 
                'Connective',
                'TARGET_WORD',
                'gpt2Chinese_sum', 
                'gpt2Chinese_tokens_len')]

######inter surp######

p6 <- ggplot(df, aes(x=factor(CONDITION), 
                     y=gpt2Chinese_sum, 
                     fill=factor(CONDITION))) +
  geom_boxplot(alpha=0.7) +
  stat_summary(fun.y=mean, geom="point", shape=20, size=7, color="yellow", fill="yellow") +
  scale_fill_brewer(palette="Purples") + 
  theme_classic()+
  theme(axis.text.x = element_blank(),
        axis.text.y = element_text(face="bold", color="#993333", 
                                   size=12, angle=360),
        axis.title.x = element_blank(),
        axis.title.y = element_text(size=12,face="bold")) + 
  ylab("Chinese Surp-Sum Concessive") +
  theme(legend.position="none")
p6


########################################
mydata = read.csv('chi_contr_data_surp.csv', header = TRUE)
# select relevant columns
df = mydata[, c('ITEM_ID', 
                'CONDITION', 
                'Plausibility', 
                'Connective',
                'TARGET_WORD',
                'gpt2Chinese_sum', 
                'gpt2Chinese_tokens_len')]

######inter surp######

p8 <- ggplot(df, aes(x=factor(CONDITION), 
                     y=gpt2Chinese_sum, 
                     fill=factor(CONDITION))) +
  geom_boxplot(alpha=0.7) +
  stat_summary(fun.y=mean, geom="point", shape=20, size=7, color="yellow", fill="yellow") +
  scale_fill_brewer(palette="Purples") + 
  theme_classic()+
  theme(axis.text.x = element_blank(),
        axis.text.y = element_text(face="bold", color="#993333", 
                                   size=12, angle=360),
        axis.title.x = element_blank(),
        axis.title.y = element_text(size=12,face="bold")) +  
  ylab("Chinese Surp-Sum Contrastive") +
  theme(legend.position="none")
p8


######################################
mydata = read.csv('fre_conc_data_surp.csv', header = TRUE)
# select relevant columns
df = mydata[, c('ITEM_ID', 
                'CONDITION', 
                'Plausibility', 
                'Connective',
                'TARGET_WORD',
                'gpt2French_sum', 
                'gpt2French_tokens_len')]

######inter surp######
p10 <- ggplot(df, aes(x=factor(CONDITION), 
                     y=gpt2French_sum, 
                     fill=factor(CONDITION))) +
  geom_boxplot(alpha=0.7) +
  stat_summary(fun.y=mean, geom="point", shape=20, size=7, color="yellow", fill="yellow") +
  scale_fill_brewer(palette="Purples") + 
  theme_classic()+
  theme(axis.text.x = element_text(face="bold", color="#993333", 
                                   size=12, angle=360),
        axis.text.y = element_text(face="bold", color="#993333", 
                                   size=12, angle=360),
        axis.title.x = element_blank(),
        axis.title.y = element_text(size=12,face="bold")) + 
  scale_x_discrete(labels=c("A", "B", "C", "D")) + 
  ylab("French Surp-Sum Concessive") +
  theme(legend.position="none")
p10


########################################
mydata = read.csv('fre_contr_data_surp.csv', header = TRUE)
# select relevant columns
df = mydata[, c('ITEM_ID', 
                'CONDITION', 
                'Plausibility', 
                'Connective',
                'TARGET_WORD',
                'gpt2French_sum', 
                'gpt2French_tokens_len')]

######inter surp######

p12 <- ggplot(df, aes(x=factor(CONDITION), 
                     y=gpt2French_sum, 
                     fill=factor(CONDITION))) +
  geom_boxplot(alpha=0.7) +
  stat_summary(fun.y=mean, geom="point", shape=20, size=7, color="yellow", fill="yellow") +
  scale_fill_brewer(palette="Purples") + 
  theme_classic()+
  theme(axis.text.x = element_text(face="bold", color="#993333", 
                                   size=12, angle=360),
        axis.text.y = element_text(face="bold", color="#993333", 
                                   size=12, angle=360),
        axis.title.x = element_blank(),
        axis.title.y = element_text(size=12,face="bold")) + 
  scale_x_discrete(labels=c("A", "B", "C", "D")) +
  ylab("French Surp-Sum Contrastive") +
  theme(legend.position="none")
p12


##############
library(gridExtra)
p = grid.arrange(p2, p4,
                 p6, p8,
                 p10, p12, nrow = 3)
p

ggsave('xk.boxplots.xling.sum.png',p,width=14,height=15,dpi=300)
