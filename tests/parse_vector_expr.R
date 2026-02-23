test.id <- 'parse_vector_expr'
lavaan.model <- '
     # factor structure: common for both groups
     f1 =~ c(1, 1)*y1 + c(0.8, 0.8)*y2 + c(0.6, 0.6)*y3
     f2 =~ c(1, 1)*y4 + c(1.2, 1.2)*y5 + c(0.7, 0.7)*y6
     f3 =~ c(1, 1)*y7 + c(0.9, 0.9)*y8 + c(1.1, 1.1)*y9

     # different residual variances
     y1 ~~ c(1, 1.2)*y1
     y2 ~~ c(1, 1.2)*y2
     y3 ~~ c(1, 1.2)*y3
     y4 ~~ c(1, 1.2)*y4
     y5 ~~ c(1, 1.2)*y5
     y6 ~~ c(1, 1.2)*y6
     y7 ~~ c(1, 1.2)*y7
     y8 ~~ c(1, 1.2)*y8
     y9 ~~ c(1, 1.2)*y9

     # factor variances: different!
     f1 ~~ c(1.0, 1.2)*f1
     f2 ~~ c(0.8, 1.0)*f2
     f3 ~~ c(0.7, 1.3)*f3

     # different factor correlations
     f1 ~~ c(0.1*sqrt(1.0)*sqrt(0.8), 0.2*sqrt(1.2)*sqrt(1.0))*f2
     f1 ~~ c(0.2*sqrt(1.0)*sqrt(0.7), 0.3*sqrt(1.2)*sqrt(1.3))*f3
     f2 ~~ c(0.3*sqrt(0.8)*sqrt(0.7), 0.4*sqrt(1.0)*sqrt(1.3))*f3
'
lavaan.call <- 'lavParseModelString'
lavaan.args <- list(as.data.frame. = TRUE)
reports <- 'parser'
test.comment <- 'imported from ldwParse project'
if (!exists('group.environment') || is.null(group.environment)) {
    source('utilities.R')
    execute_test(test.id, lavaan.model, lavaan.call, lavaan.args, reports, test.comment)
}
