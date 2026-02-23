test.id <- "HS_mean_ML_bootstrap"
lavaan.model <- '
  visual  =~ x1 + x2 + x3
  textual =~ x4 + x5 + x6
  speed   =~ x7 + x8 + x9
'
lavaan.call <-  "sem" 
lavaan.args <- list(
  estimator = "ML",
  information = "observed",
  se = "bootstrap",
  bootstrap = 200,
  data = "HS.rds",
  meanstructure = TRUE)
reports <- c("bootse")
test.comment <- 'bootstrap fitted parameters will allways differ !!!'
if (!exists("group.environment") || is.null(group.environment)) {
  source("utilities.R")
  execute_test(test.id, lavaan.model, lavaan.call, lavaan.args, reports, test.comment)
}