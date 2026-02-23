test.id <- 'parse_YR_OKT18_B'
lavaan.model <- '
i =~ 1*d1 + 1*d2 + 1*d3 + 1*d4 + 1*d5
+ 1*d6 + 1*d7 + 1*d8 + 1*d9 + 1*d10

s = ~ 0*d1 + 1*d2 + 2*d3 + 3*d4 + 4*d5
+ 5*d6 + 6*d7 + 7*d8 + 8*d9 + 9*d10

d1 ~~ evar*d1
d2 ~~ evar*d2
d3 ~~ evar*d3
d4 ~~ evar*d4
d5 ~~ evar*d5
d6 ~~ evar*d6
d7 ~~ evar*d7
d8 ~~ evar*d8
d9 ~~ evar*d9
d10 ~~ evar*d10

## reparameterize as sd
sdevar := sqrt(evar)
i ~~ ivar*i
isd := sqrt(ivar)
s ~~ svar*s
ssd := sqrt(svar)
i ~~ iscov*s
rho := iscov/(isd*ssd)
'
lavaan.call <- 'lavParseModelString'
lavaan.args <- list(as.data.frame. = TRUE)
reports <- 'parser'
test.comment <- 'imported from ldwParse project'
if (!exists('group.environment') || is.null(group.environment)) {
    source('utilities.R')
    execute_test(test.id, lavaan.model, lavaan.call, lavaan.args, reports, test.comment)
}
