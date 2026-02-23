test.id <- 'parse_testefacfaccc'
lavaan.model <- '
    # efa block 1
    efa("efa1")*f1 + 
    efa("efa1")*f2 =~ x1 + x2 + x3 

    # efa block 2
    efa("efa2")*f3 + 
    efa("efa2")*f4 =~ y1 + y2 + y6

    # cfa block
    f5 =~ NA * z7 + 2 * z8 + coefz8 * z8 + z9 + z7:z9
    f6 =~ z10 + z11 + c(1, NA, 2) * z12

    # regressions
    f3 ~ 1 + f1 + 0.3 ? f2
    f4 ~ f3
'
lavaan.call <- 'lavParseModelString'
lavaan.args <- list(as.data.frame. = TRUE)
reports <- 'parser'
test.comment <- 'imported from ldwParse project'
if (!exists('group.environment') || is.null(group.environment)) {
    source('utilities.R')
    execute_test(test.id, lavaan.model, lavaan.call, lavaan.args, reports, test.comment)
}
