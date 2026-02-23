test.id <- 'parse_YR_OKT11_5'
lavaan.model <- '
 
  f1 =~ a*ABSREA + c(v1,v2,v3,v4)*VERBREA + c("","","f1=~VERBREA","")*NUMER 
  VERBREA ~~ v1*VERBREA

'
lavaan.call <- 'lavParseModelString'
lavaan.args <- list(as.data.frame. = TRUE)
reports <- 'parser'
test.comment <- 'imported from ldwParse project'
if (!exists('group.environment') || is.null(group.environment)) {
    source('utilities.R')
    execute_test(test.id, lavaan.model, lavaan.call, lavaan.args, reports, test.comment)
}
