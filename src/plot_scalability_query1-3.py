import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from matplotlib.ticker import LogFormatterSciNotation
import scienceplots

plt.style.use('science')

# ----------------------------------------------------------------------
# 1. Load scalability data
# ----------------------------------------------------------------------
cold = pd.read_csv("data/derived_data/table3_scalability_dataset_cold.csv")
warm = pd.read_csv("data/derived_data/table4_scalability_dataset_warm.csv")

systems = ["vcf2db", "cutevariant", "VCFdbR-table", "VCFdbR-file", "vcf-miner"]
fractions = [1, 10, 50, 100]
x_labels = ["1", "10", "50", "100"]

# ----------------------------------------------------------------------
# 2. Figure 3: Lightweight workloads (Q1, Q2, Q3)
# ----------------------------------------------------------------------
queries_fig3 = ["Q1", "Q2", "Q3"]
n_queries = len(queries_fig3)

# Create figure: 3 rows × 4 columns
# Columns: Cold-linear, Cold-log, Warm-linear, Warm-log
fig, axes = plt.subplots(n_queries, 4, figsize=(16, 12))
fig.subplots_adjust(hspace=0.35, wspace=0.3)

# Compute global y-axis limits for linear and log scales
all_vals = []
for q in queries_fig3:
    cold_q = cold[cold["query"] == q]
    warm_q = warm[warm["query"] == q]
    for df in (cold_q, warm_q):
        for _, row in df.iterrows():
            for sys in systems:
                val = row.get(sys)
                if pd.notna(val) and val != "":
                    all_vals.append(float(val))

y_min = min(all_vals)
y_max = max(all_vals)

# Linear scale limits (add 10% padding)
y_min_linear = max(0, y_min * 0.9)
y_max_linear = y_max * 1.1

# Log scale limits (add padding)
y_min_log = 10 ** (np.log10(y_min) - 0.3)
y_max_log = 10 ** (np.log10(y_max) + 0.3)

# Okabe-Ito colourblind-safe palette, as shipped by matplotlib
okabe_ito = plt.colormaps["okabe_ito"].colors
color_map = {
    "vcf2db": okabe_ito[6],        # vermillion (prominent)
    "cutevariant": okabe_ito[5],   # blue
    "VCFdbR-table": okabe_ito[3],  # bluish green
    "VCFdbR-file": okabe_ito[1],   # orange
    "vcf-miner": okabe_ito[7]      # reddish purple
}

# Same marker/line style per system as plot_queries_scaling.py
marker_style = {"vcf2db": "o", "cutevariant": "s", "VCFdbR-table": "^",
                "VCFdbR-file": "D", "vcf-miner": "v"}
line_style = {"vcf2db": "-", "cutevariant": "--", "VCFdbR-table": "-.",
              "VCFdbR-file": ":", "vcf-miner": "-"}
line_width = {sys: 3.0 if sys == "vcf2db" else 1.5 for sys in systems}
alpha = 0.85
marker_size = {sys: 8 if sys == "vcf2db" else 5 for sys in systems}

# ----------------------------------------------------------------------
# 3. Plot each query row
# ----------------------------------------------------------------------
for i, q in enumerate(queries_fig3):
    # Get data for this query
    cold_q = cold[cold["query"] == q].sort_values("sample_percentage")
    warm_q = warm[warm["query"] == q].sort_values("sample_percentage")
    
    # Column 0: Cold cache - Linear scale
    ax_cold_lin = axes[i, 0]
    for sys in systems:
        y_vals = cold_q[sys].values
        y_vals = [float(v) if pd.notna(v) and v != "" else np.nan for v in y_vals]
        if all(np.isnan(y_vals)):
            continue
        ax_cold_lin.plot(fractions, y_vals, 
                        color=color_map[sys], 
                        linewidth=line_width[sys], 
                        alpha=alpha, 
                        linestyle=line_style[sys],
                        marker=marker_style[sys],
                        markersize=marker_size[sys],
                        label=sys if i == 0 else "")
    
    ax_cold_lin.set_yscale("linear")
    ax_cold_lin.set_ylim(y_min_linear, y_max_linear)
    ax_cold_lin.set_xticks(fractions)
    if i == n_queries - 1:  # bottom row only
        ax_cold_lin.set_xticklabels(x_labels)
    else:
        ax_cold_lin.set_xticklabels([])
    ax_cold_lin.set_ylabel(f"{q}\nTime (s)", fontsize=10, fontweight="bold")
    ax_cold_lin.grid(True, axis="y", linestyle=":", alpha=0.4, linewidth=0.5)
    if i == 0:
        ax_cold_lin.set_title("Cold Cache\n[Linear Scale]", fontsize=11, fontweight="bold")
    
    # Column 1: Cold cache - Log scale
    ax_cold_log = axes[i, 1]
    for sys in systems:
        y_vals = cold_q[sys].values
        y_vals = [float(v) if pd.notna(v) and v != "" else np.nan for v in y_vals]
        if all(np.isnan(y_vals)):
            continue
        ax_cold_log.plot(fractions, y_vals, 
                        color=color_map[sys], 
                        linewidth=line_width[sys], 
                        alpha=alpha, 
                        linestyle=line_style[sys],
                        marker=marker_style[sys],
                        markersize=marker_size[sys],
                        label=sys if i == 0 else "")
    
    ax_cold_log.set_yscale("log")
    ax_cold_log.set_ylim(y_min_log, y_max_log)
    ax_cold_log.set_xticks(fractions)
    if i == n_queries - 1:
        ax_cold_log.set_xticklabels(x_labels)
    else:
        ax_cold_log.set_xticklabels([])
    ax_cold_log.set_ylabel(f"{q}\nTime (s)", fontsize=10, fontweight="bold")
    ax_cold_log.yaxis.set_major_formatter(LogFormatterSciNotation())
    ax_cold_log.grid(True, axis="y", linestyle=":", alpha=0.4, linewidth=0.5, which='both')
    if i == 0:
        ax_cold_log.set_title("Cold Cache\n[Log Scale]", fontsize=11, fontweight="bold")
    
    # Column 2: Warm cache - Linear scale
    ax_warm_lin = axes[i, 2]
    for sys in systems:
        y_vals = warm_q[sys].values
        y_vals = [float(v) if pd.notna(v) and v != "" else np.nan for v in y_vals]
        if all(np.isnan(y_vals)):
            continue
        ax_warm_lin.plot(fractions, y_vals, 
                        color=color_map[sys], 
                        linewidth=line_width[sys], 
                        alpha=alpha, 
                        linestyle=line_style[sys],
                        marker=marker_style[sys],
                        markersize=marker_size[sys],
                        label=sys if i == 0 else "")
    
    ax_warm_lin.set_yscale("linear")
    ax_warm_lin.set_ylim(y_min_linear, y_max_linear)
    ax_warm_lin.set_xticks(fractions)
    if i == n_queries - 1:
        ax_warm_lin.set_xticklabels(x_labels)
    else:
        ax_warm_lin.set_xticklabels([])
    ax_warm_lin.set_ylabel(f"{q}\nTime (s)", fontsize=10, fontweight="bold")
    ax_warm_lin.grid(True, axis="y", linestyle=":", alpha=0.4, linewidth=0.5)
    if i == 0:
        ax_warm_lin.set_title("Warm Cache\n[Linear Scale]", fontsize=11, fontweight="bold")
    
    # Column 3: Warm cache - Log scale
    ax_warm_log = axes[i, 3]
    for sys in systems:
        y_vals = warm_q[sys].values
        y_vals = [float(v) if pd.notna(v) and v != "" else np.nan for v in y_vals]
        if all(np.isnan(y_vals)):
            continue
        ax_warm_log.plot(fractions, y_vals, 
                        color=color_map[sys], 
                        linewidth=line_width[sys], 
                        alpha=alpha, 
                        linestyle=line_style[sys],
                        marker=marker_style[sys],
                        markersize=marker_size[sys],
                        label=sys if i == 0 else "")
    
    ax_warm_log.set_yscale("log")
    ax_warm_log.set_ylim(y_min_log, y_max_log)
    ax_warm_log.set_xticks(fractions)
    if i == n_queries - 1:
        ax_warm_log.set_xticklabels(x_labels)
    else:
        ax_warm_log.set_xticklabels([])
    ax_warm_log.set_ylabel(f"{q}\nTime (s)", fontsize=10, fontweight="bold")
    ax_warm_log.yaxis.set_major_formatter(LogFormatterSciNotation())
    ax_warm_log.grid(True, axis="y", linestyle=":", alpha=0.4, linewidth=0.5, which='both')
    if i == 0:
        ax_warm_log.set_title("Warm Cache\n[Log Scale]", fontsize=11, fontweight="bold")

# ----------------------------------------------------------------------
# 4. Add shared x-axis label
# ----------------------------------------------------------------------
fig.supxlabel("Sample Percentage (\\%)", fontsize=12)

# ----------------------------------------------------------------------
# 5. Add legend (from first row, first column)
# ----------------------------------------------------------------------
handles, labels = axes[0, 0].get_legend_handles_labels()
by_label = dict(zip(labels, handles))  # Remove duplicates
fig.legend(by_label.values(), by_label.keys(), 
           loc="lower center",
           bbox_to_anchor=(0.5, 1.0),
           ncol=len(by_label),
           fontsize=10, 
           title="Database System",
           title_fontsize=11,
           frameon=True,
           fancybox=True,
           shadow=True)

# ----------------------------------------------------------------------
# 6. Main title and save
# ----------------------------------------------------------------------
plt.tight_layout()
plt.savefig("Figure3_Lightweight_DualScale.png", dpi=300, bbox_inches="tight")
plt.savefig("Figure3_Lightweight_DualScale.pdf", bbox_inches="tight")
plt.show()

print("Figure 3 generated successfully!")
print("Layout: 3 rows (Q1, Q2, Q3) × 4 columns (Cold-Linear, Cold-Log, Warm-Linear, Warm-Log)")