# Test_id : parse_YR_OKT18_E
# ==========================
# 

library(lavaan)

set.seed(1234)

Model <- c(
'
ParentStatus~a*Age
Religiosity_7item~b*ParentStatus
Religiosity_7item~c*Age
PCAT~e*Age
Religiosity_7item~f*PCAT
ab:=a*b
ef:=e*f
total:=c+(ab)+(ef)
direct:=c
'
)
object <- try(lavParseModelString(
as.data.frame. = TRUE, model.syntax = Model, parser = 'new'
), outFile = stdout())
if (!inherits(object, 'try-error')) {withAutoprint({
print(as.data.frame(object))
})}
