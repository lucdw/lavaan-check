test.id <- "HS_ML_nodata1"
lavaan.model <- '
  visual  =~ x1 + x2 + x3
  textual =~ x4 + x5 + x6
  speed   =~ x7 + x8 + x9
'
lavaan.call <-  "sem" 
lavaan.args <- list()
reports <- list(
  sumfitted = list(rep.call = "txt_sum_fitted", rep.args = list())
)
test.comment <- 'a run without data'
if (!exists("group.environment") || is.null(group.environment)) {
  source("utilities.R")
  if (file.exists(ownrep)) source(ownrep) # own reports for this group of tests
  execute_test(test.id, lavaan.model, lavaan.call, lavaan.args, reports, test.comment)
}