import matplotlib.pyplot as plt
import pandas as pd
import scienceplots

plt.style.use('science')

queries = ['query1', 'query2', 'query3', 'query4', 'query5']

for query in queries:
    df = pd.read_csv(f'data/queries/{query}_subsamples.csv')

    solutions = df['solution'].unique()
    sample_percentages = [1, 10, 50, 100]

    # Cold cache plot
    fig1, ax1 = plt.subplots()

    for solution in solutions:
        solution_data = df[(df['solution'] == solution) & (df['cache'] == 'cold')]
        cold_means = solution_data.groupby('sample_percentage')['timing'].mean()
        ax1.plot(cold_means.index, cold_means.values, marker='o', markersize=4, label=solution)

    ax1.set_xlabel('Sample Percentage (\%)')
    ax1.set_ylabel('Time (s)')
    ax1.set_yscale('log')
    ax1.legend(fontsize=7, bbox_to_anchor=(1.05, 1), loc='upper left')
    ax1.set_xticks(sample_percentages)
    ax1.grid(True, alpha=0.3)

    plt.tight_layout()
    plt.savefig(f'plots/queries/{query}_scaling_cold.png', dpi=300, bbox_inches='tight')

    # Warm cache plot
    fig2, ax2 = plt.subplots()

    for solution in solutions:
        solution_data = df[(df['solution'] == solution) & (df['cache'] == 'warm')]
        warm_means = solution_data.groupby('sample_percentage')['timing'].mean()
        ax2.plot(warm_means.index, warm_means.values, marker='o', markersize=4, label=solution)

    ax2.set_xlabel('Sample Percentage (\%)')
    ax2.set_ylabel('Time (s)')
    ax2.set_yscale('log')
    ax2.legend(fontsize=7, bbox_to_anchor=(1.05, 1), loc='upper left')
    ax2.set_xticks(sample_percentages)
    ax2.grid(True, alpha=0.3)

    plt.tight_layout()
    plt.savefig(f'plots/queries/{query}_scaling_warm.png', dpi=300, bbox_inches='tight')
