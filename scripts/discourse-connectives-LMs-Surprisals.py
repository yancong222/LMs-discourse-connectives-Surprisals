# title: On the Influence of Discourse Connectives on the Predictions of Humans and Language Models: The Role of Event Knowledge
# author: Britton, Cong, Chersoni, Hsu, and Blache
# on July 2024

import pandas as pd
import numpy as np
# !pip install minicons
from minicons import scorer

# load NLMs
model2Italian = scorer.IncrementalLMScorer('LorenzoDeMattei/GePpeTto', 'cuda')
gpt2Chinese = scorer.IncrementalLMScorer('uer/gpt2-chinese-cluecorpussmall', 'cuda')
gpt2French = scorer.IncrementalLMScorer('dbddv01/gpt2-french-small', 'cuda') 

# utility functions
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

def target_surprisal_avg(model, sentence, target):
  temp = []
  temp.append(sentence)
  surp = model.token_score(temp, surprisal = True, base_two = True)
  tuple_list = surp[0]
  result = [y[1] for x, y in enumerate(tuple_list) if y[0] == target]
  if len(result) == 0:
    result = [y[1] for x, y in enumerate(tuple_list) if y[0] in target]
  return round(np.nanmean(result), 2)

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

##Italian dataset
data = ('/your input folder/')
output = ('/your output folder/')
df = pd.read_csv(data + 'Italian_data.csv', index_col = 0)
df['Ita_target_surprisal'] = df.apply(lambda x: target_surprisal_sum(model2Italian, x.SENTENCE, x.TARGET_WORD), axis=1)
df['Ita_seq_len'] = df.apply(lambda x: get_tokens_len_score(x.SENTENCE, model2Italian), axis=1)
df['Ita_target_OOV'] = df.apply(lambda x: target_oov(model2Italian, x.SENTENCE, x.TARGET_WORD), axis=1)
df.to_csv(output + 'Ita_results.csv')
df.head()

##Chinese dataset
cols = ['gpt2Chinese_avg',
        'gpt2Chinese_sum']
for col in cols:
  if 'avg' in col and 'gpt2' in col:
    chi[col] = chi.apply(lambda x: target_surprisal_avg(gpt2Chinese, x['SENTENCE'],
                                                            x['TARGET_WORD']), axis=1)
  if 'sum' in col and 'gpt2' in col:
    chi[col] = chi.apply(lambda x: target_surprisal_sum(gpt2Chinese, x['SENTENCE'],
                                                            x['TARGET_WORD']), axis=1)
  chi.to_csv(output + 'Chi_results.csv')
  print('finished: ', col)

cols = ['gpt2Chinese_tokens_len']
for col in cols:
  if 'gpt2' in col:
    chi[col] = chi.apply(lambda x: get_tokens_len_score(x['SENTENCE'], gpt2Chinese), axis=1)
  chi.to_csv(output + 'Chi_results.csv')
  print('finished: ', col)
chi

chi['Chi_target_OOV'] = df.apply(lambda x: target_oov(gpt2Chinese, x.SENTENCE, x.TARGET_WORD), axis=1)
chi.to_csv(output + 'Chi_results.csv')

