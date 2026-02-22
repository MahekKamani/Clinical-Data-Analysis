library(readr)
library(dplyr)
library(ggplot2)

adsl <- read_csv("adam/adsl.csv", show_col_types = FALSE)

demo_summary <- adsl %>%
  group_by(TRT_FLAG, AGEGRP, SEX) %>%
  summarise(N = n_distinct(USUBJID), .groups = "drop")

if (!dir.exists("tlf")) dir.create("tlf")
write_csv(demo_summary, "tlf/demographics_summary.csv")

cat("Demographics summary table saved to tlf/demographics_summary.csv\n")

plot <- ggplot(demo_summary, aes(x = AGEGRP, y = N, fill = SEX)) +
  geom_bar(stat = "identity", position = "stack") +
  facet_wrap(~TRT_FLAG) +
  labs(title = "Demographics by Age Group and Sex",
       x = "Age Group", y = "Number of Subjects") +
  theme_minimal() +
  theme(
    panel.background = element_rect(fill = "white"),
    plot.background = element_rect(fill = "white")
  )

ggsave("tlf/demographics_plot.png", plot, width = 7, height = 5, bg = "white")

