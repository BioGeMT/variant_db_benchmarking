import matplotlib.pyplot as plt
import pandas as pd
import scienceplots

plt.style.use('science')

df = pd.read_csv('data/ingestion_indexing_subsamples.csv')

solutions = df['solution'].unique()
sample_percentages = [1, 10, 50, 100]

# Ingestion plot
fig1, ax1 = plt.subplots()

for solution in solutions:
    solution_data = df[df['solution'] == solution]
    ingestion_hours = solution_data['ingestion'].div(3600)
    ax1.plot(solution_data['sample_percentage'], ingestion_hours, marker='o', markersize=4, label=solution)

ax1.set_xlabel('Sample Percentage (\%)')
ax1.set_ylabel('Hours')
ax1.legend(fontsize=7)
ax1.set_xticks(sample_percentages)
ax1.grid(True, alpha=0.3)

plt.tight_layout()
plt.savefig('plots/ingestion_scaling.png', dpi=300)

# Indexing plot
fig2, ax2 = plt.subplots()

for solution in solutions:
    solution_data = df[df['solution'] == solution]
    indexing_hours = solution_data['indexing'].div(3600)
    ax2.plot(solution_data['sample_percentage'], indexing_hours, marker='o', markersize=4, label=solution)

ax2.set_xlabel('Sample Percentage (\%)')
ax2.set_ylabel('Hours')
ax2.legend(fontsize=7)
ax2.set_xticks(sample_percentages)
ax2.grid(True, alpha=0.3)

plt.tight_layout()
plt.savefig('plots/indexing_scaling.png', dpi=300)
