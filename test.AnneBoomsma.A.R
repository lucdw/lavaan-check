test.id <- "AnneBoomsma.A"
COR <- '
  1.0000
   .5779     1.0000
   .6106      .6403     1.0000
   .6834      .7203      .6122     1.0000
   .6585      .4860      .6638      .6274     1.0000 '
sds <- ' 2.0027  .6247  .5798  7.5342  6.4352 '
COV <- lavaan::getCov(COR, sds=sds, names=c("ADVICE", "IQ_A", "IQ_L", "SP_A", "SP_L"))
lavaan.model <- ' Schop  =~ SP_A + SP_L
           Intel  =~ IQ_A + IQ_L

           ADVICE ~ Schop
           Schop  ~ Intel '
lavaan.call <-  "sem" 
lavaan.args <- list(
  sample.cov = COV,
  sample.nobs = 276,
  likelihood = "wishart"
)
reports <- c("all", "con")
test.comment <- '6.b Anne Boomsma - sex14d - A'
if (!exists("group.environment") || is.null(group.environment)) {
  source("utilities.R")
  execute_test(test.id, lavaan.model, lavaan.call, lavaan.args, reports, test.comment)
}