import matplotlib.pyplot as plt
import pandas as pd
import scienceplots

plt.style.use('science')

df = pd.read_csv('data/ingestion_indexing.csv')
solutions = df['solution']
ingestion = df['ingestion'].div(3600) # Seconds to hours
indexing = df['indexing'].div(3600) # Seconds to hours

fig, ax = plt.subplots()
width = 0.6

ax.bar(solutions, ingestion, width, label='Ingestion')
ax.bar(solutions, indexing, width, bottom=ingestion, label='Indexing')

ax.set_ylabel('Hours')
ax.legend()

plt.xticks(rotation=45)
plt.tight_layout()
plt.savefig('plots/ingestion_indexing.png', dpi=300)