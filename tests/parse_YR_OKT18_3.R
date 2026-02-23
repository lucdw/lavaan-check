test.id <- 'parse_YR_OKT18_3'
lavaan.model <- '
 ksi1 =~ 1*V1 + V2 + V3 + V4 + V5
 ksi2 =~ 1*V6 + V7 + V8  

 ksi1 ~~ ksi2
 ksi1 ~~ ksi1
 ksi2 ~~ ksi2

 V1 | t1 + t2 + t3
 V2 | t1 + t2 + t3
 V3 | t1 + t2 + t3
 V4 | t1 + t2 + t3
 V5 | t1 + t2 + t3
 V6 | t1 + t2 + t3
 V7 | t1 + t2 + t3
 V8 | t1 + t2 + t3
'
lavaan.call <- 'lavParseModelString'
lavaan.args <- list(as.data.frame. = TRUE)
reports <- 'parser'
test.comment <- 'imported from ldwParse project'
if (!exists('group.environment') || is.null(group.environment)) {
    source('utilities.R')
    execute_test(test.id, lavaan.model, lavaan.call, lavaan.args, reports, test.comment)
}
