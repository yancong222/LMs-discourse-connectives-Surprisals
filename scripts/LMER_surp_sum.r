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

## inter surp
gpt2Italian_avg = lmer(gpt2Italian_avg~ Plausibility*Connective + gpt2Italian_tokens_len + (1|ITEM_ID), data = df)
summary(gpt2Italian_avg) 
gpt2Italian_sum = lmer(gpt2Italian_sum~ Plausibility*Connective + gpt2Italian_tokens_len + (1|ITEM_ID), data = df)
summary(gpt2Italian_sum)

model2Italian_avg = lmer(model2Italian_avg ~ Plausibility*Connective + gpt2Italian_tokens_len + (1|ITEM_ID), data = df)
summary(model2Italian_avg) 
model2Italian_sum = lmer(model2Italian_sum ~ Plausibility*Connective + gpt2Italian_tokens_len + (1|ITEM_ID), data = df)
summary(model2Italian_sum)

# getting pairwise comparisons
library(emmeans)
# the pairwise comparisons with Tukey adjustment 
# were carried out by the EMMEANS package

## inter surp
gpt2Italian_avg.emm = emmeans(gpt2Italian_avg, specs = pairwise~Plausibility:Connective)
summary(gpt2Italian_avg.emm)
gpt2Italian_sum.emm = emmeans(gpt2Italian_sum, specs = pairwise~Plausibility:Connective)
summary(gpt2Italian_sum.emm)

model2Italian_avg.emm = emmeans(model2Italian_avg, specs = pairwise~Plausibility:Connective)
summary(model2Italian_avg.emm)
model2Italian_sum.emm = emmeans(model2Italian_sum, specs = pairwise~Plausibility:Connective)
summary(model2Italian_sum.emm)

