# Test_id : parse_c_a
# ===================
# 

library(lavaan)

set.seed(1234)

Model <- c(
'

  ksi1 =~ 1*V1 + V2 + V3 + V4 + V5
  ksi2 =~ NA*V5 + 1*V6 + V7 + V8

  ksi1 ~~ ksi2
  ksi1 ~~ ksi1
  ksi2 ~~ ksi2

  V1 | t1 + t2 +t3
  V2 | t1 + t2 +t3
  V3 | t1 + t2 +t3
  V4 | t1 + t2 +t3
  V5 | t1 + t2 +t3
  V6 | t1 + t2 +t3
  V7 | t1 + t2 +t3
  V8 | t1 + t2 +t3
'
)
object <- try(lavParseModelString(
as.data.frame. = TRUE, model.syntax = Model, parser = 'open'
), outFile = stdout())
if (!inherits(object, 'try-error')) {withAutoprint({
print(as.data.frame(object))
})}
