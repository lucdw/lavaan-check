test.id <- "HS_mean_GLS"
lavaan.model <- '
  visual  =~ x1 + x2 + x3
  textual =~ x4 + x5 + x6
  speed   =~ x7 + x8 + x9
'
lavaan.call <-  "sem" 
lavaan.args <- list(
  estimator = "GLS",
  data = "HS.rds",
  meanstructure = TRUE)
reports <- c("all", "con", "data")
test.comment <- ''
if (!exists("group.environment") || is.null(group.environment)) {
  source("utilities.R")
  execute_test(test.id, lavaan.model, lavaan.call, lavaan.args, reports, test.comment)
}
