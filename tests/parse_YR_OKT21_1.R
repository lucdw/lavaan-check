# Test_id : parse_YR_OKT21_1
# ==========================
# 

library(lavaan)

set.seed(1234)

Model <- c(
'
F =~ 1*BLAD + LUNG + KID + LEUK
            F ~ CIG
            BLAD ~ 0
            LUNG ~ 0
            KID ~ 0
            LEUK ~ 0
'
)
object <- try(lavParseModelString(
as.data.frame. = TRUE, model.syntax = Model, parser = 'new'
), outFile = stdout())
if (!inherits(object, 'try-error')) {withAutoprint({
print(as.data.frame(object))
})}
