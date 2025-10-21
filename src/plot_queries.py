import matplotlib.pyplot as plt
import pandas as pd
import numpy as np
import scienceplots

plt.style.use('science')

queries = ['query1', 'query2', 'query3', 'query4']

for query in queries:
    df = pd.read_csv(f'data/{query}.csv')

    solutions = df['solution'].unique()
    cold_means = []
    warm_means = []

    for solution in solutions:
        cold_data = df[(df['solution'] == solution) & (df['cache'] == 'cold')]['timing']
        warm_data = df[(df['solution'] == solution) & (df['cache'] == 'warm')]['timing']
        cold_means.append(cold_data.mean())
        warm_means.append(warm_data.mean())

    fig, ax = plt.subplots()
    x = np.arange(len(solutions))
    width = 0.25

    ax.bar(x - width/2, cold_means, width, label='Cold')
    ax.bar(x + width/2, warm_means, width, label='Warm')

    ax.set_ylabel('Time (s)')
    ax.set_yscale('log')
    ax.set_xticks(x)
    ax.set_xticklabels(solutions)
    ax.legend(loc='upper left', fontsize='small', handlelength=1, handletextpad=0.5)

    plt.xticks(rotation=45)
    plt.tight_layout()
    plt.savefig(f'plots/{query}.png', dpi=300)
    plt.close()
