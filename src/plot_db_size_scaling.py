import matplotlib.pyplot as plt
import pandas as pd
import scienceplots

plt.style.use('science')
plt.rcParams['axes.prop_cycle'] = plt.cycler(color=['#785ef0', '#fe6100', '#dc267f', '#ffb000', '#648fff'])

markers = ['o', 's', '^', 'D', 'v', 'P', 'X']
linestyles = ['-', '--', '-.', ':', '-', '--', '-.']

df = pd.read_csv('data/db_sizes.csv')

solutions = df['solution'].unique()
sample_percentages = [1, 10, 50, 100]

fig, ax = plt.subplots()

for i, solution in enumerate(solutions):
    solution_data = df[df['solution'] == solution]
    lw, ms = (2, 6) if solution == 'vcf2db' else (1, 4)
    ax.plot(solution_data['sample_percentage'], solution_data['db_size_gb'], marker=markers[i % len(markers)], linestyle=linestyles[i % len(linestyles)], markersize=ms, linewidth=lw, label=solution)

ax.set_xlabel('Sample Percentage (\%)')
ax.set_ylabel('Database Size (GB)')
ax.legend(fontsize=7)
ax.set_xticks(sample_percentages)
ax.grid(True, alpha=0.3)

plt.tight_layout()
plt.savefig('plots/db_size_scaling.png', dpi=300, bbox_inches='tight')
plt.close()
