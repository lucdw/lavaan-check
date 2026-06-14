# Test_id : parse_e_a
# ===================
# 

library(lavaan)

set.seed(1234)

Model <- c(
'
    f1 =~ y1 + y2 + y3 + y4
     f2 =~ y5 + y6 + y7 + y8

     # fix marker items
     y1 ~ c(0,0)*1
     y5 ~ c(0,0)*1
'
)
object <- try(lavParseModelString(
as.data.frame. = TRUE, model.syntax = Model, parser = 'open'
), outFile = stdout())
if (!inherits(object, 'try-error')) {withAutoprint({
print(as.data.frame(object))
})}
