test.id <- 'parse_YR_OKT20_7'
lavaan.model <- '

    Observe =~ item1 + item6 + item11 + item15 +
               item20 + item26 + item31 + item 36
'
lavaan.call <- 'lavParseModelString'
lavaan.args <- list(as.data.frame. = TRUE)
reports <- 'parser'
test.comment <- 'imported from ldwParse project'
if (!exists('group.environment') || is.null(group.environment)) {
    source('utilities.R')
    execute_test(test.id, lavaan.model, lavaan.call, lavaan.args, reports, test.comment)
}
