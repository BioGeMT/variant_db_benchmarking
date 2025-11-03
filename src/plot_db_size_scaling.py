import matplotlib.pyplot as plt
import pandas as pd
import scienceplots

plt.style.use('science')

df = pd.read_csv('data/db_sizes.csv')

solutions = df['solution'].unique()
sample_percentages = [1, 10, 50, 100]

fig, ax = plt.subplots()

for solution in solutions:
    solution_data = df[df['solution'] == solution]
    ax.plot(solution_data['sample_percentage'], solution_data['db_size_gb'], marker='o', markersize=4, label=solution)

ax.set_xlabel('Sample Percentage (\%)')
ax.set_ylabel('Database Size (GB)')
ax.legend(fontsize=7)
ax.set_xticks(sample_percentages)
ax.grid(True, alpha=0.3)

plt.tight_layout()
plt.savefig('plots/db_size_scaling.png', dpi=300)
