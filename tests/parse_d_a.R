# Test_id : parse_d_a
# ===================
# 

library(lavaan)

set.seed(1234)

Model <- c(
'
     # efa
     efa("efa1")*f1 + efa("efa1")*f2 =~ y1 + y2 + y3 + y4 + y5 + y6 + y7
+ y8

     f1 + f2 ~ x1 + x2
     y1 ~ x1
     y8 ~ x2
'
)
object <- try(lavParseModelString(
as.data.frame. = TRUE, model.syntax = Model, parser = 'open'
), outFile = stdout())
if (!inherits(object, 'try-error')) {withAutoprint({
print(as.data.frame(object))
})}
