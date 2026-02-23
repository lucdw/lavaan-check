test.id <- 'parse_YR_OKT20_6'
lavaan.model <- '

 factor 1  =~ NA*V1 + V2 + V6 + V9 
 factor 2  =~ NA*V3 + V4 + V5 + V7 + V8 + V10 
 ACfactor =~  -0.061 * V1 +-0.026 * V2 +0.16 * V6 +0.137 * V9 +0.454 * V3 +0.048 * V4 +0.101 * V5 +0.125 * V7 +0.414 * V8 +0.487 * V10 
  factor 1 ~~1*factor 1 
 factor 2 ~~1*factor 2 
 
 factor 1 ~~0*ACfactor 
 factor 2 ~~0*ACfactor
'
lavaan.call <- 'lavParseModelString'
lavaan.args <- list(as.data.frame. = TRUE)
reports <- 'parser'
test.comment <- 'imported from ldwParse project'
if (!exists('group.environment') || is.null(group.environment)) {
    source('utilities.R')
    execute_test(test.id, lavaan.model, lavaan.call, lavaan.args, reports, test.comment)
}
