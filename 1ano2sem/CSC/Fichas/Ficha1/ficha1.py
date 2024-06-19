import pandas as pd
import numpy as np


df = pd.read_csv("flights_dataset.csv")

#print(df.info())

df.drop(['hour','minute','tailnum'], axis=1, inplace=True)
#infer objects type
df.infer_objects()
#check and replace missing with -99 (masking)
#print(df.isnull().sum())
#print('--------')
df.fillna(-99, inplace=True)
#frequency distribution of categories within a feature
#print(df['dest'].unique())
#print('Unique count: %d' %df['dest'].value_counts().count())
#print('--------')
#print(df['dest'].value_counts())
#print('--------')
'''
Function to encode all non-(int/float) features in a dataframe.
For each column, if its dtype is neither int or float, get the list of unique values,
store the relation between the label and the integer that encodes it and apply it.
Return a labelled dataframe and a dictionary label to be able to restore the original value.
(8-10 lines - you may need an auxiliar function)
TODO
'''




def label_encoding(df):

    dic = {}

    obj_list = ['carrier', 'origin', 'dest']

    for obj in obj_list:
       i = 0
       dic[obj] = {}
       vals = df[obj].unique()
       for val in vals:
            dic[obj][val] = i
            i+=1

    df_encoded = df.copy()

    for col in df.columns:
        if col in obj_list:
           df_encoded[col] = df[col].map(dic[col])

    return df_encoded, dic
'''
Function to decode what was previously encoded - get the original value!
(5-8 lines - you may need an auxiliar function)
TODO
'''

def inverte_dic(dic):
      res = {}

      for k, v in dic.items():
         res[v] = k
      
      return res
   
   
def label_decoding(df_labelled, label_dictionary):

   df_res = df_labelled.copy()

   for col in df_labelled.columns:
       if col in label_dictionary:
           df_res[col] = df_labelled[col].map(inverte_dic(label_dictionary[col]))
   
   return df_res



df_labelled, label_dictionary = label_encoding(df)
print(df_labelled[['carrier', 'origin', 'dest']])
#print(df_labelled['dest'].unique())
#print('Unique count after Label Encoding: %d' %df_labelled['dest'].value_counts().count())

df_labelled_decoded = label_decoding(df_labelled, label_dictionary)
print(df_labelled_decoded[['carrier', 'origin', 'dest']])
#print(df_labelled_decoded['dest'].unique())
#print('Unique count after dec.: %d' %df_labelled_decoded['dest'].value_counts().count())
#print('--------')
'''
#Use a pandas' function to apply one-hot encoding to the origin column (one line)
'''
'''
print('Unique Origin:', df['origin'].unique())
print(df.columns.values)
#df_pandas_ohe = TODO
#print(df_pandas_ohe.head())
'''