test.id <- 'parse_f_a'
lavaan.model <- '
 Schop  =~ 6.409 * SP_A + SP_L
           Intel  =~ NA * IQ_A + IQ_L
           Intel ~~ 1*Intel

           ADVICE ~ Schop
           Schop  ~ Intel 
'
lavaan.call <- 'lavParseModelString'
lavaan.args <- list(as.data.frame. = TRUE)
reports <- 'parser'
test.comment <- 'imported from ldwParse project'
if (!exists('group.environment') || is.null(group.environment)) {
    source('utilities.R')
    execute_test(test.id, lavaan.model, lavaan.call, lavaan.args, reports, test.comment)
}
