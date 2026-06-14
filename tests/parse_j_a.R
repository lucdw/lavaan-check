# Test_id : parse_j_a
# ===================
# 

library(lavaan)

set.seed(1234)

Model <- c(
'
 block : 1 
 f1 =~ abstract + verbal + c(l1,l1,l1,l4)*numerical
            f1 ~  c(maj,min1,maj,min2)*1 + c(NA,0,NA,0)*1
            abstract ~ c(ar1,ar2,ar3,ar3)*1
            numerical  ~ c(na1,na1,na1,na4)*1
            numerical ~~ c(e1,e1,e1,e4)*numerical
            f1 ~~ c(v1.maj,v1.min,v1.maj,v1.min)*f1

'
)
object <- try(lavParseModelString(
as.data.frame. = TRUE, model.syntax = Model, parser = 'open'
), outFile = stdout())
if (!inherits(object, 'try-error')) {withAutoprint({
print(as.data.frame(object))
})}
