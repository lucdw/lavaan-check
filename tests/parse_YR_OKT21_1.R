test.id <- 'parse_YR_OKT21_1'
lavaan.model <- '
F =~ 1*BLAD + LUNG + KID + LEUK
            F ~ CIG
            BLAD ~ 0
            LUNG ~ 0
            KID ~ 0
            LEUK ~ 0
'
lavaan.call <- 'lavParseModelString'
lavaan.args <- list(as.data.frame. = TRUE)
reports <- 'parser'
test.comment <- 'imported from ldwParse project'
if (!exists('group.environment') || is.null(group.environment)) {
    source('utilities.R')
    execute_test(test.id, lavaan.model, lavaan.call, lavaan.args, reports, test.comment)
}
