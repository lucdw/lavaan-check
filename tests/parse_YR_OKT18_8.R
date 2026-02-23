test.id <- 'parse_YR_OKT18_8'
lavaan.model <- '
est ~ age + c(m1, f1)*tvlo + hadsum + start(-0.1, 0.1)*tvlo
          hadsum ~ age + c(m2, f2)*tvlo + start(-0.2, 0.2)*tvlo
'
lavaan.call <- 'lavParseModelString'
lavaan.args <- list(as.data.frame. = TRUE)
reports <- 'parser'
test.comment <- 'imported from ldwParse project'
if (!exists('group.environment') || is.null(group.environment)) {
    source('utilities.R')
    execute_test(test.id, lavaan.model, lavaan.call, lavaan.args, reports, test.comment)
}
