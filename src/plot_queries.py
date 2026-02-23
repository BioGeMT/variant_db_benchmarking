import matplotlib.pyplot as plt
import pandas as pd
import numpy as np
import scienceplots

plt.style.use('science')

queries = ['query1', 'query2', 'query3', 'query4', 'query5', 'query6', 'query7']

for query in queries:
    df = pd.read_csv(f'data/queries/{query}.csv')

    solutions = df['solution'].unique()
    cold_means = []
    warm_means = []

    for solution in solutions:
        cold_data = df[(df['solution'] == solution) & (df['cache'] == 'cold')]['timing']
        warm_data = df[(df['solution'] == solution) & (df['cache'] == 'warm')]['timing']
        cold_means.append(cold_data.mean())
        warm_means.append(warm_data.mean())

    x = np.arange(len(solutions))
    width = 0.25

    for scale_type in ['log', 'linear']:
        fig, ax = plt.subplots()

        ax.bar(x - width/2, cold_means, width, label='Cold')
        ax.bar(x + width/2, warm_means, width, label='Warm')

        ax.set_ylabel('Time (s)')
        if scale_type == 'log':
            ax.set_yscale('log')
        ax.set_xticks(x)
        ax.set_xticklabels(solutions)
        ax.legend(loc='upper left', fontsize='small', handlelength=1, handletextpad=0.5)

        plt.xticks(rotation=45)
        plt.tight_layout()
        plt.savefig(f'plots/queries/{query}_{scale_type}.png', dpi=300)
        plt.close()
