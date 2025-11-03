import matplotlib.pyplot as plt
import pandas as pd
import scienceplots

plt.style.use('science')

df = pd.read_csv('data/db_sizes.csv')
df_100 = df[df['sample_percentage'] == 100]

solutions = df_100['solution']
db_sizes = df_100['db_size_gb']

fig, ax = plt.subplots()
width = 0.6

ax.bar(solutions, db_sizes, width)

ax.set_ylabel('Database Size (GB)')

plt.xticks(rotation=45)
plt.tight_layout()
plt.savefig('plots/db_size.png', dpi=300)
