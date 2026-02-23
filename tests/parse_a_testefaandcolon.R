test.id <- 'parse_a_testefaandcolon'
lavaan.model <- '
    F1 =~ "a b"*X1
    F2 =~ a * X1 + 3*X2 # dat is hier een beetje commentaar
    # efa block 2
    efa("efa2")*f3 + 
    efa("efa2")*f4 =~ y1 + y2 + y3 + y1:y3
    f4 := 3.14159 * F2
    F1 ~ start(0.76)*F2 + a*F2
    a == (b + f3)^2
    b1 > exp(b2 + b3) 
'
lavaan.call <- 'lavParseModelString'
lavaan.args <- list(as.data.frame. = TRUE)
reports <- 'parser'
test.comment <- 'imported from ldwParse project'
if (!exists('group.environment') || is.null(group.environment)) {
    source('utilities.R')
    execute_test(test.id, lavaan.model, lavaan.call, lavaan.args, reports, test.comment)
}
