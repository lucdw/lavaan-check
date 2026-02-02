test.id <- "social_missml"
lavaan.model <- 'anti ~ b1*pos + b2*neg + b3*dis'
lavaan.call <-  "sem" 
lavaan.args <- list(
  data = "social.rds", 
  missing = "ml",
  warn = FALSE
)
reports <- c("all", "con")
test.comment <- '3a. simple regression - missing = "ml" '
if (!exists("group.environment") || is.null(group.environment)) {
  source("utilities.R")
  execute_test(test.id, lavaan.model, lavaan.call, lavaan.args, reports, test.comment)
}