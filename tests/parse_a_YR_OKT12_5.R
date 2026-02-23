test.id <- 'parse_a_YR_OKT12_5'
lavaan.model <- '
f =~ x1 + x2 + paste0("aaa", rep("b", 3))*x3 + x4
'
lavaan.call <- 'lavParseModelString'
lavaan.args <- list(as.data.frame. = TRUE)
reports <- 'parser'
test.comment <- 'imported from ldwParse project'
if (!exists('group.environment') || is.null(group.environment)) {
    source('utilities.R')
    execute_test(test.id, lavaan.model, lavaan.call, lavaan.args, reports, test.comment)
}
