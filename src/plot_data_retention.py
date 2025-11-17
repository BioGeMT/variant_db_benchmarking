import matplotlib.pyplot as plt
import pandas as pd
import numpy as np
import scienceplots

plt.style.use('science')

categories = ['variants', 'genotypes', 'annotations']
data_by_category = {}

for category in categories:
    df = pd.read_csv(f'data/data_retention/{category}.csv')
    solutions = df['solution'].values
    retention_counts = df.drop('solution', axis=1).apply(lambda row: row.sum(), axis=1).values
    total_fields = len(df.columns) - 1
    data_by_category[category] = {
        'solutions': solutions,
        'counts': retention_counts,
        'total': total_fields
    }

fig, axes = plt.subplots(1, 3, figsize=(12, 4), sharey=True)

for idx, (category, ax) in enumerate(zip(categories, axes)):
    data = data_by_category[category]
    solutions = data['solutions']
    counts = data['counts']
    total = data['total']

    y_pos = np.arange(len(solutions))

    ax.barh(y_pos, counts)
    ax.set_xlabel('Fields Retained')
    ax.set_yticks(y_pos)
    ax.set_yticklabels(solutions)
    ax.set_xlim(0, total * 1.15)
    ax.set_title(category.capitalize())
    ax.grid(True, alpha=0.3, axis='x')

    for i, count in enumerate(counts):
        ax.text(count, i, f' {int(count)}/{total}', va='center', fontsize=7)

plt.tight_layout()
plt.savefig('plots/data_retention.png', dpi=300, bbox_inches='tight')
plt.close()
