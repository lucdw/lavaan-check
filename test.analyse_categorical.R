test.id <- "analyse_categorical"
lavaan.model <- '
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
lavaan.call <-  "sem" 
lavaan.args <- list(
  data = "DF.rds",
  ordered = paste0("M",11:14),
  missing = "pairwise",
  control = list(iter.max = 500L)
)
reports <- c("all", "cat")
test.comment <- '6q. non-convergence WLSMV + pairwise (scaling issue)'
if (!exists("group.environment") || is.null(group.environment)) {
  source("utilities.R")
  execute_test(test.id, lavaan.model, lavaan.call, lavaan.args, reports, test.comment)
}
