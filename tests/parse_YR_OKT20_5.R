test.id <- 'parse_YR_OKT20_5'
lavaan.model <- '
x =~ x1 + x2 + x3
         y =~ y1 + y2 + y3
         m ~ x
         y ~ x + m
         x ~ phantom1*phantom
         m ~ phantom2*phantom
         y ~ phantom3*phantom
         phantom =~ 0 # added for mean of zero
         phantom ~~ 1*phantom # added for unit variance
'
lavaan.call <- 'lavParseModelString'
lavaan.args <- list(as.data.frame. = TRUE)
reports <- 'parser'
test.comment <- 'imported from ldwParse project'
if (!exists('group.environment') || is.null(group.environment)) {
    source('utilities.R')
    execute_test(test.id, lavaan.model, lavaan.call, lavaan.args, reports, test.comment)
}
