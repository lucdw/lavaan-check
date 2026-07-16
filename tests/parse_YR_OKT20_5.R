# Test_id : parse_YR_OKT20_5
# ==========================
# 

library(lavaan)

set.seed(1234)

Model <- c(
'
x =~ x1 + x2 + x3
         y =~ y1 + y2 + y3
         m ~ x
         y ~ x + m
         x ~ phantom1*phantom
         m ~ phantom2*phantom
         y ~ phantom3*phantom
         phantom =~ 0 # added for mean of zero
         phantom ~~ 1*phantom # added for unit variance
'
)
object <- try(lavParseModelString(
as.data.frame. = TRUE, model.syntax = Model
), outFile = stdout())
if (!inherits(object, 'try-error')) {withAutoprint({
print(as.data.frame(object))
})}
