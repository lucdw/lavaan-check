test.id <- 'parse_YR_OKT18_E'
lavaan.model <- '
ParentStatus~a*Age
Religiosity_7item~b*ParentStatus
Religiosity_7item~c*Age
PCAT~e*Age
Religiosity_7item~f*PCAT
ab:=a*b
ef:=e*f
total:=c+(ab)+(ef)
direct:=c
'
lavaan.call <- 'lavParseModelString'
lavaan.args <- list(as.data.frame. = TRUE)
reports <- 'parser'
test.comment <- 'imported from ldwParse project'
if (!exists('group.environment') || is.null(group.environment)) {
    source('utilities.R')
    execute_test(test.id, lavaan.model, lavaan.call, lavaan.args, reports, test.comment)
}
