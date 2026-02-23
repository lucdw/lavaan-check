test.id <- 'parse_YR_OKT18_5'
lavaan.model <- '
   # measurement model
    dem60 =~ y1 + y2 + y3 + y4
    dem65 =~ y5 + equal("dem60=~y2")*y6 
                + equal("dem60=~y3")*y7 
                + equal("dem60=~y4")*y8
    ind60 =~ x1 + x2 + x3

  # regressions
    dem60 ~ ind60
    dem65 ~ ind60 + dem60

  # residual correlations
    y1 ~~ y5
    y2 ~~ y4 + y6
    y3 ~~ y7
    y4 ~~ y8
    y6 ~~ y8 
'
lavaan.call <- 'lavParseModelString'
lavaan.args <- list(as.data.frame. = TRUE)
reports <- 'parser'
test.comment <- 'imported from ldwParse project'
if (!exists('group.environment') || is.null(group.environment)) {
    source('utilities.R')
    execute_test(test.id, lavaan.model, lavaan.call, lavaan.args, reports, test.comment)
}
