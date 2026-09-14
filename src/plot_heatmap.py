import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
from matplotlib.colors import LogNorm
from matplotlib.ticker import LogFormatter
import scienceplots

plt.style.use('science')

# ----------------------------------------------------------------------
# 1. Load and prepare data
# ----------------------------------------------------------------------
cold = pd.read_csv("data/derived_data/table1_full_dataset_cold.csv")
warm = pd.read_csv("data/derived_data/table2_full_dataset_warm.csv")

cold.set_index("query", inplace=True)
warm.set_index("query", inplace=True)

systems = ["vcf2db", "cutevariant", "VCFdbR-table", "VCFdbR-file", "vcf-miner"]
queries = ["Q1", "Q2", "Q3", "Q4", "Q5", "Q6", "Q7"]

cold_data = cold.reindex(queries)[systems].replace("", np.nan).astype(float)
warm_data = warm.reindex(queries)[systems].replace("", np.nan).astype(float)

# ----------------------------------------------------------------------
# 2. Annotation formatter
# ----------------------------------------------------------------------
def fmt(val):
    return "N/A" if pd.isna(val) else f"{val:.2f}"

cold_annot = cold_data.map(fmt)
warm_annot = warm_data.map(fmt)

# ----------------------------------------------------------------------
# 3. Consistent colour scale (LogNorm)
# ----------------------------------------------------------------------
all_vals = pd.concat([cold_data.stack(), warm_data.stack()], ignore_index=True).dropna()
vmin, vmax = all_vals.min(), all_vals.max()
norm = LogNorm(vmin=vmin, vmax=vmax)

# ----------------------------------------------------------------------
# 4. Create figure and heatmaps
# ----------------------------------------------------------------------
fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(14, 6), sharey=True,
                               gridspec_kw={"width_ratios": [1, 1]})
fig.subplots_adjust(right=0.85, wspace=0.3)

# Left panel – Cold cache
sns.heatmap(cold_data, ax=ax1, annot=cold_annot, fmt="", annot_kws={"size": 9},
            cmap="viridis_r", norm=norm, cbar=False, square=False,
            xticklabels=systems, yticklabels=queries,
            linewidths=0.5, linecolor="gray", mask=cold_data.isna())

# Right panel – Warm cache
sns.heatmap(warm_data, ax=ax2, annot=warm_annot, fmt="", annot_kws={"size": 9},
            cmap="viridis_r", norm=norm, cbar=False, square=False,
            xticklabels=systems, yticklabels=False,
            linewidths=0.5, linecolor="gray", mask=warm_data.isna())

# ----------------------------------------------------------------------
# 5. Horizontal separators BETWEEN row groups (thin black lines)
#    Cell boundaries: after Q3 → y = 3.0, after Q5 → y = 5.0
# ----------------------------------------------------------------------
for ax in (ax1, ax2):
    # Workload class separators
    ax.axhline(y=3.0, color="white", linewidth=1.0, linestyle="-", clip_on=False)
    ax.axhline(y=5.0, color="white", linewidth=1.0, linestyle="-", clip_on=False)
    
    xlabels = [r"\textbf{vcf2db}" if s == "vcf2db" else s for s in systems]
    ax.set_xticklabels(xlabels, rotation=45, ha="right", fontsize=10)
    ax.set_yticks(np.arange(len(queries)) + 0.5, queries, fontsize=10)

# Emphasise 'vcf2db' column label
for ax in (ax1, ax2):
    for tick in ax.get_xticklabels():
        if tick.get_text() == r"\textbf{vcf2db}":
            tick.set_color("darkred")

# ----------------------------------------------------------------------
# 6. Workload class labels (left margin)
# ----------------------------------------------------------------------
groups = [
    ("Lightweight retrieval\n\\& annotation filtering", 1.0),   # Q1–Q3
    ("Genotype retrieval\n\\& analytical queries", 3.5),        # Q4–Q5
    ("Aggregation-heavy\nworkloads", 5.5)                     # Q6–Q7
]
for label, y in groups:
    ax1.text(-0.4, y, label, transform=ax1.get_yaxis_transform(),
             ha="right", va="center", fontsize=9, style="italic")

# ----------------------------------------------------------------------
# 7. Axes labels and panel titles
# ----------------------------------------------------------------------
ax1.set_ylabel("Queries", fontsize=12)
ax2.set_ylabel("")
ax1.set_xlabel("")
ax2.set_xlabel("")
fig.text(0.5, 0.02, "Database Systems", ha="center", fontsize=12)

ax1.text(-0.25, 1.02, r"\textbf{(A) Cold cache}", transform=ax1.transAxes,
         fontsize=14)
ax2.text(-0.25, 1.02, r"\textbf{(B) Warm cache}", transform=ax2.transAxes,
         fontsize=14)

# ----------------------------------------------------------------------
# 8. Shared colourbar (log10 scale)
# ----------------------------------------------------------------------
cbar_ax = fig.add_axes([0.88, 0.15, 0.02, 0.7])
sm = plt.cm.ScalarMappable(cmap="viridis_r", norm=norm)
sm.set_array([])
cbar = fig.colorbar(sm, cax=cbar_ax)
cbar.set_label(r"$\log_{10}$(runtime in seconds)", fontsize=11)
cbar.formatter = LogFormatter(10, labelOnlyBase=False)
cbar.update_ticks()

# ----------------------------------------------------------------------
# 9. Final layout and export
# ----------------------------------------------------------------------
plt.tight_layout(rect=[0, 0.03, 0.87, 0.95])
plt.savefig("heatmap_cold_warm.png", dpi=300, bbox_inches="tight")
plt.savefig("heatmap_cold_warm.pdf", bbox_inches="tight")
plt.show()