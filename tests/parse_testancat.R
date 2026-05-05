# Test_id : parse_testancat
# =========================
# 

library(lavaan)

set.seed(1234)

Model <- c(
'
   # Latent variables
    DV1 =~ Y11 + Y12 + Y13 
    DV2 =~  Y21 + Y22 + Y23
  
    M1 =~ M11 + M12 + M13 + M14
    M2 =~ 1*M21 + 1*M22
    M3 =~ 1*M31 + 1*M32
   
    # Covariances between latent variables
    DV1 ~~ DV2
    M1 ~~ M2
    M2 ~~ M3
    M1 ~~ M3

    # Regressions
    DV1 + DV2 ~ M1 + M2 + M3 + IV
    M1 + M2 + M3 ~ IV
'
)
object <- try(lavParseModelString(
as.data.frame. = TRUE, model.syntax = Model, parser = 'new'
), outFile = stdout())
if (!inherits(object, 'try-error')) {withAutoprint({
print(as.data.frame(object))
})}
