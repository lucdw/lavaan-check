test.id <- 'parse_YR_OKT11_1'
lavaan.model <- '
 
    f1 =~ x1 + x2 + "f1=~x2"*x3 + label("abc")*x3 # this is end-of-line comment
 
'
lavaan.call <- 'lavParseModelString'
lavaan.args <- list(as.data.frame. = TRUE)
reports <- 'parser'
test.comment <- 'imported from ldwParse project'
if (!exists('group.environment') || is.null(group.environment)) {
    source('utilities.R')
    execute_test(test.id, lavaan.model, lavaan.call, lavaan.args, reports, test.comment)
}
