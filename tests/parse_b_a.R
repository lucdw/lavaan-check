# Test_id : parse_b_a
# ===================
# 

library(lavaan)

set.seed(1234)

Model <- c(
'

     efa("time1")*f1 =~ a*y1 + b*y2 + c*y3 + d*y4 + e*y5 + f*y6
     efa("time1")*f2 =~ 0*y1 + h*y2 + i*y3 + j*y4 + k*y5 + l*y6

     efa("time2")*f3 =~ a*y7 + b*y8 + c*y9 + d*y10 + e*y11 + f*y12
     efa("time2")*f4 =~ 0*y7 + h*y8 + i*y9 + j*y10 + k*y11 + l*y12

     y1 ~~ y7
     y2 ~~ y8
     y3 ~~ y9
     y4 ~~ y10
     y5 ~~ y11
     y6 ~~ y12

     # free varcov f3 and f4
     f3 ~~ NA*f3 + start(1)*f3
     f4 ~~ NA*f4 + start(1)*f4
'
)
object <- try(lavParseModelString(
as.data.frame. = TRUE, model.syntax = Model, parser = 'new'
), outFile = stdout())
if (!inherits(object, 'try-error')) {withAutoprint({
print(as.data.frame(object))
})}
