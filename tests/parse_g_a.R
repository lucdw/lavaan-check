# Test_id : parse_g_a
# ===================
# 

library(lavaan)

set.seed(1234)

Model <- c(
'
visual  =~ NA*x1 + label("A1")*x1+ NB*x2 + NC*x3
            textual =~ NA*x4 + label("ND")*x5 + label("NE")*x6
            speed   =~ as.numeric(NA)*x7 + NAA*x8 + label("NA")*x9
            visual  ~~ 1*visual; textual ~~ 1*textual
            speed   ~~ 1*speed
'
)
object <- try(lavParseModelString(
as.data.frame. = TRUE, model.syntax = Model, parser = 'new'
), outFile = stdout())
if (!inherits(object, 'try-error')) {withAutoprint({
print(as.data.frame(object))
})}
