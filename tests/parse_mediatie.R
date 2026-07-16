# Test_id : parse_mediatie
# ========================
# 

library(lavaan)

set.seed(1234)

Model <- c(
'
     m ~ a*x
     y ~ b*m + c*x

     # indirect effect
     indirect := a*b
     total := c + a*b
'
)
object <- try(lavParseModelString(
as.data.frame. = TRUE, model.syntax = Model
), outFile = stdout())
if (!inherits(object, 'try-error')) {withAutoprint({
print(as.data.frame(object))
})}
