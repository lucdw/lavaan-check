# Test_id : parse_testblock
# =========================
# 

library(lavaan)

set.seed(1234)

Model <- c(
'
    fx =~ x1 + y2 + z9
    block : 1
    f1 =~ x1 + x2 + x3 + x4 + x5 + x6
    block : 2
    f4 =~ y1 + y2 + y3 + y4 + y5 + y6
    block : 3
    f5 =~ z7 + z8 + z9 + z7:z9
    f6 =~ z10 + z11 + z12

    # regressions
    f5 ~ f1 + f4
    f6 ~ f4 + f5
'
)
object <- try(lavParseModelString(
as.data.frame. = TRUE, model.syntax = Model, parser = 'open'
), outFile = stdout())
if (!inherits(object, 'try-error')) {withAutoprint({
print(as.data.frame(object))
})}
