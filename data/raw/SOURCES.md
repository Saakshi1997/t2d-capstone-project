# Data provenance

Raw downloads are gitignored (too large, and re-downloadable from public sources).
This file is the paper trail — fill in the actual date/checksum once you've
downloaded each file, so the repo stays reproducible even without the data present.

## GWAS summary statistics

- **Source:** DIAGRAM/DIAMANTE Consortium, https://diagram-consortium.org/downloads.html
- **File:** T2D GWAS meta-analysis — Unadjusted for BMI
- **Publication:** Mahajan et al. 2018, Nature Genetics (DOI: TODO — fill in from paper)
- **Genome build:** TODO — confirm from the accompanying readme PDF (likely hg19)
- **Download date:** TODO
- **MD5 (from DIAGRAM site):** 53855134fd0862c402cf49ab6233ed6d

### Bonus (benchmark) file
- **File:** T2D GWAS meta-analysis — Genetic Credible Sets (Mahajan et al. 2018b)
- **Use:** published credible set for TCF7L2, to compare against your own SuSiE output
- **MD5:** 0602214b6e50f4aad4cdd0e26eca9613

## LD reference panel

- **Source:** 1000 Genomes Phase 3 (EUR subset)
- **Access point:** https://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/
  or pre-built PLINK files via https://www.cog-genomics.org/plink/2.0/resources
- **Genome build:** TODO — confirm (1000G phase 3 is hg19/GRCh37 natively)
- **Download date:** TODO
- **Subset applied:** EUR samples, chr10 region only (see 00_download_and_subset.sh)

## eQTL data

- **Source:** GTEx v8, https://gtexportal.org/home/datasets
- **Files:** `GTEx_Analysis_v8_eQTL_all_associations` for Pancreas, Liver,
  Adipose_Subcutaneous, Adipose_Visceral_Omentum, Muscle_Skeletal
- **Genome build:** hg38/GRCh38 — NOTE: this differs from the likely GWAS build (hg19).
  Liftover will be required before colocalization. Flagging this now so it isn't
  a week-5 surprise.
- **Download date:** TODO

## Benchmark

- **Source:** Open Targets Genetics/Platform API
- **Query date:** TODO (Open Targets updates its ML model periodically — note the
  date so a future re-run/discrepancy can be explained by data vintage)
