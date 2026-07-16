# Test_id : parse_noncollapsed_nc
# ===============================
# 

library(lavaan)

set.seed(1234)

Model <- c(
'

 # non collapsed model
 # some more comments
LV1 =~ x1 + x2 + x3
'
)
object <- try(lavParseModelString(
as.data.frame. = TRUE, model.syntax = Model
), outFile = stdout())
if (!inherits(object, 'try-error')) {withAutoprint({
print(as.data.frame(object))
})}
