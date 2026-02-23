test.id <- 'parse_d_a'
lavaan.model <- '
     # efa
     efa("efa1")*f1 + efa("efa1")*f2 =~ y1 + y2 + y3 + y4 + y5 + y6 + y7
+ y8

     f1 + f2 ~ x1 + x2
     y1 ~ x1
     y8 ~ x2
'
lavaan.call <- 'lavParseModelString'
lavaan.args <- list(as.data.frame. = TRUE)
reports <- 'parser'
test.comment <- 'imported from ldwParse project'
if (!exists('group.environment') || is.null(group.environment)) {
    source('utilities.R')
    execute_test(test.id, lavaan.model, lavaan.call, lavaan.args, reports, test.comment)
}
