# Test_id : parse_YR_OKT18_4
# ==========================
# 

library(lavaan)

set.seed(1234)

Model <- c(
'
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
)
object <- try(lavParseModelString(
as.data.frame. = TRUE, model.syntax = Model, parser = 'new'
), outFile = stdout())
if (!inherits(object, 'try-error')) {withAutoprint({
print(as.data.frame(object))
})}
