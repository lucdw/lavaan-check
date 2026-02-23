test.id <- 'parse_testtwolevellabels'
lavaan.model <- '
  group: type1
    level: within
      fac =~ y1 + L2*y2 + L3*y3
    level: between
      fac =~ y1 + L2*y2 + L3*y3
     
  group: type2w
    level: within
      fac =~ y1 + L2*y2 + L3*y3
    level: between
      fac =~ y1 + L2*y2 + L3*y3

'
lavaan.call <- 'lavParseModelString'
lavaan.args <- list(as.data.frame. = TRUE)
reports <- 'parser'
test.comment <- 'imported from ldwParse project'
if (!exists('group.environment') || is.null(group.environment)) {
    source('utilities.R')
    execute_test(test.id, lavaan.model, lavaan.call, lavaan.args, reports, test.comment)
}
