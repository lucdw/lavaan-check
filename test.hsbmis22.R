test.id <- "hsbmis22"
lavaan.model <- 'write ~ female + read + math'
lavaan.call <-  "sem" 
lavaan.args <- list(
  data = "hsbmis2.rds", 
  estimator = "gls"
)
reports <- c("all", "con")
test.comment <- '5. missing values on x, est = gls'
if (!exists("group.environment") || is.null(group.environment)) {
  source("utilities.R")
  execute_test(test.id, lavaan.model, lavaan.call, lavaan.args, reports, test.comment)
}