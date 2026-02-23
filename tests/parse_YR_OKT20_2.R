test.id <- 'parse_YR_OKT20_2'
lavaan.model <- '

   Composite model
   Image <~ IMAG1 + IMAG2 + IMAG3 + IMAG4 + IMAG5
   Expectation <~ CUEX1 + CUEX2 + CUEX3
   Value  <~ PERV1  + PERV2
   Satisfaction <~ CUSA1 + CUSA2 + CUSA3
 
   # Structural model
   Satisfaction ~ Image + Expectation + Value
'
lavaan.call <- 'lavParseModelString'
lavaan.args <- list(as.data.frame. = TRUE)
reports <- 'parser'
test.comment <- 'imported from ldwParse project'
if (!exists('group.environment') || is.null(group.environment)) {
    source('utilities.R')
    execute_test(test.id, lavaan.model, lavaan.call, lavaan.args, reports, test.comment)
}
