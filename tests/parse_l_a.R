# Test_id : parse_l_a
# ===================
# 

library(lavaan)

set.seed(1234)

Model <- c(
'
 aa =~ c(0.8, 0.7) * bbbb * b + sqrt(c(0.5, 0.4)) * cccc * c 
'
)
object <- try(lavParseModelString(
as.data.frame. = TRUE, model.syntax = Model, parser = 'new'
), outFile = stdout())
if (!inherits(object, 'try-error')) {withAutoprint({
print(as.data.frame(object))
})}
