#!/usr/bin/env python
# coding: utf-8

# In[67]:


import pandas as pd
import matplotlib.pyplot as plt


# In[42]:


df = pd.read_csv(r'/Users/Jenna/Desktop/mental_health_survey.csv')
df


# In[82]:


print(plt.style.available)
plt.style.use('seaborn-v0_8-muted')


# In[43]:


df.columns


# In[44]:


df = df.drop(columns = 'comments')
df


# In[45]:


df[df['country'].str.contains('United Kingdom')]


# In[46]:


# Shows the number of unique values in each column
df.nunique()


# In[47]:


# Overview of the 'age' column, given that it is the only numeric column
df.describe()


# In[48]:


# Assuming 'Year' is the column representing the year in the CSV file
# Replace 'Year' with the actual column name in your CSV file
year_counts = df['timestamp'].value_counts()

# Print the count of entries for each year
print(year_counts)


# In[ ]:


# Count entries for a specific year (e.g., 2022)
specific_year_count = year_counts.get(2022, 0)
print(f"Number of entries in 2022: {specific_year_count}")


# In[52]:


split_date = df['timestamp'].str.split('-', expand=True)
df


# In[60]:


# Function to extract the first 4 digits from a value
def extract_first_4_digits(timestamp):
    try:
        # Convert to string and then extract the first 4 digits
        first_4_digits = str(timestamp)[:4]
        # Convert back to integer if extraction is successful, otherwise return None
        return int(first_4_digits)
    except (ValueError, TypeError):
        # Handle invalid or non-numeric values
        return None

# Apply the function to the 'Column_Name' column and create a new column 'First_4_Digits'
df['Year'] = df['timestamp'].apply(extract_first_4_digits)
df


# In[61]:


df2 = df.groupby('Year')[['age']].mean().sort_values(by = "age", ascending = False)
df2


# In[62]:


df3 = df2.transpose()
df3


# In[91]:


# A bar graph displaying the mean of ages by year
df2['age'].plot(kind = 'bar', title = 'Mean Age', xlabel = 'Year', ylabel = 'Age', color = 'skyblue')


# In[76]:


# The counts of responses under a specified column: seek_help
seek_help = 'seek_help'

response_counts = df[seek_help].value_counts()
response_counts


# In[83]:


# A pie chart displaying response counts
plt.figure(figsize=(6, 6))
plt.pie(response_counts, labels=response_counts.index, autopct='%1.1f%%', startangle=140)
plt.title('Does your employer provide resources to learn more about mental health issues and how to seek help?')
plt.show()


# In[79]:


# The counts of responses under a specified column: care_options
care_options = 'care_options'

care_response_counts = df[treatment].value_counts()
care_response_counts


# In[84]:


# A pie chart displaying response counts
plt.figure(figsize=(6, 6))
plt.pie(care_response_counts, labels=care_response_counts.index, autopct='%1.1f%%', startangle=140)
plt.title('Do you know the options for mental health care your employer provides?')
plt.show()

