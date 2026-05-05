# Test_id : parse_YR_OKT11_5
# ==========================
# 

library(lavaan)

set.seed(1234)

Model <- c(
'
 
  f1 =~ a*ABSREA + c(v1,v2,v3,v4)*VERBREA + c("","","f1=~VERBREA","")*NUMER 
  VERBREA ~~ v1*VERBREA

'
)
object <- try(lavParseModelString(
as.data.frame. = TRUE, model.syntax = Model, parser = 'new'
), outFile = stdout())
if (!inherits(object, 'try-error')) {withAutoprint({
print(as.data.frame(object))
})}
