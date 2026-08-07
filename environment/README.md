# Environment setup

## R (RStudio)

This project uses [`renv`](https://rstudio.github.io/renv/) for R package
reproducibility — standard practice for a portfolio project someone else
might want to actually run.

First-time setup, run inside RStudio with the project open:

```r
install.packages("renv")
renv::init()
install.packages(c("susieR", "coloc", "data.table", "ggplot2"))
renv::snapshot()   # writes renv.lock — commit this file
```

Anyone cloning the repo later just runs `renv::restore()` to get the exact
package versions you used.

## Python

```bash
python -m venv .venv
source .venv/bin/activate       # or .venv\Scripts\activate on Windows
pip install -r environment/requirements.txt
```

## System tools (not R/Python packages)

Needed for `scripts/00_download_and_subset.sh`:
- `tabix` / `bcftools` (region subsetting of eQTL and VCF data)
- `plink2` (LD reference panel handling)

Easiest install via conda:
```bash
conda install -c bioconda tabix bcftools plink2
```
