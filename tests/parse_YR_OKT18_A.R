# Test_id : parse_YR_OKT18_A
# ==========================
# 

library(lavaan)

set.seed(1234)

Model <- c(
'

Cry = ~ y1 + y2 + y3 + y4
Fld = ~ y2 + y3 + y5 + y6 + y7 + y8
Cry ~ edc + age
Fld ~ edc + age
'
)
object <- try(lavParseModelString(
as.data.frame. = TRUE, model.syntax = Model
), outFile = stdout())
if (!inherits(object, 'try-error')) {withAutoprint({
print(as.data.frame(object))
})}
