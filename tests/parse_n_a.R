test.id <- 'parse_n_a'
lavaan.model <- '

 F =~ 2 * x1 + 3 * label("NA") * x2 + 4 * x3 + b * x3
 G =~ z * x10 + x11 + 4 * h * x12
 H =~ x1 + x10 + 3 * x20 + 0.4 ? x21

 G ~ f1 * F +  0 * G
 H ~ f2 * F +  g2 * G

 

 
'
lavaan.call <- 'lavParseModelString'
lavaan.args <- list(as.data.frame. = TRUE)
reports <- 'parser'
test.comment <- 'imported from ldwParse project'
if (!exists('group.environment') || is.null(group.environment)) {
    source('utilities.R')
    execute_test(test.id, lavaan.model, lavaan.call, lavaan.args, reports, test.comment)
}
