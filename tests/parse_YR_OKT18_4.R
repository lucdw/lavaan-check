test.id <- 'parse_YR_OKT18_4'
lavaan.model <- '
  # intercept
  i =~ 1*anti1 + 1*anti2 + 1*anti3 + 1*anti4
  i ~ 1  # mean intercept (fixed effect)
  i ~~ i # variance random intercept

  # slope
  s= ~ 0*anti1 + 1*anti2 + 2*anti3 + 3*anti4
  s ~ 1  # mean slope (fixed effect)
  s ~~ s # variance random slope

  # unequal residual variances
  anti1 ~~ anti1
  anti2 ~~ anti2
  anti3 ~~ anti3
  anti4 ~~ anti4
'
lavaan.call <- 'lavParseModelString'
lavaan.args <- list(as.data.frame. = TRUE)
reports <- 'parser'
test.comment <- 'imported from ldwParse project'
if (!exists('group.environment') || is.null(group.environment)) {
    source('utilities.R')
    execute_test(test.id, lavaan.model, lavaan.call, lavaan.args, reports, test.comment)
}
