test.id <- 'parse_l_a'
lavaan.model <- '
 aa =~ c(0.8, 0.7) * bbbb * b + sqrt(c(0.5, 0.4)) * cccc * c 
'
lavaan.call <- 'lavParseModelString'
lavaan.args <- list(as.data.frame. = TRUE)
reports <- 'parser'
test.comment <- 'imported from ldwParse project'
if (!exists('group.environment') || is.null(group.environment)) {
    source('utilities.R')
    execute_test(test.id, lavaan.model, lavaan.call, lavaan.args, reports, test.comment)
}
