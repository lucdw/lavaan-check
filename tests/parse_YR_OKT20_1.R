# Test_id : parse_YR_OKT20_1
# ==========================
# 

library(lavaan)

set.seed(1234)

Model <- c(
'

level =~ 1* X1 +1* X2 +1* X3 +1* X4 +1* X5 +1* X6 
 X1 ~~(vare)* X1 
 X2 ~~(vare)* X2 
 X3 ~~(vare)* X3 
 X4 ~~(vare)* X4 
 X5 ~~(vare)* X5 
 X6 ~~(vare)* X6 
'
)
object <- try(lavParseModelString(
as.data.frame. = TRUE, model.syntax = Model, parser = 'new'
), outFile = stdout())
if (!inherits(object, 'try-error')) {withAutoprint({
print(as.data.frame(object))
})}
