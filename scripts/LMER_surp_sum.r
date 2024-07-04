# title: On the Influence of Discourse Connectives on the Predictions of Humans and Language Models: The Role of Event Knowledge
# author: Britton, Cong, Chersoni, Hsu, and Blache
# on July 2024

## Italian dataset
mydata = read.csv('italian_contr_data_surp.csv', header = TRUE)
# select relevant columns
df = mydata[, c('ITEM_ID', 
                'CONDITION', 
                'Plausibility', 
                'Connective',
                'TARGET_WORD',
                'SENT_COND', 
                'gpt2Italian_avg', 
                'gpt2Italian_sum', 
                'model2Italian_avg',
                'model2Italian_sum', 
                'gpt2Italian_tokens_len', 
                'model2Italian_tokens_len')]

head(df)

psych::describe(df)

# Conducting an LME
library(lmerTest)
 
model2Italian_sum = lmer(model2Italian_sum ~ Plausibility*Connective + gpt2Italian_tokens_len + (1|ITEM_ID), data = df)
summary(model2Italian_sum)

# getting pairwise comparisons
library(emmeans)
# the pairwise comparisons with Tukey adjustment 
# were carried out by the EMMEANS package

model2Italian_sum.emm = emmeans(model2Italian_sum, specs = pairwise~Plausibility:Connective)
summary(model2Italian_sum.emm)

# Chinese dataset
mydata = read.csv('chi_data_surp.csv', header = TRUE)
# select relevant columns
df = mydata[, c('ITEM_ID', 
                'CONDITION', 
                'Plausibility', 
                'Connective',
                'TARGET_WORD',
                'gpt2Chinese_avg', 
                'gpt2Chinese_sum', 
                'gpt2Chinese_tokens_len')]

head(df)
psych::describe(df)

gpt2Chinese_sum = lmer(gpt2Chinese_sum~ Plausibility*Connective + gpt2Chinese_tokens_len + (1|ITEM_ID), data = df)
summary(gpt2Chinese_sum)

gpt2Chinese_sum.emm = emmeans(gpt2Chinese_sum, specs = pairwise~Plausibility:Connective)
summary(gpt2Chinese_sum.emm)
