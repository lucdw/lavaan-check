test.id <- 'parse_YR_OKT18_9'
lavaan.model <- '
 f1 =~ u1a + 1*u1b + 1*u1c 
           f2 =~ u2a + 1*u2b + 1*u2c
           u1a + u1b + u1c | a*t1
           u2a + u2b + u2c | b*t1
         
'
lavaan.call <- 'lavParseModelString'
lavaan.args <- list(as.data.frame. = TRUE)
reports <- 'parser'
test.comment <- 'imported from ldwParse project'
if (!exists('group.environment') || is.null(group.environment)) {
    source('utilities.R')
    execute_test(test.id, lavaan.model, lavaan.call, lavaan.args, reports, test.comment)
}
