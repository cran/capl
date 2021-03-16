## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----warning = FALSE, message = FALSE, eval = FALSE---------------------------
#  devtools::install_github("barnzilla/capl", upgrade = "never", build_vignettes = TRUE, force = TRUE)
#  library(capl)

## ----warning = FALSE, message = FALSE, echo = FALSE---------------------------
library(capl)

## ----warning = FALSE, message = FALSE, eval = FALSE---------------------------
#  browseVignettes("capl")

## ----warning = FALSE, error = FALSE, eval = FALSE-----------------------------
#  data <- import_capl_data(
#    file_path = "c:/path/to/raw-data.xlsx",
#    sheet_name = "Sheet1"
#  )

## ----warning = FALSE, message = FALSE, eval = FALSE---------------------------
#  ?get_missing_capl_variables

## ----warning = FALSE, message = FALSE-----------------------------------------
data("capl_demo_data")

## ----warning = FALSE, message = FALSE-----------------------------------------
str(capl_demo_data)

## ----warning = FALSE, message = FALSE-----------------------------------------
colnames(capl_demo_data)

## ----warning = FALSE, message = FALSE-----------------------------------------
capl_demo_data2 <- get_capl_demo_data(n = 10000)

## ----warning = FALSE, message = FALSE-----------------------------------------
str(capl_demo_data2)

## ----warning = FALSE, message = FALSE, eval = FALSE---------------------------
#  export_capl_data(capl_demo_data2, "c:/path/to/store/capl_demo_data2.xlsx")

## -----------------------------------------------------------------------------
# Create fake data
raw_data <- data.frame(
  age_years = sample(8:12, 100, replace = TRUE),
  genders = sample(c("girl", "boy"), 100, replace = TRUE, prob = c(0.51, 0.49)),
  step_counts1 = sample(1000:30000, 100, replace = TRUE),
  step_counts2 = sample(1000:30000, 100, replace = TRUE),
  step_counts3 = sample(1000:30000, 100, replace = TRUE),
  step_counts4 = sample(1000:30000, 100, replace = TRUE),
  step_counts5 = sample(1000:30000, 100, replace = TRUE),
  step_counts6 = sample(1000:30000, 100, replace = TRUE),
  step_counts7 = sample(1000:30000, 100, replace = TRUE)
)

# Examine the structure of this data
str(raw_data)

# Rename the variables
raw_data <- rename_variable(
  x = raw_data,
  search = c(
    "age_years", 
    "genders", 
    "step_counts1", 
    "step_counts2", 
    "step_counts3", 
    "step_counts4", 
    "step_counts5", 
    "step_counts6", 
    "step_counts7"
  ),
  replace = c(
    "age", 
    "gender", 
    "steps1", 
    "steps2", 
    "steps3", 
    "steps4", 
    "steps5", 
    "steps6", 
    "steps7"
    )
)

# Examine the structure of this data
str(raw_data)

## ----eval = FALSE-------------------------------------------------------------
#  ?validate_age
#  ?validate_character
#  ?validate_domain_score
#  ?validate_gender
#  ?validate_integer
#  ?validate_number
#  ?validate_scale
#  ?validate_steps

## -----------------------------------------------------------------------------
validated_age <- validate_age(c(7, 8, 9, 10, 11, 12, 13, "", NA, "12", 8.5))

## -----------------------------------------------------------------------------
validated_age

## -----------------------------------------------------------------------------
validated_gender <- validate_gender(c("Girl", "GIRL", "g", "G", "Female", "f", "F", "", NA, 1))

validated_gender

## -----------------------------------------------------------------------------
validated_gender <- validate_gender(c("Boy", "BOY", "b", "B", "Male", "m", "M", "", NA, 0))

validated_gender

## ----warning = FALSE, message = FALSE-----------------------------------------
capl_results <- get_capl(raw_data = capl_demo_data, sort = "asis")

## -----------------------------------------------------------------------------
str(capl_results, list.len = nrow(capl_results))

## ----warning = FALSE, message = FALSE-----------------------------------------
capl_demo_data$pacer_laps_20m <- get_pacer_20m_laps(
  lap_distance = capl_demo_data$pacer_lap_distance, 
  laps_run = capl_demo_data$pacer_laps
)

## ----warning = FALSE, message = FALSE-----------------------------------------
capl_demo_data$pacer_laps_20m

## ----warning = FALSE, message = FALSE-----------------------------------------
capl_demo_data$pacer_score <- get_pacer_score(capl_demo_data$pacer_laps_20m)

## ----warning = FALSE, message = FALSE-----------------------------------------
capl_demo_data$pacer_score

## ----warning = FALSE, message = FALSE-----------------------------------------
capl_demo_data$pacer_interpretation <- get_capl_interpretation(
  age = capl_demo_data$age,
  gender = capl_demo_data$gender,
  score = capl_demo_data$pacer_score,
  protocol = "pacer"
)

## ----warning = FALSE, message = FALSE-----------------------------------------
capl_demo_data$pacer_interpretation

## ----warning = FALSE, message = FALSE-----------------------------------------
capl_demo_data$plank_score <- get_plank_score(capl_demo_data$plank_time)

## ----warning = FALSE, message = FALSE-----------------------------------------
capl_demo_data$plank_score

## ----warning = FALSE, message = FALSE-----------------------------------------
capl_demo_data$plank_interpretation <- get_capl_interpretation(
  age = capl_demo_data$age,
  gender = capl_demo_data$gender,
  score = capl_demo_data$plank_time,
  protocol = "plank"
)

## ----warning = FALSE, message = FALSE-----------------------------------------
capl_demo_data$plank_interpretation

## ----warning = FALSE, message = FALSE-----------------------------------------
# Trial 1
capl_demo_data$camsa_time_score1 <- get_camsa_time_score(capl_demo_data$camsa_time1)

# Trial 2
capl_demo_data$camsa_time_score2 <- get_camsa_time_score(capl_demo_data$camsa_time2)

## ----warning = FALSE, message = FALSE-----------------------------------------
# Time scores for trial 1
capl_demo_data$camsa_time_score1

## ----warning = FALSE, message = FALSE-----------------------------------------
# Time scores for trial 2
capl_demo_data$camsa_time_score2

## ----warning = FALSE, message = FALSE-----------------------------------------
# Trial 1
capl_demo_data$camsa_skill_time_score1 <- get_camsa_skill_time_score(
  camsa_skill_score = capl_demo_data$camsa_skill_score1,
  camsa_time_score = capl_demo_data$camsa_time_score1
)

# Trial 2
capl_demo_data$camsa_skill_time_score2 <- get_camsa_skill_time_score(
  camsa_skill_score = capl_demo_data$camsa_skill_score2,
  camsa_time_score = capl_demo_data$camsa_time_score2
)

## ----warning = FALSE, message = FALSE-----------------------------------------
# Time scores for trial 1
capl_demo_data$camsa_skill_time_score1

## ----warning = FALSE, message = FALSE-----------------------------------------
# Time scores for trial 2
capl_demo_data$camsa_skill_time_score2

## ----warning = FALSE, message = FALSE-----------------------------------------
capl_demo_data$camsa_score <- get_camsa_score(
  camsa_skill_time_score1 = capl_demo_data$camsa_skill_time_score1,
  camsa_skill_time_score2 = capl_demo_data$camsa_skill_time_score2
)

## ----warning = FALSE, message = FALSE-----------------------------------------
capl_demo_data$camsa_score

## ----warning = FALSE, message = FALSE-----------------------------------------
capl_demo_data$camsa_interpretation <- get_capl_interpretation(
  age = capl_demo_data$age,
  gender = capl_demo_data$gender,
  score = capl_demo_data$camsa_score,
  protocol = "camsa"
)

## ----warning = FALSE, message = FALSE-----------------------------------------
capl_demo_data$camsa_interpretation

## ----warning = FALSE, message = FALSE-----------------------------------------
capl_demo_data$pc_score <- get_pc_score(
  pacer_score = capl_demo_data$pacer_score,
  plank_score = capl_demo_data$plank_score,
  camsa_score = capl_demo_data$camsa_score
)

## ----warning = FALSE, message = FALSE-----------------------------------------
capl_demo_data$pc_score

## ----warning = FALSE, message = FALSE-----------------------------------------
capl_demo_data$pc_interpretation <- get_capl_interpretation(
  age = capl_demo_data$age,
  gender = capl_demo_data$gender,
  score = capl_demo_data$pc_score,
  protocol = "pc"
)

## ----warning = FALSE, message = FALSE-----------------------------------------
capl_demo_data$pc_interpretation

## ----warning = FALSE, message = FALSE-----------------------------------------
capl_demo_data$pc_status <- get_capl_domain_status(
  x = capl_demo_data,
  domain = "pc"
)

## ----warning = FALSE, message = FALSE-----------------------------------------
capl_demo_data$pc_status

## ----warning = FALSE, message = FALSE-----------------------------------------
step_df <- get_step_average(capl_demo_data)

## ----warning = FALSE, message = FALSE-----------------------------------------
str(step_df)

## ----warning = FALSE, message = FALSE-----------------------------------------
# Add the step average to the dataset
capl_demo_data$step_average <- step_df$step_average

## ----warning = FALSE, message = FALSE-----------------------------------------
capl_demo_data$step_average

## ----warning = FALSE, message = FALSE-----------------------------------------
wear_time1 <- get_pedometer_wear_time(
  time_on = capl_demo_data$time_on1,
  time_off = capl_demo_data$time_off1,
  non_wear_time = capl_demo_data$non_wear_time1
)

## ----warning = FALSE, message = FALSE-----------------------------------------
wear_time1

## ----warning = FALSE, message = FALSE-----------------------------------------
valid_steps1 <- validate_steps(
  steps = capl_demo_data$steps1,
  wear_time = wear_time1
)

## ----warning = FALSE, message = FALSE-----------------------------------------
valid_steps1

## ----warning = FALSE, message = FALSE-----------------------------------------
capl_demo_data$step_score <- get_step_score(capl_demo_data$step_average)

## ----warning = FALSE, message = FALSE-----------------------------------------
capl_demo_data$step_score

## ----warning = FALSE, message = FALSE-----------------------------------------
capl_demo_data$self_report_pa_score <- get_self_report_pa_score(capl_demo_data$self_report_pa)

## ----warning = FALSE, message = FALSE-----------------------------------------
capl_demo_data$self_report_pa_score

## ----warning = FALSE, message = FALSE-----------------------------------------
capl_demo_data$db_score <- get_db_score(
  step_score = capl_demo_data$step_score,
  self_report_pa_score = capl_demo_data$self_report_pa_score
)

## ----warning = FALSE, message = FALSE-----------------------------------------
capl_demo_data$db_score

## ----warning = FALSE, message = FALSE-----------------------------------------
capl_demo_data$db_interpretation <- get_capl_interpretation(
  age = capl_demo_data$age,
  gender = capl_demo_data$gender,
  score = capl_demo_data$db_score,
  protocol = "db"
)

## ----warning = FALSE, message = FALSE-----------------------------------------
capl_demo_data$db_interpretation

## ----warning = FALSE, message = FALSE-----------------------------------------
capl_demo_data$db_status <- get_capl_domain_status(
  x = capl_demo_data,
  domain = "db"
)

## ----warning = FALSE, message = FALSE-----------------------------------------
capl_demo_data$db_status

## ----warning = FALSE, message = FALSE-----------------------------------------
capl_demo_data$predilection_score <- get_predilection_score(
  csappa1 = capl_demo_data$csappa1,
  csappa3 = capl_demo_data$csappa3,
  csappa5 = capl_demo_data$csappa5
)

## ----warning = FALSE, message = FALSE-----------------------------------------
capl_demo_data$predilection_score

## ----warning = FALSE, message = FALSE-----------------------------------------
capl_demo_data$adequacy_score <- get_adequacy_score(
  csappa2 = capl_demo_data$csappa2,
  csappa4 = capl_demo_data$csappa4,
  csappa6 = capl_demo_data$csappa6
)

## ----warning = FALSE, message = FALSE-----------------------------------------
capl_demo_data$adequacy_score

## ----warning = FALSE, message = FALSE-----------------------------------------
capl_demo_data$intrinsic_motivation_score <- get_intrinsic_motivation_score(
  why_active1 = capl_demo_data$why_active1,
  why_active2 = capl_demo_data$why_active2,
  why_active3 = capl_demo_data$why_active3
)

## ----warning = FALSE, message = FALSE-----------------------------------------
capl_demo_data$intrinsic_motivation_score

## ----warning = FALSE, message = FALSE-----------------------------------------
capl_demo_data$pa_competence_score <- get_pa_competence_score(
  feelings_about_pa1 = capl_demo_data$feelings_about_pa1,
  feelings_about_pa2 = capl_demo_data$feelings_about_pa2,
  feelings_about_pa3 = capl_demo_data$feelings_about_pa3
)

## ----warning = FALSE, message = FALSE-----------------------------------------
capl_demo_data$pa_competence_score

## ----warning = FALSE, message = FALSE-----------------------------------------
capl_demo_data$mc_score <- get_mc_score(
  predilection_score = capl_demo_data$predilection_score,
  adequacy_score = capl_demo_data$adequacy_score,
  intrinsic_motivation_score = capl_demo_data$intrinsic_motivation_score,
  pa_competence_score = capl_demo_data$pa_competence_score
)

## ----warning = FALSE, message = FALSE-----------------------------------------
capl_demo_data$mc_score

## ----warning = FALSE, message = FALSE-----------------------------------------
capl_demo_data$mc_interpretation <- get_capl_interpretation(
  age = capl_demo_data$age,
  gender = capl_demo_data$gender,
  score = capl_demo_data$mc_score,
  protocol = "mc"
)

## ----warning = FALSE, message = FALSE-----------------------------------------
capl_demo_data$mc_interpretation

## ----warning = FALSE, message = FALSE-----------------------------------------
capl_demo_data$mc_status <- get_capl_domain_status(
  x = capl_demo_data,
  domain = "mc"
)

## ----warning = FALSE, message = FALSE-----------------------------------------
capl_demo_data$mc_status

## ----warning = FALSE, message = FALSE-----------------------------------------
capl_demo_data$pa_guideline_score <- get_binary_score(
  capl_demo_data$pa_guideline, 
  c(3, "60 minutes or 1 hour")
)

## ----warning = FALSE, message = FALSE-----------------------------------------
capl_demo_data$pa_guideline_score

## ----warning = FALSE, message = FALSE-----------------------------------------
capl_demo_data$crf_means_score <- get_binary_score(
  capl_demo_data$crf_means, 
  c(2, "How well the heart can pump blood and the lungs can provide oxygen")
)

## ----warning = FALSE, message = FALSE-----------------------------------------
capl_demo_data$crf_means_score

## ----warning = FALSE, message = FALSE-----------------------------------------
capl_demo_data$ms_means_score <- get_binary_score(
  capl_demo_data$ms_means, 
  c(1, "How well the muscles can push, pull or stretch")
)

## ----warning = FALSE, message = FALSE-----------------------------------------
capl_demo_data$ms_means_score

## ----warning = FALSE, message = FALSE-----------------------------------------
capl_demo_data$sports_skill_score <- get_binary_score(
  capl_demo_data$sports_skill, 
  c(4, "Watch a video, take a lesson or have a coach teach you how to kick and catch")
)

## ----warning = FALSE, message = FALSE-----------------------------------------
capl_demo_data$sports_skill_score

## ----warning = FALSE, message = FALSE-----------------------------------------
capl_demo_data$fill_in_the_blanks_score <- get_fill_in_the_blanks_score(
  pa_is = capl_demo_data$pa_is,
  pa_is_also = capl_demo_data$pa_is_also,
  improve = capl_demo_data$improve,
  increase = capl_demo_data$increase,
  when_cooling_down = capl_demo_data$when_cooling_down,
  heart_rate = capl_demo_data$heart_rate
)

## ----warning = FALSE, message = FALSE-----------------------------------------
capl_demo_data$fill_in_the_blanks_score

## ----warning = FALSE, message = FALSE-----------------------------------------
capl_demo_data$ku_score <- get_ku_score(
  pa_guideline_score = capl_demo_data$pa_guideline_score,
  crf_means_score = capl_demo_data$crf_means_score,
  ms_means_score = capl_demo_data$ms_means_score,
  sports_skill_score = capl_demo_data$sports_skill_score,
  fill_in_the_blanks_score = capl_demo_data$fill_in_the_blanks_score
)

## ----warning = FALSE, message = FALSE-----------------------------------------
capl_demo_data$ku_score

## ----warning = FALSE, message = FALSE-----------------------------------------
capl_demo_data$ku_interpretation <- get_capl_interpretation(
  age = capl_demo_data$age,
  gender = capl_demo_data$gender,
  score = capl_demo_data$ku_score,
  protocol = "ku"
)

## ----warning = FALSE, message = FALSE-----------------------------------------
capl_demo_data$ku_interpretation

## ----warning = FALSE, message = FALSE-----------------------------------------
capl_demo_data$ku_status <- get_capl_domain_status(
  x = capl_demo_data,
  domain = "ku"
)

## ----warning = FALSE, message = FALSE-----------------------------------------
capl_demo_data$ku_status

## ----warning = FALSE, message = FALSE-----------------------------------------
capl_demo_data$capl_score <- get_capl_score(
  pc_score = capl_demo_data$pc_score,
  db_score = capl_demo_data$db_score,
  mc_score = capl_demo_data$mc_score,
  ku_score = capl_demo_data$ku_score
)

## ----warning = FALSE, message = FALSE-----------------------------------------
capl_demo_data$capl_score

## ----warning = FALSE, message = FALSE-----------------------------------------
capl_demo_data$capl_interpretation <- get_capl_interpretation(
  age = capl_demo_data$age,
  gender = capl_demo_data$gender,
  score = capl_demo_data$capl_score,
  protocol = "capl"
)

## ----warning = FALSE, message = FALSE-----------------------------------------
capl_demo_data$capl_interpretation

## ----warning = FALSE, message = FALSE-----------------------------------------
capl_demo_data$capl_status <- get_capl_domain_status(
  x = capl_demo_data,
  domain = "capl"
)

## ----warning = FALSE, message = FALSE-----------------------------------------
capl_demo_data$capl_status

## ----warning = FALSE, message = FALSE, fig.width = 7.25, fig.height = 7.25----
get_capl_bar_plot(
  score = capl_results$pc_score,
  interpretation = capl_results$pc_interpretation,
  x_label = "Interpretation",
  y_label = "Physical competence domain score (/30)"
)

## ----warning = FALSE, message = FALSE, fig.width = 7.25, fig.height = 7.25----
get_capl_bar_plot(
  score = capl_results$db_score,
  interpretation = capl_results$db_interpretation,
  x_label = "Interpretation",
  y_label = "Daily behaviour domain score (/30)",
  colors = c("#daf7a6", "#ffc300", "#ff5733", "#c70039")
)

## ----warning = FALSE, message = FALSE, eval = FALSE---------------------------
#  export_capl_data(
#    x = capl_results,
#    file_path = "c:/path/to/store/capl-results.xlsx"
#  )
#  
#  export_capl_data(
#    x = capl_results,
#    type = "spss",
#    file_path = "c:/path/to/store/capl-results.sav"
#  )

