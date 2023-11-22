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
reports <- list(
  summary = list(rep.call = "summary", rep.args = list(), rep.ignore = "ended normally after"),
  parm.est = list(rep.call = "parameterEstimates", rep.args = list(ci = FALSE), rep.ignore = NULL)
)
test.comment <- ''
if (!exists("group.environment") || is.null(group.environment)) {
  source("utilities.R")
  execute_test(test.id, lavaan.model, lavaan.call, lavaan.args, reports, test.comment)
}
