# Test_id : parse_YR_20260317
# ===========================
# error detected on mars 17, 2026

library(lavaan)

set.seed(1234)

Model <- c(
'
   f1 =~ 1*x1 + 0.7*x2 + 0.5*x3
   f2 =~ 1*x4 + 0.8*x5 + 1.1*x6
   f1 ~~ 0.6*f1
   f2 ~~ 0.6*f2
   f1 ~~ 0.3*f2
   x1 | -0.1*t1
   x2 | -0.2*t1
   x3 | -0.3*t1
   x4 |  0.3*t1
   x5 |  0.2*t1
   x6 |  0.1*t1
'
)
object <- try(lavParseModelString(
as.data.frame. = TRUE, model.syntax = Model, parser = 'new'
), outFile = stdout())
if (!inherits(object, 'try-error')) {withAutoprint({
print(as.data.frame(object))
})}
