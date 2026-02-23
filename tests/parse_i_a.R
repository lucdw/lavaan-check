test.id <- 'parse_i_a'
lavaan.model <- '
 f1 =~ abstract + verbal + c(l1,l1,l1,l4)*numerical
            f1 ~  c(maj,min1,maj,min2)*1 + c(NA,0,NA,0)*1
            abstract ~ c(ar1,ar2,ar3,ar3)*1
            numerical  ~ c(na1,na1,na1,na4)*1
            numerical ~~ c(e1,e1,e1,e4)*numerical
            f1 ~~ c(v1.maj,v1.min,v1.maj,v1.min)*f1

'
lavaan.call <- 'lavParseModelString'
lavaan.args <- list(as.data.frame. = TRUE)
reports <- 'parser'
test.comment <- 'imported from ldwParse project'
if (!exists('group.environment') || is.null(group.environment)) {
    source('utilities.R')
    execute_test(test.id, lavaan.model, lavaan.call, lavaan.args, reports, test.comment)
}
