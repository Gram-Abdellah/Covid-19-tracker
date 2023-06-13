
# In[2]:


# In[4]:


import pandas as ps


# In[13]:


df=ps.read_csv('vaccination-data.csv')
df


# In[16]:


df['TOTAL_VACCINATIONS'] =df['TOTAL_VACCINATIONS'].abs()
df['PERSONS_VACCINATED_1PLUS_DOSE'] =df['PERSONS_VACCINATED_1PLUS_DOSE'].abs()
df['PERSONS_FULLY_VACCINATED'] =df['PERSONS_FULLY_VACCINATED'].abs()


# In[25]:


# select null values
df[df['TOTAL_VACCINATIONS'].isnull()]


# In[29]:


#Which countries have the highest and lowest vaccination coverage rates?
highest_vacc_countries = df[df['TOTAL_VACCINATIONS'] == df['TOTAL_VACCINATIONS'].max()]['COUNTRY']
lowest_vacc_countries = df[df['TOTAL_VACCINATIONS'] == df['TOTAL_VACCINATIONS'].min()]['COUNTRY']

print("Countries with the highest vaccination coverage:")
print(highest_vacc_countries)

print("\nCountries with the lowest vaccination coverage:")
print(lowest_vacc_countries)


# In[33]:


# How does the vaccination coverage vary across different WHO regions?
sum_vaccination_per_region = df.groupby('WHO_REGION')['PERSONS_FULLY_VACCINATED'].sum()

print(sum_fully_vaccinated_per_region)


# In[34]:


# What is the average vaccination coverage globally and by region?
global_average_coverage = df['TOTAL_VACCINATIONS'].mean()
average_coverage_by_region = df.groupby('WHO_REGION')['TOTAL_VACCINATIONS'].mean()

print("Global Average Vaccination Coverage:", global_average_coverage)
print("\nAverage Vaccination Coverage by Region:")
print(average_coverage_by_region)


# In[37]:


# import infection and deaths data 
df2=ps.read_csv('Covid 19\WHO-COVID-19-global-data.csv')
df2


# In[43]:


# Is there a correlation between the number of vaccinations administered and the decrease in new cases or deaths?
correlation_vaccinations_cases = (df['TOTAL_VACCINATIONS']).corr(df2['New_cases'])
correlation_vaccinations_deaths = (df['TOTAL_VACCINATIONS']).corr(df2['New_deaths'])
print("Correlation between Vaccinations and New Cases:", correlation_vaccinations_cases)
print("Correlation between Vaccinations and New Deaths:", correlation_vaccinations_deaths)


# In[ ]:





# In[65]:


# How does the new cases to the number of deaths relate?
import matplotlib.pyplot as plt

# Assuming you have a DataFrame named 'df' containing vaccination data and COVID-19 data
vaccination_coverage = df['TOTAL_VACCINATIONS']
new_cases = df2['New_cases']
new_deaths = df2['New_deaths']

# Create a scatter plot for Vaccination Coverage vs. New Cases
plt.scatter(new_deaths, new_cases)
plt.xlabel('Deaths rate')
plt.ylabel('New Cases')
plt.title('Deaths rate vs. New Cases')
plt.show()


# In[73]:


# Are there any notable differences in COVID-19 outcomes between highly vaccinated and less vaccinated countries?
top_countries = df.nlargest(5, 'TOTAL_VACCINATIONS')
bottom_countries = df.nsmallest(5, 'TOTAL_VACCINATIONS')

plt.figure(figsize=(10, 6))

# Plotting the top countries
plt.bar(top_countries['COUNTRY'], top_countries['TOTAL_VACCINATIONS'], color='green', label='Top 5')

# Plotting the bottom countries
plt.bar(bottom_countries['COUNTRY'], bottom_countries['TOTAL_VACCINATIONS'], color='red', label='Bottom 5')

plt.xlabel('Countries')
plt.ylabel('Vaccination Count')
plt.title('Vaccination Count per Country (Top 5 and Bottom 5)')
plt.legend()
plt.xticks(rotation=45)
plt.tight_layout()
plt.show()


# In[88]:


# COVID-19 data with columns 'Date' and 'Deaths'
df2['Date_reported'] = ps.to_datetime(df2['Date_reported'])  # Convert 'Date' column to datetime if it's not already in datetime format

plt.figure(figsize=(10, 6))

plt.plot(df2['Date_reported'], df2['New_deaths'].abs(), color='blue')
plt.axvline(x=ps.to_datetime('2021-12-01'), color='red', linestyle='--', label='Marked Date')

plt.xlabel('Date')
plt.ylabel('Number of Deaths')
plt.title('Death Cases Over Time')
plt.xticks(rotation=45)
plt.tight_layout()
plt.show()


# In[100]:


# How has the vaccination coverage and COVID-19 situation changed over time?plt.figure(figsize=(10, 6))

# Plotting vaccination coverage over time
plt.plot(df['DATE_UPDATED'], df['TOTAL_VACCINATIONS'].cumsum(), label='Vaccination Coverage')


plt.xlabel('Date')
plt.ylabel('Vaccinations')
plt.title('Changes in Vaccination Coverage  Over Time')
plt.legend()
plt.xticks(rotation=2)
plt.tight_layout()
plt.show()


# In[ ]:




