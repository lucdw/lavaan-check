test.id <- 'parse_testrv'
lavaan.model <- '
     m ~ a*x
     y ~ b*m + c*x + rv("rvtje") * 1

     # indirect effect
     indirect := a*b
     total := c + a*b
'
lavaan.call <- 'lavParseModelString'
lavaan.args <- list(as.data.frame. = TRUE)
reports <- 'parser'
test.comment <- 'imported from ldwParse project'
if (!exists('group.environment') || is.null(group.environment)) {
    source('utilities.R')
    execute_test(test.id, lavaan.model, lavaan.call, lavaan.args, reports, test.comment)
}
