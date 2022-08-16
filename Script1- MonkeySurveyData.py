#!/usr/bin/env python
# coding: utf-8

# In[1]:


import pandas as pd


# In[2]:


import os
pwd = os.getcwd()


# In[11]:


dataset = pd.read_excel("Data1_edited.xlsx", sheet_name = "Edited_data")


# In[13]:


dataset


# In[14]:


dataset_modified = dataset.copy()


# In[15]:


dataset_modified


# In[16]:


dataset_modified.columns


# In[17]:


columns_to_drop = ['Start Date', 'End Date', 'Email Address',
       'First Name', 'Last Name', 'Custom Data 1']
columns_to_drop 


# In[19]:


dataset_modified = dataset_modified.drop(columns = columns_to_drop)


# In[20]:


dataset_modified


# In[22]:


dataset_modified.columns


# In[29]:


id_vars = list(dataset_modified.columns)[0:8]


# In[30]:


value_vars = list(dataset_modified.columns)[8:]


# In[31]:


value_vars


# In[39]:


dataset_melted = dataset_modified.melt(id_vars = id_vars, value_vars = value_vars, var_name = "Question_&_Subquestion", value_name = "Answer")


# In[40]:


dataset_melted


# In[41]:


questions = pd.read_excel("Data1_edited.xlsx", sheet_name = "Questions")


# In[42]:


questions


# In[43]:


question_import = questions.copy()


# In[45]:


question_drop = ["Raw QUESTION","Raw SUB-QUESTION","SUBQUESTION"]
question_import = question_import.drop(columns = question_drop)


# In[50]:


question_import


# In[54]:


dataset_merged = pd.merge(left=dataset_melted, right=question_import, how="left", left_on = "Question_&_Subquestion", right_on= "QUESTION+SUBQUESTION")
print("original data",len(dataset_melted))
print("merged data",len(dataset_merged))


# In[55]:


dataset_merged


# In[61]:


dataset_merged[dataset_merged["Answer"].notna()]


# In[72]:


respondents = dataset_merged[dataset_merged["Answer"].notna()]
respondents = respondents.groupby("QUESTION")["Respondent ID"].nunique().reset_index()
respondents.rename(columns = {"Respondent ID":"Respondents"}, inplace = True)


# In[73]:


respondents


# In[74]:


dataset_merged


# In[78]:


dataset_merged_two = pd.merge(left=dataset_merged, right=respondents, how="left", left_on = "QUESTION", right_on= "QUESTION")
print("original data",len(dataset_merged))
print("merged data",len(dataset_merged_two))


# In[79]:


dataset_merged_two


# In[80]:


same_answer = dataset_merged#[dataset_merged["Answer"].notna()]
same_answer =same_answer.groupby(["QUESTION+SUBQUESTION","Answer"])["Respondent ID"].nunique().reset_index()
same_answer.rename(columns = {"Respondent ID":"Same Answer"}, inplace = True)


# In[81]:


same_answer


# In[85]:


dataset_merged_three = pd.merge(left=dataset_merged_two, right=same_answer, how="left", left_on = ["QUESTION+SUBQUESTION","Answer"], right_on= ["QUESTION+SUBQUESTION","Answer"])
dataset_merged_three["Same Answer"].fillna(0,inplace = True)
print("original data",len(dataset_merged_two))
print("merged data",len(dataset_merged_three))


# In[86]:


dataset_merged_three


# In[89]:


output= dataset_merged_three.copy()
output.rename(columns = 
{"Identify which division you work in.-Response":"division_primary","Identify which division you work in.-Other (please specify)":"division_secondary","Which of the following best describes your position level?-Response":"position","Which generation are you apart of?-Response":"generation","Please select the gender in which you identify.-Response":"gender","Which duration range best aligns with your tenure at your company?-Response":"experience","Which of the following best describes your employment type?-Response":"employment type"}, inplace = True)


# In[90]:


output


# In[93]:


output.to_excel(pwd + "//Final_output.xlsx", index = False)


# In[ ]:




