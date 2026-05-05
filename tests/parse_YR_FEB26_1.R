# Test_id : parse_YR_FEB26_1
# ==========================
# 

library(lavaan)

set.seed(1234)

Model <- c(
'
Sepal.Width ~~
   Sepal.Length
'
)
object <- try(lavParseModelString(
as.data.frame. = TRUE, model.syntax = Model, parser = 'new'
), outFile = stdout())
if (!inherits(object, 'try-error')) {withAutoprint({
print(as.data.frame(object))
})}
