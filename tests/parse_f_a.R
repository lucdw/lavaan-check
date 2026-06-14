# Test_id : parse_f_a
# ===================
# 

library(lavaan)

set.seed(1234)

Model <- c(
'
 Schop  =~ 6.409 * SP_A + SP_L
           Intel  =~ NA * IQ_A + IQ_L
           Intel ~~ 1*Intel

           ADVICE ~ Schop
           Schop  ~ Intel 
'
)
object <- try(lavParseModelString(
as.data.frame. = TRUE, model.syntax = Model, parser = 'open'
), outFile = stdout())
if (!inherits(object, 'try-error')) {withAutoprint({
print(as.data.frame(object))
})}
