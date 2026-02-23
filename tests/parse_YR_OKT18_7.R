test.id <- 'parse_YR_OKT18_7'
lavaan.model <- '
 visual  =~ x1 + 0.5*x2 + c(0.6, 0.8)*x3
           textual =~ x4 + start(c(1.2, 0.6))*x5 + c(a,b)*x6
           speed   =~ x7 + equal(c("textual=~x5","textual=~x5.g2"))*x8
                         + equal(c("a","a"))*x9 
           speed ~~ equal(c("","speed~~speed"))*speed
           visual ~~ label(c("V1","V2"))*visual
         
'
lavaan.call <- 'lavParseModelString'
lavaan.args <- list(as.data.frame. = TRUE)
reports <- 'parser'
test.comment <- 'imported from ldwParse project'
if (!exists('group.environment') || is.null(group.environment)) {
    source('utilities.R')
    execute_test(test.id, lavaan.model, lavaan.call, lavaan.args, reports, test.comment)
}
