test.id <- 'parse_multimod'
lavaan.model <- '
    F1 =~ x1 + x2 + a * x3 +
          x4 + b * x5 + x6 +
          x7
    F1 =~ 0.7 ? x3 + upper(0.8) * x5
    F2 =~ x8 + x9
    ccc := a - 2b
'
lavaan.call <- 'lavParseModelString'
lavaan.args <- list(as.data.frame. = TRUE)
reports <- 'parser'
test.comment <- 'imported from ldwParse project'
if (!exists('group.environment') || is.null(group.environment)) {
    source('utilities.R')
    execute_test(test.id, lavaan.model, lavaan.call, lavaan.args, reports, test.comment)
}
