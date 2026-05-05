
library(lavaan)

# first continuous case
HS.model <- ' visual  =~ x1 + x2 + x3
              textual =~ x4 + x5 + x6
              speed   =~ x7 + x8 + x9 '

fit <- sem(HS.model, data=HolzingerSwineford1939, group="school",
           group.w.free=TRUE)
parameterEstimates(fit)

# binary version of Holzinger & Swineford
HS9 <- HolzingerSwineford1939[,c("x1","x2","x3","x4","x5",
                                 "x6","x7","x8","x9")]
HSbinary <- as.data.frame( lapply(HS9, cut, 2, labels=FALSE) )
HSbinary$school <- HolzingerSwineford1939$school


####### Question 1 ################

model <- 'x1 ~ x2 + x3'

fit <- sem(model, data=HolzingerSwineford1939, group="school", 
           group.w.free=TRUE, estimator="DWLS", ordered = FALSE) # force DWLS
parameterEstimates(fit)

model <- 'eta =~ x1 + x2 + x3 + x4 + x5'

fit <- sem(model, data=HSbinary, group="school", 
           group.w.free=TRUE, estimator="WLSMV", ordered=paste0("x",1:5))
parameterEstimates(fit)

fit <- sem(model, data=HSbinary, group="school", 
           group.w.free=FALSE, estimator="WLSMV", ordered=paste0("x",1:5))
parameterEstimates(fit)

