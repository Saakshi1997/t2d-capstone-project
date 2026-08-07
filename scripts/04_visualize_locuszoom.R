# 04_visualize_locuszoom.R
#
# Step 5: Regional association plot (LocusZoom-style) showing the GWAS
# signal, the SuSiE credible set, and tissue-specific colocalization results
# in one interview-ready figure.
#
# STATUS: stub — week 8-9 focus.

library(ggplot2)
library(data.table)

# --- 1. Load fine-mapping + coloc results from scripts 01 and 02 --------------
# pip <- fread("results/tables/tcf7l2_pip.csv")
# coloc_summary <- fread("results/tables/coloc_summary.csv")

# --- 2. Build the regional plot -------------------------------------------------
# Classic LocusZoom layout: -log10(p) on y-axis, genomic position on x-axis,
# points colored/sized by LD to the lead variant or by PIP, credible set
# variants highlighted distinctly.
#
# p <- ggplot(gwas, aes(x = POS, y = -log10(P))) +
#   geom_point(aes(size = PIP), alpha = 0.7) +
#   geom_point(data = subset(gwas, SNP %in% credible_set), color = "red") +
#   theme_minimal() +
#   labs(x = "Position (chr10)", y = "-log10(P)",
#        title = "TCF7L2 locus: GWAS signal and SuSiE credible set")

# --- 3. Tissue colocalization panel ---------------------------------------------
# A simple tissue x PP.H4 bar chart or heatmap pairs well underneath the
# regional plot — this is the piece that actually answers "which tissue."

# --- 4. Save ----------------------------------------------------------------------
# ggsave("results/figures/tcf7l2_regional_plot.png", p, width = 10, height = 6, dpi = 300)
