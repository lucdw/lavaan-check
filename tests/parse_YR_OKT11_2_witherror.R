# Test_id : parse_YR_OKT11_2
# ==========================
# 

library(lavaan)

set.seed(1234)

Model <- c(
'
f =~ in*bar
'
)
object <- try(lavParseModelString(
as.data.frame. = TRUE, model.syntax = Model
), outFile = stdout())
if (!inherits(object, 'try-error')) {withAutoprint({
print(as.data.frame(object))
})}
