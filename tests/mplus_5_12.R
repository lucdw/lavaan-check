test.id <- "mplus_5_12"
lavaan.model <- '
f1 =~ y1 + y2 + y3
f2 =~ y4 + y5 + y6
f3 =~ y7 + y8 + y9
f4 =~ y10 + y11 + y12
f3 ~ f3f1 * f1 + f3f2 * f2
f4 ~ f4f3 * f3
ind := f4f3 * f3f1
'
lavaan.call <-  "sem" 
lavaan.args <- list(
  data = "mplus_ex5_12.RDS",
  estimator = "ML",
  information = "observed",
  meanstructure = TRUE
)
reports <- c("all")
test.comment <- 'mplus example 5.12'
if (!exists("group.environment") || is.null(group.environment)) {
  source("utilities.R")
  execute_test(test.id, lavaan.model, lavaan.call, lavaan.args, reports, test.comment)
}
