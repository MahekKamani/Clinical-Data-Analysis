library(readr)
library(dplyr)

dm <- read_csv("raw_data/dm.csv", show_col_types = FALSE)

adsl <- dm %>%
  mutate(
    AGEGRP = cut(
      AGE,
      breaks = c(0, 40, 65, 120),
      labels = c("<40", "40-65", "65+"),
      right = TRUE
    ),
    TRT_FLAG = if_else(ARM != "Placebo", "Treated", "Placebo")
  )

if (!dir.exists("adam")) dir.create("adam")
write_csv(adsl, "adam/adsl.csv")

cat("ADSL dataset created with", nrow(adsl), "rows.\n")
