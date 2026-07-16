# Test_id : parse_YR_OKT18_D
# ==========================
# 

library(lavaan)

set.seed(1234)

Model <- c(
'

    f1=~ 1.000000e+00*x3
'
)
object <- try(lavParseModelString(
as.data.frame. = TRUE, model.syntax = Model
), outFile = stdout())
if (!inherits(object, 'try-error')) {withAutoprint({
print(as.data.frame(object))
})}
