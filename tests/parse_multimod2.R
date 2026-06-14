# Test_id : parse_multimod2
# =========================
# 

library(lavaan)

set.seed(1234)

Model <- c(
'
    F1 =~ x1 + x2 + a * x3 +
          x4 + 0.4 ? 0.5 ? b * x 5 + x6 +
          x7 + aa * 0.7 ? x3 + upper(0.8) * x5
    F2 =~ x8 + x9
    ccc := a - 2b
'
)
object <- try(lavParseModelString(
as.data.frame. = TRUE, model.syntax = Model, parser = 'open'
), outFile = stdout())
if (!inherits(object, 'try-error')) {withAutoprint({
print(as.data.frame(object))
})}
