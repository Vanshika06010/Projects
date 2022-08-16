#!/usr/bin/env python
# coding: utf-8

# In[2]:


import pandas as pd
import numpy as np
import seaborn as sns
import matplotlib
import matplotlib.pyplot as plt
from importlib import reload
plt.style.use('ggplot')
from matplotlib.pyplot import figure

get_ipython().run_line_magic('matplotlib', 'inline')
matplotlib.rcParams['figure.figsize'] = (12,8)


# In[3]:


df = pd.read_csv(r'PythonProject.csv')


# In[4]:


df.head()


# In[5]:


# check if there is any missing data
for col in df.columns:
    missing = np.mean(df[col].isnull())
    print('{}-{}%'.format(col, missing))


# In[6]:


df = df.dropna()


# In[7]:


for col in df.columns:
    missing = np.mean(df[col].isnull())
    print('{}-{}%'.format(col, missing))


# In[8]:


# data types for columns
df.dtypes


# In[9]:


df['budget'] = df['budget'].astype('int64')


# In[10]:


df['gross'] = df['gross'].astype('int64')


# In[11]:


df.head()


# In[12]:


df['yearcorrect'] = df['released'].astype(str).str.extract(pat = '([0-9]{4})').astype(int)


# In[13]:


df


# In[14]:


df = df.sort_values(by = ['gross'], inplace = False, ascending = False)


# In[15]:


pd.set_option('display.max_rows',None)


# In[16]:


# check if there are any duplicates if yes drop it
df['company'].sort_values(ascending = False)


# In[17]:


# correlation with gross
# we can build a scatter plot
plt = reload(plt)


# In[18]:


plt.scatter(x=df['budget'],y=df['gross'])
plt.title ('budget vs gross learning')
plt.xlabel ('Gross Earning')
plt.ylabel ('Budget for film')
plt.show


# In[19]:


df.head()


# In[20]:


# plot the budget vs gross using seaborn
sns.regplot(x = 'budget', y = 'gross', data = df , scatter_kws ={"color":"red"},line_kws={"color":"blue"})


# In[21]:


df.corr(method = "pearson")


# In[22]:


# high correlation between budget and gross


# In[23]:


correlation_matrix = df.corr(method = "pearson")
sns.heatmap(correlation_matrix, annot = True)
plt.title ('correlation with numeric features ')
plt.xlabel ('Gross Earning')
plt.ylabel ('Budget for film')

plt.show()


# In[24]:


df.head()


# In[25]:


df_numeric = df
for col in df_numeric.columns:
    if(df_numeric[col].dtype == "object"):
        df_numeric[col] = df_numeric[col].astype('category')
        df_numeric[col] = df_numeric[col].cat.codes
df_numeric       


# In[26]:


df.head()


# In[27]:


correlation_matrix = df_numeric.corr(method = "pearson")
sns.heatmap(correlation_matrix, annot = True)
plt.title ('correlation with numeric features ')
plt.xlabel ('Gross Earning')
plt.ylabel ('Budget for film')

plt.show()


# In[28]:


df_numeric.corr()


# In[32]:


correlation_mat = df_numeric.corr()
corr_pairs = correlation_mat.unstack()
corr_pairs


# In[33]:


sorted_pairs = corr_pairs.sort_values()


# In[34]:


sorted_pairs


# In[36]:


high_correlation = sorted_pairs[(sorted_pairs)>0.5]


# In[37]:


high_correlation


# In[ ]:




