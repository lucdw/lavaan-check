# Test_id : parse_YR_OKT11_6
# ==========================
# 

library(lavaan)

set.seed(1234)

Model <- c(
'
 
    group: 
      f1 =~ y1 + y2 + y3
      f2 =~ y4 + y5 + y6
    group: 2
      f1 =~ y1 + y2 + y3
      f2 =~ y4 + y5 + y6
'
)
object <- try(lavParseModelString(
as.data.frame. = TRUE, model.syntax = Model, parser = 'new'
), outFile = stdout())
if (!inherits(object, 'try-error')) {withAutoprint({
print(as.data.frame(object))
})}
