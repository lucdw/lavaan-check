# Test_id : parse_YR_OKT18_C
# ==========================
# 

library(lavaan)

set.seed(1234)

Model <- c(
'

lat =~ c(s1,s1,s1)*x+start(3.3166247903554,3.3166247903554,3.3166247903554)*x
x ~ c(m1,m2,m3)*1 + start(5,7,9)*1
y2_1 := 0.992481203007519*(m2-m1)/s1
y3_1 := 0.992555831265509*(m3-m1)/s1
'
)
object <- try(lavParseModelString(
as.data.frame. = TRUE, model.syntax = Model, parser = 'new'
), outFile = stdout())
if (!inherits(object, 'try-error')) {withAutoprint({
print(as.data.frame(object))
})}
