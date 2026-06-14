# Test_id : parse_YR_OKT20_3_nc
# =============================
# 

library(lavaan)

set.seed(1234)

Model <- c(
'
m ~ x
y ~ m
asq := 1
ab  := 2
not in table
'
)
object <- try(lavParseModelString(
as.data.frame. = TRUE, model.syntax = Model, parser = 'open'
), outFile = stdout())
if (!inherits(object, 'try-error')) {withAutoprint({
print(as.data.frame(object))
})}
