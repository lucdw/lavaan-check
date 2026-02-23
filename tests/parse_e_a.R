test.id <- 'parse_e_a'
lavaan.model <- '
    f1 =~ y1 + y2 + y3 + y4
     f2 =~ y5 + y6 + y7 + y8

     # fix marker items
     y1 ~ c(0,0)*1
     y5 ~ c(0,0)*1
'
lavaan.call <- 'lavParseModelString'
lavaan.args <- list(as.data.frame. = TRUE)
reports <- 'parser'
test.comment <- 'imported from ldwParse project'
if (!exists('group.environment') || is.null(group.environment)) {
    source('utilities.R')
    execute_test(test.id, lavaan.model, lavaan.call, lavaan.args, reports, test.comment)
}
