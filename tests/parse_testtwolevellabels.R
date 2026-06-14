# Test_id : parse_testtwolevellabels
# ==================================
# 

library(lavaan)

set.seed(1234)

Model <- c(
'
  group: type1
    level: within
      fac =~ y1 + L2*y2 + L3*y3
    level: between
      fac =~ y1 + L2*y2 + L3*y3
     
  group: type2w
    level: within
      fac =~ y1 + L2*y2 + L3*y3
    level: between
      fac =~ y1 + L2*y2 + L3*y3

'
)
object <- try(lavParseModelString(
as.data.frame. = TRUE, model.syntax = Model, parser = 'open'
), outFile = stdout())
if (!inherits(object, 'try-error')) {withAutoprint({
print(as.data.frame(object))
})}
