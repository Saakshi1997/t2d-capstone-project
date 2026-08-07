# Resolving Variant-to-Function at the TCF7L2 T2D Locus

**Question:** Which gene and tissue does the TCF7L2 locus's causal Type 2 Diabetes
risk variant most likely act through?

A single-locus deep dive using statistical fine-mapping, tissue-specific eQTL
colocalization, and benchmarking against Open Targets, applied to the most
replicated T2D GWAS signal (rs7903146 / TCF7L2). Built as a concrete demonstration
of the variant-to-function (V2F) workflow used across statistical and functional
genomics to move from a GWAS hit to a mechanistic hypothesis.

## Why this locus

TCF7L2 is the strongest, most replicated, and most mechanistically characterized
T2D GWAS locus, which makes it a good proving ground: there's a rich literature to
check my own results against, rather than working blind. See `docs/locus_notes.md`
for background and coordinates.

## Pipeline

| Step | Question | Tool | Output |
|---|---|---|---|
| 1. Fine-mapping | Which variant(s) at this locus are likely causal? | [`susieR`](https://stephenslab.github.io/susieR/) | Credible set + posterior inclusion probabilities |
| 2. Colocalization | Does the GWAS signal share a causal variant with a tissue's eQTL signal? | [`coloc`](https://chr1swallace.github.io/coloc/) | H0-H4 posterior probabilities per tissue, per gene |
| 3. Benchmark | Does my locus-to-gene call agree with Open Targets' ML-based prediction? | Open Targets Genetics API | Agreement/disagreement writeup |
| 4. (stretch) Perturbation evidence | Does CRISPR screen data support the implicated gene? | MAGeCK (literacy pass) | Interpretive notes |
| 5. Visualization + narrative | Pulling it together | matplotlib/plotnine | Regional plot + 1-page writeup |

Steps 1 → 2 → 3 → 5 are the non-negotiable core. Step 4 is a stretch goal.

## Data sources

All data are public. See `scripts/00_download_and_subset.sh` for exact download
and subsetting commands, and `data/raw/SOURCES.md` for provenance/version notes.

- **GWAS summary statistics:** DIAGRAM/DIAMANTE consortium, Mahajan et al. 2018
  (Nat Genet), unadjusted-for-BMI European meta-analysis.
- **LD reference panel:** 1000 Genomes Phase 3, EUR samples.
- **eQTL data:** GTEx v8, Pancreas / Liver / Adipose (Subcutaneous + Visceral) /
  Skeletal Muscle — the T2D-relevant tissue set.
- **Benchmark:** Open Targets Genetics/Platform API.

## Repo structure

```
t2d-v2f-tcf7l2/
├── data/
│   ├── raw/            # untouched downloads (gitignored — see SOURCES.md for provenance)
│   ├── reference/       # 1000G LD panel (gitignored)
│   └── processed/       # region-subsetted, analysis-ready files (small enough to commit)
├── scripts/
│   ├── 00_download_and_subset.sh
│   ├── 01_finemap_susie.R
│   ├── 02_coloc_gtex.R
│   ├── 03_opentargets_benchmark.py
│   └── 04_visualize_locuszoom.R
├── results/
│   ├── figures/
│   └── tables/
├── narrative/
│   └── writeup.md       # ~1 page: question, method, finding, implications
├── docs/
│   └── locus_notes.md    # reading notes, coordinates, known biology
└── environment/
    ├── renv.lock         # R package versions (generated via renv::snapshot())
    └── requirements.txt  # Python dependencies
```

## Reproducing this analysis

```bash
# 1. Download and subset raw data to the TCF7L2 region
bash scripts/00_download_and_subset.sh

# 2. Fine-map (R / RStudio)
# open and run scripts/01_finemap_susie.R

# 3. Colocalization (R / RStudio)
# open and run scripts/02_coloc_gtex.R

# 4. Open Targets benchmark (Python)
python scripts/03_opentargets_benchmark.py

# 5. Visualization
# open and run scripts/04_visualize_locuszoom.R
```

## Status

- [ ] Data downloaded and subsetted to locus
- [ ] SuSiE credible set produced
- [ ] coloc run across all 5 tissues
- [ ] Open Targets benchmark complete
- [ ] Regional plot + narrative drafted
- [ ] (stretch) MAGeCK literacy pass on public islet/beta-cell screen data

## Limitations

To be filled in honestly as the analysis proceeds — e.g. LD reference mismatch
(1000G vs. in-sample LD), genome build harmonization between GWAS (likely hg19)
and GTEx v8 (hg38), single-locus scope, credible set resolution limits.

## Acknowledgments

Repo scaffolding and tooling (folder structure, `.gitignore`, `LICENSE`, git
setup) were set up with Claude Code assistance. The fine-mapping, colocalization,
and biological interpretation are my own analytical work.
