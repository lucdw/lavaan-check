test.id <- 'parse_YR_OKT20_1'
lavaan.model <- '

level =~ 1* X1 +1* X2 +1* X3 +1* X4 +1* X5 +1* X6 
 X1 ~~(vare)* X1 
 X2 ~~(vare)* X2 
 X3 ~~(vare)* X3 
 X4 ~~(vare)* X4 
 X5 ~~(vare)* X5 
 X6 ~~(vare)* X6 
'
lavaan.call <- 'lavParseModelString'
lavaan.args <- list(as.data.frame. = TRUE)
reports <- 'parser'
test.comment <- 'imported from ldwParse project'
if (!exists('group.environment') || is.null(group.environment)) {
    source('utilities.R')
    execute_test(test.id, lavaan.model, lavaan.call, lavaan.args, reports, test.comment)
}
