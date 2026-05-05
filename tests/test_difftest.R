 library(lavaan)
data("HolzingerSwineford1939")
HS <- HolzingerSwineford1939

mod1 <- '
visual  =~ x1 + x2 + x3
textual =~ x4 + x5 + x6
speed   =~ x7 + x8 + x9 '
fit1.mlm  <- sem(mod1, data = HS, estimator = "mlm")
fit1.mlr  <- sem(mod1, data = HS, estimator = "mlr")
fit1.mlre <- sem(mod1, data = HS, estimator = "mlr",
                 information = "expected")

mod2 <- '
visual  =~ 1*x1 + 1*x2 + 1*x3
textual =~ x4 + x5 + x6
speed   =~ x7 + x8 + x9 '
fit2.mlm  <- sem(mod2, data = HS, estimator = "mlm")
fit2.mlr  <- sem(mod2, data = HS, estimator = "mlr")
fit2.mlre <- sem(mod2, data = HS, estimator = "mlr",
                 information = "expected")


lavTestLRT(fit1.mlm, fit2.mlm, method = "Satorra.Bentler.2001")
lavTestLRT(fit1.mlm, fit2.mlm, method = "Satorra.Bentler.2010")
lavTestLRT(fit1.mlm, fit2.mlm, method = "Satorra2000")

lavTestLRT(fit1.mlr, fit2.mlr, method = "Satorra.Bentler.2001")
lavTestLRT(fit1.mlr, fit2.mlr, method = "Satorra.Bentler.2010")
# not so good...
lavTestLRT(fit1.mlr, fit2.mlr, method = "Satorra2000")

lavTestLRT(fit1.mlre, fit2.mlre, method = "Satorra.Bentler.2001")
lavTestLRT(fit1.mlre, fit2.mlre, method = "Satorra.Bentler.2010")
lavTestLRT(fit1.mlre, fit2.mlre, method = "Satorra2000")

HS.model <- '
    visual =~ x1 + lam2*x2 + x3
    textual =~ x4 + x5 + x6
    speed =~ x7 + x8 + x9
    x1 ~~ x1 + psi1*x1
    x2 ~~ x2 + psi2*x2
    x3 ~~ x3 + psi3*x3
    x4 ~~ x4 + psi4*x4
    x5 ~~ x5 + psi5*x5
    x6 ~~ x6 + psi6*x6
    x7 ~~ x7 + psi7*x7
    x8 ~~ x8 + psi8*x8
    x9 ~~ x9 + psi9*x9
    stdlam2 := lam2/sqrt(lam2^2 + psi2)
'
fit <- lavaan(HS.model, data=HolzingerSwineford1939,
    auto.var=TRUE, auto.fix.first=FALSE, std.lv=TRUE,
    auto.cov.lv.x=TRUE, estimator="MLM",
    meanstructure=TRUE, int.ov.free=TRUE)

const<-"stdlam2 == -0.8"
fit.const <- lavaan(HS.model, data=HolzingerSwineford1939,constraints=const,
    auto.var=TRUE, auto.fix.first=FALSE, std.lv=TRUE,
    auto.cov.lv.x=TRUE, estimator="MLM",
    meanstructure=TRUE, int.ov.free=TRUE)

lavTestLRT(fit,fit.const,method="satorra.bentler.2001") # positive
lavTestLRT(fit,fit.const,method="satorra.bentler.2010")

HS.model <- '
    visual =~ x1 + start(0.7)*x2 + lam2*x2 + x3
    textual =~ x4 + x5 + x6
    speed =~ x7 + x8 + x9
    x1 ~~ start(0.5)*x1 + psi1*x1
    x2 ~~ x2 + psi2*x2
    x3 ~~ x3 + psi3*x3
    x4 ~~ x4 + psi4*x4
    x5 ~~ x5 + psi5*x5
    x6 ~~ x6 + psi6*x6
    x7 ~~ x7 + psi7*x7
    x8 ~~ x8 + psi8*x8
    x9 ~~ x9 + psi9*x9
    stdlam2 := lam2/sqrt(lam2^2 + psi2)
'
fit <- lavaan(HS.model, data=HolzingerSwineford1939,
    auto.var=TRUE, auto.fix.first=FALSE, std.lv=TRUE,
    auto.cov.lv.x=TRUE, estimator="MLM",
    meanstructure=TRUE, int.ov.free=TRUE)

const<-"stdlam2 == -0.8"
fit.const <- lavaan(HS.model, data=HolzingerSwineford1939,constraints=const,
    auto.var=TRUE, auto.fix.first=FALSE, std.lv=TRUE,
    auto.cov.lv.x=TRUE, estimator="MLM",
    meanstructure=TRUE, int.ov.free=TRUE)

lavTestLRT(fit,fit.const,method="satorra.bentler.2001") # positive
lavTestLRT(fit,fit.const,method="satorra.bentler.2010")

# categorical
Data <- read.table("~/semtest/CAT/ex5.2.dat")
names(Data) <- c("u1","u2","u3","u4","u5","u6")

model <- ' f1 =~ u1 + u2 + u3
           f2 =~ u4 + u5 + u6 '

fit <- cfa(model, data=Data, estimator="DWLS", mimic="Mplus",
           se="robust.sem", test="mean.var.adjusted", ordered = names(Data))
summary(fit)

model0 <- ' f1 =~ u1 + u2 + u3
            f2 =~ u4 + u5 + u6
            f1 ~~ 0*f2
          '
fit0 <- cfa(model0, data=Data, estimator="DWLS", mimic="Mplus",
            se="robust.sem", test="mean.var.adjusted", ordered = names(Data))
summary(fit0)
anova(fit, fit0)

# KU_44.difftest
Data <- read.table("data.dat")
# missing data
Data[ Data == -9999 ] <- NA
names(Data) <- c("stuID", "schoolID", "gender", "age", "grade",
                 "body1", "body2", "body3", "body4", "body5",
                 "phys1", "phys2", "phys3", "phys4",
                 "phys5", "phys6", "phys7", "phys8",
                 "depress1", "depress2", "depress3",
                 "depress4", "depress5", "depress6",
                 "gotBu1", "gotBu2", "gotBu3", "gotBu4",
                 "gotBu5", "gotBu6", "gotBu7", "gotBu8", "gotBu9",
                 "buOth1", "buOth2", "buOth3", "buOth4",
                 "buOth5", "buOth6", "buOth7", "buOth8", "buOth9",
                 "alcohol1", "alcohol2", "alcohol3",
                 "alcohol4", "alcohol5")
# model 00 + 01
model <- '
    depress =~ a1*depress1 + a1*depress2
    alcohol =~ b1*alcohol1 + b1*alcohol2
'
fit <- sem(model, data = Data, estimator = "WLSMV", warn = FALSE,
           missing = "pairwise", ordered = names(Data), std.lv = TRUE)
fit0 <- update(fit, orthogonal = TRUE)
lavTestLRT(fit, fit0, A.method = "delta")

# model 02 + 03
model <- '
    depress =~ depress1 + depress2 + depress3
    alcohol =~ alcohol1 + alcohol2 + alcohol3
'
fit <- sem(model, data = Data, estimator = "WLSMV", warn = FALSE,
           missing = "pairwise", ordered = names(Data), std.lv = TRUE)
fit0 <- update(fit, orthogonal = TRUE)
lavTestLRT(fit, fit0, A.method = "delta")

# model 04 + 05
model <- '
    depress =~ depress1 + depress2 + depress3 +
               depress4 + depress5 + depress6
    alcohol =~ alcohol1 + alcohol2 + alcohol3 +
               alcohol4 + alcohol5
'
fit <- sem(model, data = Data, estimator = "WLSMV", warn = FALSE,
           missing = "pairwise", ordered = names(Data), std.lv = TRUE)
fit0 <- update(fit, orthogonal = TRUE)
lavTestLRT(fit, fit0, A.method = "delta")
# 403.76 (Mplus: 440.748)


# model 06-07-08
model <- '
    depress =~ depress1 + depress2 + depress3 +
               depress4 + depress5 + depress6
    alcohol =~ alcohol1 + alcohol2 + alcohol3 +
               alcohol4 + alcohol5
    gotBu =~ gotBu1 + gotBu2 + gotBu3 + gotBu4 +
             gotBu5 + gotBu6 + gotBu7 + gotBu8 +
             gotBu9
'
fit <- sem(model, data = Data, estimator = "WLSMV", warn = FALSE,
           missing = "pairwise", ordered = names(Data), std.lv = TRUE)
fit0 <- update(fit, model = c(model, "alcohol ~~ 0*gotBu"))
lavTestLRT(fit, fit0, A.method = "delta")
# 62.029 (Mplus: 63.328)

fit2 <- update(fit, model = c(model, "depress ~~ c*alcohol + c*gotBu"))
lavTestLRT(fit, fit2, A.method = "delta")


# Myrsini
simdata <- read.table("simdata.dat")
simdataOrdered <- simdata
simdataOrdered[,] <- lapply(simdataOrdered, ordered)

simModelH0 <- '
 ksi1 =~ 1*V1 + V2 + V3 + V4 + V5
 ksi2 =~ 1*V6 + V7 + V8  #if I add 0*V5 create problem of non-convergence in some replications

 ksi1 ~~ ksi2
 ksi1 ~~ ksi1
 ksi2 ~~ ksi2

 V1 | t1 + t2 +t3
 V2 | t1 + t2 +t3
 V3 | t1 + t2 +t3
 V4 | t1 + t2 +t3
 V5 | t1 + t2 +t3
 V6 | t1 + t2 +t3
 V7 | t1 + t2 +t3
 V8 | t1 + t2 +t3
         '


simModelH1 <- '
 ksi1 =~ 1*V1 + V2 + V3 + V4 + V5
 ksi2 =~ NA*V5 + 1*V6 + V7 + V8

 ksi1 ~~ ksi2
 ksi1 ~~ ksi1
 ksi2 ~~ ksi2

 V1 | t1 + t2 +t3
 V2 | t1 + t2 +t3
 V3 | t1 + t2 +t3
 V4 | t1 + t2 +t3
 V5 | t1 + t2 +t3
 V6 | t1 + t2 +t3
 V7 | t1 + t2 +t3
 V8 | t1 + t2 +t3
         '

fitH0 <- sem(model=simModelH0,  data= simdataOrdered, estimator="WLSMV")
fitH1 <- sem(model=simModelH1,  data= simdataOrdered, estimator="WLSMV")
test <- lavTestLRT(fitH0, fitH1)
summary(fitH0)
summary(fitH1)
test
fitMeasures(fitH0, "chisq.scaled")

# Smoking Cancer
Data <- read.table("~/semtest/difftest/SmokingCancer/SmokingCancer.dat",
                   header = TRUE)

model <- ' F =~ 1*BLAD + LUNG + KID + LEUK
           F ~ CIG
           BLAD ~ 0
           LUNG ~ 0
           KID ~ 0
           LEUK ~ 0
         '

fit <- sem(model, data=Data, estimator="MLM", mimic="EQS")
summary(fit, standardized=TRUE)

model0 <- ' F =~ 1*BLAD + LUNG + KID + LEUK
            F ~ CIG
            BLAD ~ 0
            LUNG ~ 0
            KID ~ 0
            LEUK ~ 0
            KID ~~ a*KID
            LEUK ~~ a*LEUK
          '

fit0 <- sem(model0, data=Data, estimator="MLM", mimic="EQS")
summary(fit0, standardized=TRUE)

anova(fit, fit0, SB.classic=TRUE)
lavTestLRT(fit, fit0, method = "satorra.bentler.2010")

# Vika Savalei
data <- read.csv("la05noninvcovs2k15n110data1.csv",header=T)

ana.model <- '
    f1 =~ y1 + y2 + y3 + y4
    f2 =~ y5 + y6 + y7 + y8

    # fix marker items
    y1 ~ c(0,0)*1
    y5 ~ c(0,0)*1

    # free latent means
    f1 ~ start(3.0)*1
    f2 ~ start(3.0)*1
'

fit0 <- cfa(ana.model, data=data, estimator="mlm", group="group", mimic="EQS")

fit1<-cfa(ana.model, data=data, estimator="mlm", group="group", mimic="EQS",
          group.equal = "loadings")

fit2 <- cfa(ana.model, data=data, estimator="mlm", group="group", mimic="EQS",
          group.equal = c("loadings", "intercepts"))

fit3 <- cfa(ana.model, data=data, estimator="mlm", group="group", mimic="EQS",
          group.equal = c("loadings", "intercepts","residuals"))

fit4 <- cfa(ana.model, data=data, estimator="mlm", group="group", mimic="EQS",
          group.equal = c("loadings", "intercepts","residuals","lv.variances"))

fit5 <- cfa(ana.model, data=data, estimator="mlm", group="group", mimic="EQS",
          group.equal = c("loadings", "intercepts","residuals","lv.variances",
                          "lv.covariances","means"))

#
lavTestLRT(fit0, fit1, fit2, fit3, fit4, fit5, method = "Satorra.Bentler.2001")

# these values changed in 0.6-13!
lavTestLRT(fit0, fit1, fit2, fit3, fit4, fit5, method = "Satorra.2000")
