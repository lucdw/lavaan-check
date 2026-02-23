test.id <- 'parse_YR_OKT11_4'
lavaan.model <- '

    y ~ 1*x1 + 2?x2 + 3?x3 + -4*x4 + -5?x5 + (-6)*x7 + (-5)?x8
'
lavaan.call <- 'lavParseModelString'
lavaan.args <- list(as.data.frame. = TRUE)
reports <- 'parser'
test.comment <- 'imported from ldwParse project'
if (!exists('group.environment') || is.null(group.environment)) {
    source('utilities.R')
    execute_test(test.id, lavaan.model, lavaan.call, lavaan.args, reports, test.comment)
}
