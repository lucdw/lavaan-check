test.id <- 'parse_YR_2024SEP23'
lavaan.model <- '
! regressions
T =~ 1*T1
T =~ 1*T2
T =~ 1*T3
T =~ 1*T4
day1 =~ 1*T1
day1 =~ 1*T2
day2 =~ 1*T3
day2 =~ 1*T4
ses1 =~ 1*T1
ses1 =~ 1*T2
ses2 =~ 1*T3
ses3 =~ 1*T4
E1 =~ 1*T1
E2 =~ 1*T2
E3 =~ 1*T3
E4 =~ 1*T4
! residuals, variances and covariances
T ~~ time*T
day1 ~~ day*day1
day2 ~~ day*day2
ses1 ~~ session*ses1
ses2 ~~ session*ses2
ses3 ~~ session*ses3
E1 ~~ e*E1
E2 ~~ e*E2
E3 ~~ e*E3
E4 ~~ e*E4
T ~~ 0*day1
T ~~ 0*day2
T ~~ 0*ses1
T ~~ 0*ses2
T ~~ 0*ses3
T ~~ 0*E1
T ~~ 0*E2
T ~~ 0*E3
T ~~ 0*E4
day1 ~~ 0*day2
day1 ~~ 0*ses1
day1 ~~ 0*ses2
day1 ~~ 0*ses3
day1 ~~ 0*E1
day1 ~~ 0*E2
day1 ~~ 0*E3
day1 ~~ 0*E4
day2 ~~ 0*ses1
day2 ~~ 0*ses2
day2 ~~ 0*ses3
day2 ~~ 0*E1
day2 ~~ 0*E2
day2 ~~ 0*E3
day2 ~~ 0*E4
ses1 ~~ 0*ses2
ses1 ~~ 0*ses3
ses1 ~~ 0*E1
ses1 ~~ 0*E2
ses1 ~~ 0*E3
ses1 ~~ 0*E4
ses2 ~~ 0*ses3
ses2 ~~ 0*E1
ses2 ~~ 0*E2
ses2 ~~ 0*E3
ses2 ~~ 0*E4
ses3 ~~ 0*E1
ses3 ~~ 0*E2
ses3 ~~ 0*E3
ses3 ~~ 0*E4
E1 ~~ 0*E2
E1 ~~ 0*E3
E1 ~~ 0*E4
E2 ~~ 0*E3
E2 ~~ 0*E4
E3 ~~ 0*E4
! observed means
T1~1
T2~1
T3~1
T4~1
!set lower bounds of variances
time > 0.0001 
day > 0.0001 
session > 0.0001 
e > 0.0001 
'
lavaan.call <- 'lavParseModelString'
lavaan.args <- list(as.data.frame. = TRUE)
reports <- 'parser'
test.comment <- 'imported from ldwParse project'
if (!exists('group.environment') || is.null(group.environment)) {
    source('utilities.R')
    execute_test(test.id, lavaan.model, lavaan.call, lavaan.args, reports, test.comment)
}
