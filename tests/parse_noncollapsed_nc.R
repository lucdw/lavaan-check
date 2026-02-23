test.id <- 'parse_noncollapsed_nc'
lavaan.model <- '

 # non collapsed model
 # some more comments
LV1 =~ x1 + x2 + x3
'
lavaan.call <- 'lavParseModelString'
lavaan.args <- list(as.data.frame. = TRUE)
reports <- 'parser'
test.comment <- 'imported from ldwParse project'
if (!exists('group.environment') || is.null(group.environment)) {
    source('utilities.R')
    execute_test(test.id, lavaan.model, lavaan.call, lavaan.args, reports, test.comment)
}
