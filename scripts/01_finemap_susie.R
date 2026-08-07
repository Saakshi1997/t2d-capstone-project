# 01_finemap_susie.R
#
# Step 1: Statistical fine-mapping of the TCF7L2 locus with SuSiE.
#
# Question this script answers: given the GWAS association signal across the
# locus, which specific variant(s) are most likely to be causal, and how
# confident are we?
#
# STATUS: stub — filling this in is the week 2-4 focus. Structure is here so
# the pipeline is legible end-to-end from week 1.

library(susieR)
library(data.table)
# library(tidyverse)  # if you prefer dplyr-style wrangling

# --- 1. Load region-subsetted GWAS summary stats -----------------------------
# Expect columns: SNP, CHR, POS, A1, A2, BETA, SE, P, (N or MAF)
# gwas <- fread("data/processed/tcf7l2_gwas_hg19.txt")

# --- 2. Load LD matrix from 1000G EUR subset ----------------------------------
# SuSiE with summary statistics (susie_rss) needs an LD correlation matrix
# aligned, variant-for-variant and allele-for-allele, to the GWAS file.
# This alignment step is the single most common source of bugs in this
# pipeline (allele flips, strand issues, variant ordering) — budget real time
# for it rather than assuming it'll just work.
#
# ld_matrix <- ... # from plink --r square, or the `bigsnpr` package

# --- 3. Run SuSiE on summary statistics ---------------------------------------
# fit <- susie_rss(
#   z = gwas$BETA / gwas$SE,
#   R = ld_matrix,
#   n = <effective sample size>,
#   L = 10  # max number of causal signals to allow — start here, revisit
# )

# --- 4. Extract credible sets and posterior inclusion probabilities ----------
# cs <- susie_get_cs(fit, coverage = 0.95)
# pip <- susie_get_pip(fit)

# --- 5. Save results -----------------------------------------------------------
# saveRDS(fit, "results/tables/susie_fit_tcf7l2.rds")
# fwrite(data.table(SNP = gwas$SNP, PIP = pip), "results/tables/tcf7l2_pip.csv")

# --- 6. Sanity check against the published credible set -----------------------
# Compare against the Mahajan et al. 2018 credible set you downloaded in
# data/raw/ — does rs7903146 show up with high PIP in your own run too?
