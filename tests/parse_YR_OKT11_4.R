# Test_id : parse_YR_OKT11_4
# ==========================
# 

library(lavaan)

set.seed(1234)

Model <- c(
'

    y ~ 1*x1 + 2?x2 + 3?x3 + -4*x4 + -5?x5 + (-6)*x7 + (-5)?x8
'
)
object <- try(lavParseModelString(
as.data.frame. = TRUE, model.syntax = Model, parser = 'open'
), outFile = stdout())
if (!inherits(object, 'try-error')) {withAutoprint({
print(as.data.frame(object))
})}
