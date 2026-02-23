test.id <- 'parse_YR_OKT18_6'
lavaan.model <- '
 visual  =~ NA*x1 + 
label("A1")*
x1+ NB*x2 + NC*x3
           textual =~ 
NA*x4 + 
label("ND")*x5

 + label("NE")*x6
           speed   =~ as.numeric(NA)*x7 + NAA*x8 + label("NA")*x9 
           visual  ~~ 1*visual; textual ~~ 1*textual
           speed   ~~ 1*speed 
'
lavaan.call <- 'lavParseModelString'
lavaan.args <- list(as.data.frame. = TRUE)
reports <- 'parser'
test.comment <- 'imported from ldwParse project'
if (!exists('group.environment') || is.null(group.environment)) {
    source('utilities.R')
    execute_test(test.id, lavaan.model, lavaan.call, lavaan.args, reports, test.comment)
}
