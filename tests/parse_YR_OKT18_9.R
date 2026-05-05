# Test_id : parse_YR_OKT18_9
# ==========================
# 

library(lavaan)

set.seed(1234)

Model <- c(
'
 f1 =~ u1a + 1*u1b + 1*u1c 
           f2 =~ u2a + 1*u2b + 1*u2c
           u1a + u1b + u1c | a*t1
           u2a + u2b + u2c | b*t1
         
'
)
object <- try(lavParseModelString(
as.data.frame. = TRUE, model.syntax = Model, parser = 'new'
), outFile = stdout())
if (!inherits(object, 'try-error')) {withAutoprint({
print(as.data.frame(object))
})}
