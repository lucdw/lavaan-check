# Test_id : parse_YR_OKT12_1
# ==========================
# 

library(lavaan)

set.seed(1234)

Model <- c(
'
f =~ x1 + x2 + sqrt(3 + 7)*x3 + x4
'
)
object <- try(lavParseModelString(
as.data.frame. = TRUE, model.syntax = Model, parser = 'new'
), outFile = stdout())
if (!inherits(object, 'try-error')) {withAutoprint({
print(as.data.frame(object))
})}
