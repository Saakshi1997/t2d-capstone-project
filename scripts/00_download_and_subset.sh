#!/usr/bin/env bash
# 00_download_and_subset.sh
#
# Downloads raw data for the TCF7L2 T2D V2F project and subsets each source
# to the locus region so downstream steps aren't dragging genome-wide files
# around. Run from the repo root: `bash scripts/00_download_and_subset.sh`
#
# Requires: wget or curl, tabix, bcftools, plink2 (or plink)
# All of these are conda-installable, e.g.:
#   conda install -c bioconda tabix bcftools plink2

set -euo pipefail

RAW_DIR="data/raw"
REF_DIR="data/reference"
PROC_DIR="data/processed"
mkdir -p "$RAW_DIR" "$REF_DIR" "$PROC_DIR"

# ---------------------------------------------------------------------------
# Locus definition — TCF7L2 / rs7903146
# ---------------------------------------------------------------------------
# Gene body (hg38): chr10:112,950,205-113,167,678
# Gene body (hg19): chr10:114,710,006-114,927,437
# rs7903146 (hg19):  chr10:114,758,349
#
# Analysis window: gene body +/- 500kb padding, per build. Verify against
# dbSNP/Ensembl before running for real — coordinates below are a starting
# point, not gospel.

CHR="10"
REGION_HG19="10:114210006-115427437"   # gene body +/- 500kb, hg19
REGION_HG38="10:112450205-113667678"   # gene body +/- 500kb, hg38

echo "=== Step 1: DIAGRAM/DIAMANTE GWAS summary statistics ==="
echo "Manual step: DIAGRAM requires a click-through data-use agreement,"
echo "so this can't be scripted with a bare wget. Go to:"
echo "  https://diagram-consortium.org/downloads.html"
echo "Download 'T2D GWAS meta-analysis - Unadjusted for BMI' (Mahajan 2018b)"
echo "and 'T2D GWAS meta-analysis - Genetic Credible Sets' (same paper),"
echo "and place the unzipped files in $RAW_DIR/"
echo ""
echo "Once downloaded, subset to the locus (adjust filename/column names to"
echo "match the actual file — check the DIAGRAM readme PDF first):"
echo ""
echo '  awk -v chr="'"$CHR"'" -v lo=114210006 -v hi=115427437 \'
echo "    'NR==1 || (\$1==chr && \$2>=lo && \$2<=hi)' \\"
echo "    $RAW_DIR/Mahajan.2018b.T2D.EUR.unadjBMI.txt > $PROC_DIR/tcf7l2_gwas_hg19.txt"
echo ""

echo "=== Step 2: 1000 Genomes LD reference panel (EUR) ==="
echo "Pre-built PLINK files (recommended — avoids VCF wrangling):"
echo "  https://www.cog-genomics.org/plink/2.0/resources"
echo ""
echo "Once you have the PLINK fileset, subset to EUR samples and the locus:"
echo ""
echo "  plink2 --pfile data/reference/all_hg19 \\"
echo "    --chr $CHR --from-bp 114210006 --to-bp 115427437 \\"
echo "    --keep data/reference/eur_samples.txt \\"
echo "    --make-bed --out $REF_DIR/tcf7l2_1000g_eur"
echo ""
echo "(eur_samples.txt: one sample ID per line, from the 1000G panel metadata"
echo "at https://ftp.1000genomes.ebi.ac.uk/vol1/ftp/technical/working/20130606_sample_info/)"
echo ""

echo "=== Step 3: GTEx v8 eQTL data (all associations, 5 tissues) ==="
echo "Manual download (open access, no login) from:"
echo "  https://gtexportal.org/home/datasets"
echo "Files needed (GTEx_Analysis_v8_eQTL_all_associations):"
echo "  Pancreas, Liver, Adipose_Subcutaneous, Adipose_Visceral_Omentum, Muscle_Skeletal"
echo ""
echo "These are large (whole-genome, per tissue) — subset to the locus with tabix"
echo "immediately after download so you're not carrying multi-GB files around:"
echo ""
for tissue in Pancreas Liver Adipose_Subcutaneous Adipose_Visceral_Omentum Muscle_Skeletal; do
  echo "  tabix data/raw/${tissue}.allpairs.txt.gz $REGION_HG38 > $PROC_DIR/${tissue}_tcf7l2_hg38.txt"
done
echo ""
echo "NOTE — genome build mismatch: GTEx v8 is hg38. DIAGRAM/1000G above are"
echo "likely hg19. You will need to liftOver one to match the other before"
echo "colocalization (e.g. UCSC liftOver, or the R 'rtracklayer' package)."
echo "Flagging this now, in week 1, rather than discovering it in week 5-6."
echo ""

echo "=== Done — see data/raw/SOURCES.md and fill in download dates/checksums ==="
