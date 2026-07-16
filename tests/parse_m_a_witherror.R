# Test_id : parse_m_a
# ===================
# 

library(lavaan)

set.seed(1234)

Model <- c(
'

 F =~ 2 * x1 + 3 * label("NA") * x2 + 4 * x3 + b * x3
 G =~ z * x10 + x11 + 4 * h * x12
 H =~ x1 + x10 + 3 * x20 + 0.4 ? x21

 G ~ f1 * F +  h1 * G
 H ~ f2 * F +  g2 * G

 

 
'
)
object <- try(lavParseModelString(
as.data.frame. = TRUE, model.syntax = Model
), outFile = stdout())
if (!inherits(object, 'try-error')) {withAutoprint({
print(as.data.frame(object))
})}
