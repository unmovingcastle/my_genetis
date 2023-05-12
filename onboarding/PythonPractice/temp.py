import pandas as pd
import matplotlib.pyplot as plt

title = ['x', 'y']
df = pd.read_csv('CSV/real_cool_document.csv', skiprows=4, names=title) 
# df stands for Pandas DataFrame
# Since column names are passed explicitly via >>names=title,
# there is no need for >>header=None

print(df)
# or use df.to_string() to print out the entire DataFrame,

plt.scatter(df['x'], df['y'])
plt.scatter(df['x'] * SCALE, df['y'])
plt.xlabel("x")
plt.ylabel("y")
plt.legend(["non-scaled","scaled"])
plt.title("y versus x")
plt.savefig('temp.png')
plt.show()
