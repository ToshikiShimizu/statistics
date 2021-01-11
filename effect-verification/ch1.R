library("tidyverse")

email_data <- read_csv("http://www.minethatdata.com/Kevin_Hillstrom_MineThatData_E-MailAnalytics_DataMiningChallenge_2008.03.20.csv")

male_df <- email_data %>%
  filter(segment != "Womens E-Mail") %>%
  mutate(treatment = if_else(segment == "Mens E-Mail",1,0))

summary_by_segment <- male_df %>%
  group_by(treatment) %>%
  summarise(conversion_rate = mean(conversion),
            spend_mean = mean(spend),
            count = n())
summary_by_segment

mens_mail <- male_df %>%
  filter(treatment == 1) %>%
  pull(spend)

no_mail <- male_df %>%
  filter(treatment == 0) %>% 
  pull(spend)

rct_ttest <- t.test(mens_mail, no_mail, var.equal = TRUE)

rct_ttest

set.seed(1)

obs_rate_c <- 0.5
obs_rate_t <- 0.5


