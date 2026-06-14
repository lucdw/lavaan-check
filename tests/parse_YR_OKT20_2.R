# Test_id : parse_YR_OKT20_2
# ==========================
# 

library(lavaan)

set.seed(1234)

Model <- c(
'

   Composite model
   Image <~ IMAG1 + IMAG2 + IMAG3 + IMAG4 + IMAG5
   Expectation <~ CUEX1 + CUEX2 + CUEX3
   Value  <~ PERV1  + PERV2
   Satisfaction <~ CUSA1 + CUSA2 + CUSA3
 
   # Structural model
   Satisfaction ~ Image + Expectation + Value
'
)
object <- try(lavParseModelString(
as.data.frame. = TRUE, model.syntax = Model, parser = 'open'
), outFile = stdout())
if (!inherits(object, 'try-error')) {withAutoprint({
print(as.data.frame(object))
})}
