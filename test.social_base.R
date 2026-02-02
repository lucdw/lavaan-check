test.id <- "social_base"
lavaan.model <- 'anti ~ b1*pos + b2*neg + b3*dis'
lavaan.call <-  "sem" 
lavaan.args <- list(
  data = "social.rds"
)
reports <- c("all", "con")
test.comment <- '3a. simple regression '
if (!exists("group.environment") || is.null(group.environment)) {
  source("utilities.R")
  execute_test(test.id, lavaan.model, lavaan.call, lavaan.args, reports, test.comment)
}
