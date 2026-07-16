# Test_id : parse_YR_OKT18_8
# ==========================
# 

library(lavaan)

set.seed(1234)

Model <- c(
'
est ~ age + c(m1, f1)*tvlo + hadsum + start(-0.1, 0.1)*tvlo
          hadsum ~ age + c(m2, f2)*tvlo + start(-0.2, 0.2)*tvlo
'
)
object <- try(lavParseModelString(
as.data.frame. = TRUE, model.syntax = Model
), outFile = stdout())
if (!inherits(object, 'try-error')) {withAutoprint({
print(as.data.frame(object))
})}
