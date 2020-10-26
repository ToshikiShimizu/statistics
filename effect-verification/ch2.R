biased_data <- male_df %>%
  mutate(obs_rate_c =
           ifelse( (history > 300) | (recency < 6) |
                     (channel == "Multichannel"), obs_rate_c, 1),
         obs_rate_t =
           ifelse( (history > 300) | (recency < 6) |
                     (channel == "Multichannel"), 1, obs_rate_t),
         random_number = runif(n = NROW(male_df))) %>%
  filter( (treatment == 0 & random_number < obs_rate_c ) |
            (treatment == 1 & random_number < obs_rate_t) )


biased_reg <- lm(data = biased_data, formula = spend ~ treatment + history)

summary(biased_reg)

library("broom")

biased_reg_coef <- tidy(biased_reg)

biased_reg_coef

rct_reg <- lm(data = male_df, formula = spend ~ treatment)
rct_reg_coef <- tidy(rct_reg)
nonrct_reg <- lm(data = biased_data, formula = spend ~ treatment)
nonrct_reg_coef <- tidy(nonrct_reg)
nonrct_mreg <- lm(data = biased_data,
                  formula = spend ~ treatment + recency + channel + history)
nonrct_mreg_coef <- tidy(nonrct_mreg)

rct_reg_coef

nonrct_reg_coef

nonrct_mreg_coef

