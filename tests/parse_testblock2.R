test.id <- 'parse_testblock2'
lavaan.model <- '
    block : 1
    fx =~ x1 + y2 + z9
    f1 =~ x1 + x2 + x3 + x4 + x5 + x6
    block : 2
    f4 =~ y1 + y2 + y3 + y4 + y5 + y6
    block : 3
    f5 =~ z7 + z8 + z9 + z7:z9
    f6 =~ z10 + z11 + z12

    # regressions
    f5 ~ f1 + f4
    f6 ~ f4 + f5
'
lavaan.call <- 'lavParseModelString'
lavaan.args <- list(as.data.frame. = TRUE)
reports <- 'parser'
test.comment <- 'imported from ldwParse project'
if (!exists('group.environment') || is.null(group.environment)) {
    source('utilities.R')
    execute_test(test.id, lavaan.model, lavaan.call, lavaan.args, reports, test.comment)
}
