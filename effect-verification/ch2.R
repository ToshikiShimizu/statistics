library("tidyverse")
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
# 2.2.3
formula_vec <- c(spend ~ treatment + recency + channel,
                 spend ~ treatment + recency + channel + history,
                 history ~ treatment + channel + recency)
names(formula_vec) <- paste("reg",LETTERS[1:3],sep="_")

models <- formula_vec %>%
  enframe(name="model_index",value="formula")

df_models <- models %>%
  mutate(model=map(.x=formula, .f=lm, data=biased_data)) %>%
  mutate(lm_result=map(.x=model, .f=tidy))

df_results <- df_models %>%
  mutate(formula=as.character(formula)) %>%
  select(formula, model_index, lm_result) %>%
  unnest(cols=c(lm_result))

treatment_coef <- df_results %>%
  filter(term == "treatment") %>%
  pull(estimate)

history_coef <- df_results %>%
  filter(model_index == "reg_B",
         term == "history") %>%
  pull(estimate)

OVB <- history_coef*treatment_coef[3]
coef_gap <- treatment_coef[1] -treatment_coef[2]
OVB
coef_gap
