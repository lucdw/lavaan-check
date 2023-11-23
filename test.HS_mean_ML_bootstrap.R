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
reports <- list(
  parm.est = list(rep.call = "parameterEstimates", rep.args = list(ci = FALSE), rep.ignore = NULL),
  checkcovs = list(rep.call = "val_cov_lv", rep.args = list(), rep.tol.abs = NA_real_, rep.tol.rel = 0.01), 
  checkse = list(rep.call = "val_se", rep.args = list(), rep.tol.abs = NA_real_, rep.tol.rel = 0.05) 
)
test.comment <- 'bootstrap fitted parameters will allways differ !!!'
if (!exists("group.environment") || is.null(group.environment)) {
  source("utilities.R")
  execute_test(test.id, lavaan.model, lavaan.call, lavaan.args, reports, test.comment)
}