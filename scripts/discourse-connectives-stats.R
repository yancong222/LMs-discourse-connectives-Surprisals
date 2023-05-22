library(lmerTest)
library(emmeans)
df = read.csv('xiang_kuperberg_eng2_surprisals_evenso_however_stats.csv')

gpt2evenso = lmer(gpt2_target_surprisal~PlausibilityEvenSo + 
                     Connective + 
                     PlausibilityEvenSo*Connective + 
                     len_tokens + 
                     (1|ITEM_ID), data = df)
summary(gpt2evenso) 
distilgpt2evenso = lmer(distilgpt2_target_surprisal~PlausibilityEvenSo + 
                          Connective +
                          PlausibilityEvenSo*Connective +
                          len_tokens + 
                          (1|ITEM_ID), data = df)
summary(distilgpt2evenso) 
gptneoevenso = lmer(gptneo_target_surprisal~PlausibilityEvenSo + 
                      Connective +
                      PlausibilityEvenSo*Connective +
                      len_tokens + (1|ITEM_ID), data = df)
summary(gptneoevenso) 
gpt2however = lmer(gpt2_however_target_surprisal~PlausibilityHowever + 
                     Connective +
                     PlausibilityHowever*Connective +
                     len_tokens + (1|ITEM_ID), data = df)
summary(gpt2however) 
distilgpt2however = lmer(distilgpt2_however_target_surprisal~PlausibilityHowever + 
                           Connective +
                           PlausibilityHowever*Connective +
                           len_tokens + (1|ITEM_ID), data = df)
summary(distilgpt2however) 
gptneohowever = lmer(gptneo_however_target_surprisal~PlausibilityHowever + 
                       Connective +
                       PlausibilityHowever*Connective +
                       len_tokens + (1|ITEM_ID), data = df)
summary(gptneohowever) 
gpt2evenso.emm = emmeans(gpt2evenso, specs = pairwise ~ PlausibilityEvenSo:Connective)
summary(gpt2evenso.emm)
distilgpt2evenso.emm = emmeans(distilgpt2evenso, specs = pairwise ~ PlausibilityEvenSo:Connective)
summary(distilgpt2evenso.emm)
gptneoevenso.emm = emmeans(gptneoevenso, specs = pairwise ~ PlausibilityEvenSo:Connective)
summary(gptneoevenso.emm)
gpt2however.emm = emmeans(gpt2however, specs = pairwise ~ PlausibilityHowever:Connective)
summary(gpt2however.emm)
distilgpt2however.emm = emmeans(distilgpt2however, specs = pairwise ~ PlausibilityHowever:Connective)
summary(distilgpt2however.emm)
gptneohowever.emm = emmeans(gptneohowever, specs = pairwise ~ PlausibilityHowever:Connective)
summary(gptneohowever.emm)