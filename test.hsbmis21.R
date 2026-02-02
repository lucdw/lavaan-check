test.id <- "hsbmis21"
lavaan.model <- 'write ~ female + read + math'
lavaan.call <-  "sem" 
lavaan.args <- list(
  data = "hsbmis2.rds", 
  estimator = "mlr",
  missing = "ml"
)
reports <- c("all", "con")
test.comment <- '5. missing values on x, est = mlr'
if (!exists("group.environment") || is.null(group.environment)) {
  source("utilities.R")
  execute_test(test.id, lavaan.model, lavaan.call, lavaan.args, reports, test.comment)
}