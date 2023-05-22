import pandas as pd
import numpy as np
from minicons import scorer
gpt2 = scorer.IncrementalLMScorer('gpt2', 'cuda') 
distilgpt2 = scorer.IncrementalLMScorer('distilgpt2', 'cuda')
gptneo = scorer.IncrementalLMScorer('EleutherAI/gpt-neo-1.3B', 'cuda')

def target_surprisal(model, sentence, target):
  temp = []
  temp.append(sentence)
  surp = model.token_score(temp, surprisal = True, base_two = True)
  tuple_list = surp[0]
  result = [y[1] for x, y in enumerate(tuple_list) if y[0] == target]
  if len(result) == 0:
    result = [y[1] for x, y in enumerate(tuple_list) if y[0] in target]
  return round(np.nanmean(result), 2)

data = ('/your input folder/')
output = ('/your output folder/')
df = pd.read_csv(data + 'xiang_kuperberg_eng2_surprisals_evenso_however_stats2.csv', index_col = 0)
df['gpt2_target_surprisal'] = df.apply(lambda x: target_surprisal(gpt2, x.SENTENCE, x.TARGET_WORD), axis=1)
df['distilgpt2_target_surprisal'] = df.apply(lambda x: target_surprisal(distilgpt2, x.SENTENCE, x.TARGET_WORD), axis=1)
df['gptneo_target_surprisal'] = df.apply(lambda x: target_surprisal(gptneo, x.SENTENCE, x.TARGET_WORD), axis=1)
df.to_csv(output + 'xiang_kuperberg_eng2_surprisals_evenso_however_stats2.csv')
df.head()