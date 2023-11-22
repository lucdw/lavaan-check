test.id <- "HS_cov"
lavaan.model <- '
  visual  =~ x1 + x2 + x3
  textual =~ x4 + x5 + x6
  speed   =~ x7 + x8 + x9
'
lavaan.call <-  "cfa" 
lavaan.args <- list(
  sample.cov = cov(HolzingerSwineford1939[,7:15]),
  sample.nobs = 301
  )
reports <- list(
  fitmeasures = list(rep.call = "fitMeasures", rep.args = list(), rep.tol.abs = 0.001),
  parm.est = list(rep.call = "parameterEstimates", rep.args = list(ci = FALSE), rep.ignore = NULL)
)
test.comment <- '# 2 of TESTSUITE / Misc'
if (!exists("group.environment") || is.null(group.environment)) {
  source("utilities.R")
  execute_test(test.id, lavaan.model, lavaan.call, lavaan.args, reports, test.comment)
}
