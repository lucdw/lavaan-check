# Test_id : parse_YR_OKT18_2
# ==========================
# 

library(lavaan)

set.seed(1234)

Model <- c(
'

    # efa
    efa("efa1")*f1 + efa("efa1")*f2 =~ 
        y1 + y2 + y3 + y4 + y5 + y6 + y7 + y8 + y9 + y10
'
)
object <- try(lavParseModelString(
as.data.frame. = TRUE, model.syntax = Model
), outFile = stdout())
if (!inherits(object, 'try-error')) {withAutoprint({
print(as.data.frame(object))
})}
