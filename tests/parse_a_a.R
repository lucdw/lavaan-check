# Test_id : parse_a_a
# ===================
# 

library(lavaan)

set.seed(1234)

Model <- c(
'
stdlam2 == -0.8
'
)
object <- try(lavParseModelString(
as.data.frame. = TRUE, model.syntax = Model, parser = 'new'
), outFile = stdout())
if (!inherits(object, 'try-error')) {withAutoprint({
print(as.data.frame(object))
})}
