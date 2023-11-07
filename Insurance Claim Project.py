#!/usr/bin/env python
# coding: utf-8

# In[72]:


import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt


# In[52]:


df = pd.read_csv(r'/Users/Jenna/Desktop/Python/insurance_data.csv')
df


# In[22]:


df.info()


# In[77]:


#Looking at the data in depth
df.describe(include='all').round(0)


# In[5]:


#Checking for null values
df.isnull().sum


# In[78]:


#Checking the shape of the dataset
print("The number of rows and number of columns are ", df.shape)


# In[79]:


#Checking for labels in categorical columns
for col in df.columns:
    if df[col].dtype=='object':
        print()
        print(col)
        print(df[col].unique())


# In[9]:


df.sort_values(by = 'claim', ascending=False).head(1)


# In[10]:


df.sort_values(by = 'claim', ascending=True).head(1)


# In[26]:


df.groupby('gender').count()


# In[57]:


df.groupby('region').count()


# In[80]:


pd.crosstab(df['region'], df['gender'], margins = True, margins_name = "Total").sort_values(by="Total", ascending=True)


# In[58]:


df.groupby('gender').agg({'claim': ['mean', 'max', 'min', 'count', 'sum']})


# In[59]:


df.groupby('gender').agg({'bloodpressure': ['mean', 'max', 'count', 'sum'], 'bmi': ['mean', 'max', 'count', 'sum'], 'claim': ['mean', 'max', 'count', 'sum']})


# In[70]:


sns.boxenplot(x='gender', y='age', data=df).set(title='Number of Insurance Claims by Gender, by Age')


# In[73]:


sns.boxplot(x="region", y="claim",hue="gender",data=df).set(title='Claim Value by Region, by Gender')
sns.despine(offset=10, trim=True)
plt.legend(bbox_to_anchor=(1.02, 1), loc='best', borderaxespad=0)

