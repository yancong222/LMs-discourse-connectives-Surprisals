# title: On the Influence of Discourse Connectives on the Predictions of Humans and Language Models: The Role of Event Knowledge
# author: Britton, Cong, Chersoni, Hsu, and Blache
# on Sep 2024

library(ggplot2)
mydata = read.csv('ita_data.csv', header = TRUE)
df = mydata[, c('ITEM_ID', 
                'CONDITION', 
                'Plausibility', 
                'Connective',
                'TARGET_WORD',
                'SENT_COND', 
                'gpt2Italian_sum', 
                'gpt2Italian_tokens_len')]

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
mydata = read.csv('chi_data_surp.csv', header = TRUE)
df = mydata[, c('ITEM_ID', 
                'CONDITION', 
                'Plausibility', 
                'Connective',
                'TARGET_WORD',
                'gpt2Chinese_sum', 
                'gpt2Chinese_tokens_len')]

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

# same code structure recycles for other datasets
############################

library(gridExtra)
p = grid.arrange(p2, p4,
                 p6, p8,
                 p10, p12, nrow = 3)
p

ggsave('boxplots.xling.sum.png',p,width=14,height=15,dpi=300)
