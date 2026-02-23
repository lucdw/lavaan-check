test.id <- "mplus_4_1a"
lavaan.model <- ''
lavaan.call <-  "efa" 
lavaan.args <- list(
  data = "ex4.1a.RDS",
  nfactors = 1:4
)
reports <- c("efa")
test.comment <- 'mplus example 4.1a'
if (!exists("group.environment") || is.null(group.environment)) {
  source("utilities.R")
  execute_test(test.id, lavaan.model, lavaan.call, lavaan.args, reports, test.comment)
}
