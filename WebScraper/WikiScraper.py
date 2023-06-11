import pandas as pd #data analysis library

url = "https://en.wikipedia.org/wiki/List_of_prime_ministers_of_Canada"
df = pd.read_html(url,match='Term of office')
df = df[0]

#Cleaning data
df.drop(['No.','Portrait','Electoral mandates (Assembly)','Riding','Cabinet','Ref.'], axis=1, inplace=True)
df.rename(columns={'Name (Birth–Death)':'Name'},inplace=True)
df['Name'] = df['Name'].str.replace(r'\(.*\)', '', regex=True)
df = df.reset_index(drop=True)

df.to_csv('primeMinistersTbl.csv', index=False)
print(df)
