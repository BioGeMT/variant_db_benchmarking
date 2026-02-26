import matplotlib.pyplot as plt
import pandas as pd
import scienceplots

plt.style.use('science')
plt.rcParams['axes.prop_cycle'] = plt.cycler(color=['#ffb000', '#fe6100', '#dc267f', '#785ef0', '#648fff'])

markers = ['o', 's', '^', 'D', 'v', 'P', 'X']

queries = ['query1', 'query2', 'query3', 'query4', 'query5', 'query6', 'query7']

solutions = None

for query in queries:
    df = pd.read_csv(f'data/queries/{query}_subsamples.csv')

    if solutions is None:
        solutions = df['solution'].unique()

    sample_percentages = [1, 10, 50, 100]

    for scale_type in ['log', 'linear']:
        # Cold cache plot
        fig1, ax1 = plt.subplots()

        for i, solution in enumerate(solutions):
            solution_data = df[(df['solution'] == solution) & (df['cache'] == 'cold')]
            cold_means = solution_data.groupby('sample_percentage')['timing'].mean()
            ax1.plot(cold_means.index, cold_means.values, marker=markers[i % len(markers)], markersize=4, label=solution)

        ax1.set_xlabel('Sample Percentage (\%)')
        ax1.set_ylabel('Time (s)')
        if scale_type == 'log':
            ax1.set_yscale('log')
        ax1.set_xticks(sample_percentages)
        ax1.grid(True, alpha=0.3)

        plt.tight_layout()
        plt.savefig(f'plots/queries/{query}_scaling_cold_{scale_type}.png', dpi=300, bbox_inches='tight')
        plt.close()

        # Warm cache plot
        fig2, ax2 = plt.subplots()

        for i, solution in enumerate(solutions):
            solution_data = df[(df['solution'] == solution) & (df['cache'] == 'warm')]
            warm_means = solution_data.groupby('sample_percentage')['timing'].mean()
            ax2.plot(warm_means.index, warm_means.values, marker=markers[i % len(markers)], markersize=4, label=solution)

        ax2.set_xlabel('Sample Percentage (\%)')
        ax2.set_ylabel('Time (s)')
        if scale_type == 'log':
            ax2.set_yscale('log')
        ax2.set_xticks(sample_percentages)
        ax2.grid(True, alpha=0.3)

        plt.tight_layout()
        plt.savefig(f'plots/queries/{query}_scaling_warm_{scale_type}.png', dpi=300, bbox_inches='tight')
        plt.close()

# Standalone legend
fig_leg, ax_leg = plt.subplots()
for i, solution in enumerate(solutions):
    ax_leg.plot([], [], marker=markers[i % len(markers)], markersize=4, label=solution)
legend = ax_leg.legend(ncol=1, loc='center', fontsize=7, frameon=True)
ax_leg.set_axis_off()
fig_leg.set_size_inches(legend.get_window_extent().width / fig_leg.dpi,
                        legend.get_window_extent().height / fig_leg.dpi)
plt.savefig('plots/queries/scaling_legend.png', dpi=300, bbox_inches='tight')
plt.close()
