# Test_id : parse_YR_OKT11_1
# ==========================
# 

library(lavaan)

set.seed(1234)

Model <- c(
'
 
    f1 =~ x1 + x2 + "f1=~x2"*x3 + label("abc")*x3 # this is end-of-line comment
 
'
)
object <- try(lavParseModelString(
as.data.frame. = TRUE, model.syntax = Model
), outFile = stdout())
if (!inherits(object, 'try-error')) {withAutoprint({
print(as.data.frame(object))
})}
