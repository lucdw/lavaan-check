# Test_id : parse_YR_OKT20_7
# ==========================
# 

library(lavaan)

set.seed(1234)

Model <- c(
'

    Observe =~ item1 + item6 + item11 + item15 +
               item20 + item26 + item31 + item 36
'
)
object <- try(lavParseModelString(
as.data.frame. = TRUE, model.syntax = Model
), outFile = stdout())
if (!inherits(object, 'try-error')) {withAutoprint({
print(as.data.frame(object))
})}
