test.id <- 'parse_YR_OKT18_C'
lavaan.model <- '

lat =~ c(s1,s1,s1)*x+start(3.3166247903554,3.3166247903554,3.3166247903554)*x
x ~ c(m1,m2,m3)*1 + start(5,7,9)*1
y2_1 := 0.992481203007519*(m2-m1)/s1
y3_1 := 0.992555831265509*(m3-m1)/s1
'
lavaan.call <- 'lavParseModelString'
lavaan.args <- list(as.data.frame. = TRUE)
reports <- 'parser'
test.comment <- 'imported from ldwParse project'
if (!exists('group.environment') || is.null(group.environment)) {
    source('utilities.R')
    execute_test(test.id, lavaan.model, lavaan.call, lavaan.args, reports, test.comment)
}
