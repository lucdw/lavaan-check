# Test_id : parse_multimod3
# =========================
# 

library(lavaan)

set.seed(1234)

Model <- c(
'
    因子 =~ 变量1 + x2 + x3
    F1 =~ x1 + x2 + a * x3 +
          x4 + 0.4 ? 0.5 ? b * x 5 + x6 +
          x7 + aa * 0.7 ? x3 + upper(0.8) * x5
    F2 =~ x8 + x9 + x9:F1 + Güt * x6
    ccc := a - 2b
    aa < 0.8
'
)
object <- try(lavParseModelString(
as.data.frame. = TRUE, model.syntax = Model
), outFile = stdout())
if (!inherits(object, 'try-error')) {withAutoprint({
print(as.data.frame(object))
})}
