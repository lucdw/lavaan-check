test.id <- 'parse_YR_OKT11_6'
lavaan.model <- '
 
    group: 
      f1 =~ y1 + y2 + y3
      f2 =~ y4 + y5 + y6
    group: 2
      f1 =~ y1 + y2 + y3
      f2 =~ y4 + y5 + y6
'
lavaan.call <- 'lavParseModelString'
lavaan.args <- list(as.data.frame. = TRUE)
reports <- 'parser'
test.comment <- 'imported from ldwParse project'
if (!exists('group.environment') || is.null(group.environment)) {
    source('utilities.R')
    execute_test(test.id, lavaan.model, lavaan.call, lavaan.args, reports, test.comment)
}
