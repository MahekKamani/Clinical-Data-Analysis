library(readr)
library(dplyr)

ae <- read_csv("raw_data/ae.csv", show_col_types = FALSE)
adsl <- read_csv("adam/adsl.csv", show_col_types = FALSE)

adae <- ae %>%
  left_join(
    adsl %>% select(USUBJID, ARM, TRT_FLAG, AGEGRP, RFSTDTC),
    by = "USUBJID"
  ) %>%
  mutate(
    TEAE_FLAG = if_else(!is.na(AESTDTC) & !is.na(RFSTDTC) & AESTDTC >= RFSTDTC, "Y", "N")
  )

if (!dir.exists("adam")) dir.create("adam")
write_csv(adae, "adam/adae.csv")

cat("ADAE dataset created with", nrow(adae), "rows.\n")
