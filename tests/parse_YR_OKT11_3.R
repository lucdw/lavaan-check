# Test_id : parse_YR_OKT11_3
# ==========================
# 

library(lavaan)

set.seed(1234)

Model <- c(
'
 f =~ NA*y1 + b*y2 + in1*y3 + d*in 
'
)
object <- try(lavParseModelString(
as.data.frame. = TRUE, model.syntax = Model, parser = 'new'
), outFile = stdout())
if (!inherits(object, 'try-error')) {withAutoprint({
print(as.data.frame(object))
})}
