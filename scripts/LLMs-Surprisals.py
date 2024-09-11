# title: On the Influence of Discourse Connectives on the Predictions of Humans and Language Models: The Role of Event Knowledge
# author: Britton, Cong, Chersoni, Hsu, and Blache
# on Sep 2024

import pandas as pd
import numpy as np
# !pip install minicons
from minicons import scorer

# load all the NLMs
model2Italian = scorer.IncrementalLMScorer('LorenzoDeMattei/GePpeTto', 'cuda')
gpt2Italian = scorer.IncrementalLMScorer('GroNLP/gpt2-small-italian', 'cuda') 
llama2Italian7B = scorer.IncrementalLMScorer('swap-uniba/LLaMAntino-2-7b-hf-ITA', 'cuda') 
gpt2Chinese = scorer.IncrementalLMScorer('uer/gpt2-chinese-cluecorpussmall', 'cuda')
llama2Chinese7B = scorer.IncrementalLMScorer('hfl/chinese-llama-2-7b', 'cuda')

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
    if not isinstance(target, (list, tuple, str)):
        target = [target]
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
df.to_csv(output + 'results.csv')

## Recycle the Italian code snippets and run them on Chinese dataset
