test.id <- "social_constraints"
lavaan.model <- 'anti ~ b1*pos + b2*neg + b3*dis'
lavaan.call <-  "sem" 
lavaan.args <- list(
  data = "social.rds", 
  constraints = ' b1 < b3; b2 < b3'
)
reports <- c("all", "con")
test.comment <- '3a. simple regression with constraints'
if (!exists("group.environment") || is.null(group.environment)) {
  source("utilities.R")
  execute_test(test.id, lavaan.model, lavaan.call, lavaan.args, reports, test.comment)
}
