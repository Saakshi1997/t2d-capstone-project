# 02_coloc_gtex.R
#
# Step 2: Colocalization between the TCF7L2 GWAS signal and tissue-specific
# GTEx eQTL signals.
#
# Question this script answers: in each T2D-relevant tissue, does the GWAS
# association and the eQTL association for a nearby gene share a single
# underlying causal variant (as opposed to two distinct variants that happen
# to be nearby)?
#
# STATUS: stub — week 5-6 focus.

library(coloc)
library(data.table)

tissues <- c("Pancreas", "Liver", "Adipose_Subcutaneous",
             "Adipose_Visceral_Omentum", "Muscle_Skeletal")

# --- 1. Load GWAS data (same locus subset as script 01) -----------------------
# gwas <- fread("data/processed/tcf7l2_gwas_hg19.txt")

# --- 2. For each tissue, load eQTL data and run coloc.abf ----------------------
# results <- list()
# for (tissue in tissues) {
#   eqtl <- fread(sprintf("data/processed/%s_tcf7l2_hg38.txt", tissue))
#
#   # REMINDER: GWAS is hg19, GTEx is hg38 — liftOver before this step,
#   # and align on rsID or a build-consistent chr:pos:ref:alt key.
#
#   coloc_input_gwas <- list(
#     beta = gwas$BETA, varbeta = gwas$SE^2, snp = gwas$SNP,
#     type = "cc", N = <total N>, s = <case fraction>
#   )
#   coloc_input_eqtl <- list(
#     beta = eqtl$slope, varbeta = eqtl$slope_se^2, snp = eqtl$SNP,
#     type = "quant", N = <GTEx tissue sample size>
#   )
#
#   res <- coloc.abf(dataset1 = coloc_input_gwas, dataset2 = coloc_input_eqtl)
#   results[[tissue]] <- res
# }

# --- 3. Summarize PP.H4 (shared causal variant) across tissues ----------------
# A results table here is the direct input to your visualization step —
# tissue x gene x PP.H4 heatmap or bar chart.

# --- 4. Interpret ambiguity as a finding, not a failure ------------------------
# If multiple tissues show high PP.H4, or if H3 (distinct causal variants)
# dominates somewhere unexpected, that's worth a paragraph in the narrative —
# not something to quietly drop.
