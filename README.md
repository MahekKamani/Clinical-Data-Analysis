# Clinical Data Analysis Pipeline

This repository contains a small, end-to-end example of a clinical trial data workflow in R. It starts from SDTM-like source data, derives ADaM analysis datasets, and produces simple tables and figures (TLFs) for adverse events and demographics.

The project is intentionally lightweight and self-contained so it can be used for learning, demonstrations, or as a template for similar pipelines.

## Repository Structure

- [raw_data/](raw_data) – SDTM-like source data generated from the *admiral.test* package (DM, AE, LB).
- [adam/](adam) – Derived ADaM datasets created by the pipeline (ADSL, ADAE).
- [tlf/](tlf) – Output tables and figures (e.g. adverse event summaries, demographics summaries).
- [scripts/get_data.R](scripts/get_data.R) – Pulls example SDTM data from *admiral.test* and writes CSV files to `raw_data/`.
- [scripts/prepare_adsl.R](scripts/prepare_adsl.R) – Creates an ADSL-like subject-level analysis dataset from DM.
- [scripts/prepare_adae.R](scripts/prepare_adae.R) – Creates an ADAE-like adverse event analysis dataset by joining AE with ADSL.
- [scripts/summary_adae.R](scripts/summary_adae.R) – Produces AE summary table and a bar plot by treatment.
- [scripts/summary_adsl.R](scripts/summary_adsl.R) – Produces demographics summary table and a plot by age group, sex, and treatment.
- [scripts/run_all.R](scripts/run_all.R) – Orchestrates the full pipeline in sequence.

## Prerequisites

- R (version 4.0 or later recommended).
- The following R packages (installed automatically by the scripts if missing):
	- `admiral.test` (from pharmaverse R-universe)
	- `dplyr`
	- `readr`
	- `ggplot2`

You can install them up front if you prefer:

```r
install.packages(c("dplyr", "readr", "ggplot2"))
install.packages(
	"admiral.test",
	repos = c("https://pharmaverse.r-universe.dev", "https://cloud.r-project.org")
)
```

## Running the Pipeline

From the project root (where this README is located), start an R session and run:

```r
source("scripts/run_all.R")
```

This will:

1. Download and save SDTM-like data to [raw_data/](raw_data).
2. Derive ADSL and write it to [adam/adsl.csv](adam/adsl.csv).
3. Derive ADAE and write it to [adam/adae.csv](adam/adae.csv).
4. Create AE summary table and plot in [tlf/](tlf).
5. Create demographics summary table and plot in [tlf/](tlf).

Console messages will indicate progress and confirm where files are written.

## Outputs

After running the pipeline, you should see (at minimum):

- [adam/adsl.csv](adam/adsl.csv) – Subject-level analysis dataset with age groups and treatment flags.
- [adam/adae.csv](adam/adae.csv) – Adverse event analysis dataset with treatment-emergent flags.
- [tlf/ae_summary_by_treatment.csv](tlf/ae_summary_by_treatment.csv) – Summary of subjects with ≥1 adverse event by treatment.
- [tlf/ae_summary_plot.png](tlf/ae_summary_plot.png) – Bar plot of AE subjects by treatment.
- [tlf/demographics_summary.csv](tlf/demographics_summary.csv) – Demographics summary by treatment, age group, and sex.
- [tlf/demographics_plot.png](tlf/demographics_plot.png) – Demographics plot by age group and sex, faceted by treatment.

## Customization

- Modify [scripts/prepare_adsl.R](scripts/prepare_adsl.R) to change subject-level derivations (e.g., age groups, additional flags).
- Modify [scripts/prepare_adae.R](scripts/prepare_adae.R) to change how treatment-emergent AEs are defined.
- Extend [scripts/summary_adae.R](scripts/summary_adae.R) and [scripts/summary_adsl.R](scripts/summary_adsl.R) to add new tables or figures.

## Reproducibility Notes

- All input data are generated from the open-source *admiral.test* package, so no proprietary clinical data are required.
- The pipeline is designed to be run from a clean checkout; existing contents of `adam/` and `tlf/` will be overwritten when scripts are re-run.
