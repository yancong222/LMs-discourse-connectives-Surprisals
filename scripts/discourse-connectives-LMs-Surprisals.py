import pandas as pd
import numpy as np
from minicons import scorer
gpt2 = scorer.IncrementalLMScorer('gpt2', 'cuda') 
distilgpt2 = scorer.IncrementalLMScorer('distilgpt2', 'cuda')
gptneo = scorer.IncrementalLMScorer('EleutherAI/gpt-neo-1.3B', 'cuda')

gpt2Italian = scorer.IncrementalLMScorer('GroNLP/gpt2-small-italian', 'cuda')
gpt2Chinese = scorer.IncrementalLMScorer('uer/gpt2-chinese-cluecorpussmall', 'cuda')
gpt2French = scorer.IncrementalLMScorer('dbddv01/gpt2-french-small', 'cuda') 

def target_surprisal(model, sentence, target):
  temp = []
  temp.append(sentence)
  surp = model.token_score(temp, surprisal = True, base_two = True)
  tuple_list = surp[0]
  result = [y[1] for x, y in enumerate(tuple_list) if y[0] == target]
  if len(result) == 0:
    result = [y[1] for x, y in enumerate(tuple_list) if y[0] in target]
  return round(np.nanmean(result), 2)

def target_surprisal_sum(model, sentence, target):
  temp = []
  temp.append(sentence)
  surp = model.token_score(temp, surprisal = True, base_two = True)
  tuple_list = surp[0]
  result = [y[1] for x, y in enumerate(tuple_list) if y[0] == target]
  if len(result) == 1:
    return round(np.nansum(result), 2)
  else:
    result = [y[1] for x, y in enumerate(tuple_list) if y[0] in target]
    return round(np.nansum(result[:-1]), 2) 

def get_tokens_len_score(sent, model):
  input = []
  input.append(sent)
  output = model.token_score(input, surprisal = True, base_two = True)
  result = []
  return len(output[0])

def target_oov(model, sentence, target):

  temp = []
  temp.append(sentence)
  surp = model.token_score(temp, surprisal = True, base_two = True)
  tuple_list = surp[0]
  result = [y[1] for x, y in enumerate(tuple_list) if y[0] == target]
  if len(result) == 1:
    return 0
  else:
    return 1

data = ('/your input folder/')
output = ('/your output folder/')
df = pd.read_csv(data + 'xiang_kuperberg_eng2_surprisals_evenso_however_stats2.csv', index_col = 0)
df['gpt2_target_surprisal'] = df.apply(lambda x: target_surprisal(gpt2, x.SENTENCE, x.TARGET_WORD), axis=1)
df['distilgpt2_target_surprisal'] = df.apply(lambda x: target_surprisal(distilgpt2, x.SENTENCE, x.TARGET_WORD), axis=1)
df['gptneo_target_surprisal'] = df.apply(lambda x: target_surprisal(gptneo, x.SENTENCE, x.TARGET_WORD), axis=1)
df.to_csv(output + 'xiang_kuperberg_eng2_surprisals_evenso_however_stats2.csv')
df.head()
