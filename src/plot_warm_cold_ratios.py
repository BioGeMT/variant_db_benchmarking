import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
import scienceplots

plt.style.use('science')

# ----------------------------------------------------------------------
# 1. Load data
# ----------------------------------------------------------------------
cold = pd.read_csv("data/derived_data/table1_full_dataset_cold.csv")
warm = pd.read_csv("data/derived_data/table2_full_dataset_warm.csv")

cold.set_index("query", inplace=True)
warm.set_index("query", inplace=True)

systems = ["vcf2db", "cutevariant", "VCFdbR-table", "VCFdbR-file", "vcf-miner"]
queries = ["Q1", "Q2", "Q3", "Q4", "Q5", "Q6", "Q7"]

cold = cold.reindex(queries)[systems].replace("", np.nan).astype(float)
warm = warm.reindex(queries)[systems].replace("", np.nan).astype(float)

ratio = warm / cold
ratio = ratio.replace([np.inf, -np.inf], np.nan)

# ----------------------------------------------------------------------
# 2. Prepare data for plotting
# ----------------------------------------------------------------------
ratio_long = ratio.reset_index().melt(id_vars="query", var_name="system", value_name="ratio")
ratio_long.dropna(inplace=True)

# Numeric x position of each query
x_pos = {q: i+1 for i, q in enumerate(queries)}
ratio_long["x_numeric"] = ratio_long["query"].map(x_pos)

# ----------------------------------------------------------------------
# 3. Define colours and styles for each system
# ----------------------------------------------------------------------
# Okabe-Ito colourblind-safe palette, as shipped by matplotlib
okabe_ito = plt.colormaps["okabe_ito"].colors
colour_palette = {
    "vcf2db": okabe_ito[6],        # vermillion (prominent)
    "cutevariant": okabe_ito[5],   # blue
    "VCFdbR-table": okabe_ito[3],  # bluish green
    "VCFdbR-file": okabe_ito[1],   # orange
    "vcf-miner": okabe_ito[7]      # reddish purple
}

# Make vcf2db markers larger and line thicker
marker_size = {"vcf2db": 100, "cutevariant": 70, "VCFdbR-table": 70,
               "VCFdbR-file": 70, "vcf-miner": 70}
line_width = {"vcf2db": 2.5, "cutevariant": 1.2, "VCFdbR-table": 1.2,
              "VCFdbR-file": 1.2, "vcf-miner": 1.2}
alpha_value = 0.7

# ----------------------------------------------------------------------
# 4. Create figure
# ----------------------------------------------------------------------
fig, ax = plt.subplots(figsize=(10, 6))

# Plot lines first (so they are behind markers)
# Use the wide table so missing values (NaN) break the line instead of being bridged
for sys in systems:
    ax.plot(ratio.index.map(x_pos), ratio[sys],
            color=colour_palette[sys], linewidth=line_width[sys],
            alpha=alpha_value, marker='', linestyle='-')

# Then scatter points
for sys in systems:
    sys_data = ratio_long[ratio_long["system"] == sys]
    ax.scatter(sys_data["x_numeric"], sys_data["ratio"],
               s=marker_size[sys], color=colour_palette[sys],
               alpha=alpha_value, edgecolors='none', label=sys)

# ----------------------------------------------------------------------
# 5. Axes formatting and reference lines
# ----------------------------------------------------------------------
ax.set_yscale("log")
ax.set_ylabel("Warm / cold runtime ratio (log scale)", fontsize=12)
ax.set_xticks(np.arange(1, len(queries)+1))
ax.set_xticklabels(queries, fontsize=10)

# Reference lines
ax.axhline(y=1.0, color="gray", linestyle="--", linewidth=1.2, alpha=0.7)
ax.axhline(y=0.1, color="lightgray", linestyle=":", linewidth=1, alpha=0.7)

# ----------------------------------------------------------------------
# 6. Vertical separators and workload labels
# ----------------------------------------------------------------------
ax.axvline(x=3.5, color="black", linestyle="-", linewidth=0.8, alpha=0.5)
ax.axvline(x=5.5, color="black", linestyle="-", linewidth=0.8, alpha=0.5)

group_labels = ["Lightweight retrieval\n\\& annotation filtering",
                "Genotype retrieval\n\\& analytical queries",
                "Aggregation-heavy\nworkloads"]
group_positions = [2.0, 4.5, 6.5]
for pos, label in zip(group_positions, group_labels):
    ax.text(pos, -0.06, label, transform=ax.get_xaxis_transform(),
            ha="center", va="top", fontsize=9, style="italic")

# ----------------------------------------------------------------------
# 7. Legend, title, grid, layout
# ----------------------------------------------------------------------
ax.legend(title="System", bbox_to_anchor=(1.05, 1), loc='upper left')
ax.set_ylim(0.01, 2)
ax.grid(axis="y", linestyle=":", alpha=0.4)

plt.tight_layout(rect=[0, 0, 0.85, 1])

# ----------------------------------------------------------------------
# 8. Save figure
# ----------------------------------------------------------------------
plt.savefig("plots/paper_figures/warm_cold_ratio_scatter.png", dpi=300, bbox_inches="tight")
plt.savefig("plots/paper_figures/warm_cold_ratio_scatter.pdf", bbox_inches="tight")
plt.show()