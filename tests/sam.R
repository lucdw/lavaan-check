 library(lavaan)

# pop.model <- '
#     # factor loadings
#
#     Y =~ 1*y1 + 0.8*y2 + 0.6*y3
#     Y ~~ 0.5*Y
#     X =~ 1*x1 + 0.8*x2 + 0.6*x3
#     X ~~ 0.9*X
#
#     # regression part
#     Y ~ 0.25*X
#
#     y1 ~ 1*1; y2 ~ 2*1; y3 ~ 3*1; x1 ~ 4*1; x2 ~ 5*1; x3 ~ 6*1
# '

# set.seed(1234)
dat01 <- read.csv("sam_dat01.csv")

model <- '
    # factor loadings
    Y =~ y1 + y2 + y3
    X =~ x1 + x2 + x3

    # regression part
    Y ~ X
'
fit.sam <- sam(model, data = dat01,
                        #mm.args = list(estimator = "ML", se="robust.sem"),
                        mm.args = list(),
                        struc.args = list(),
                        #sam.method = "global",
                        #se = "robust.sem",
                        verbose = FALSE)
summary(fit.sam)


# pop.model <- '
#     # factor loadings
#
#     Y =~ 1*y1 + 0.8*y2 + 0.6*y3
#     X =~ 1*x1 + 0.8*x2 + 0.6*x3
#
#     # regression part
#     Y ~ 0.25*X
# '

# set.seed(1234)
dat02 <- read.csv("sam_dat02.csv")

model <- '
    # factor loadings
    Y =~ y1 + y2 + y3
    X =~ x1 + x2 + x3

    # regression part
    Y ~ X
'
fit.sam <- sam(model, data = dat02,
                        #mm.args = list(estimator = "ML", se="robust.sem"),
                        mm.args = list(),
                        struc.args = list(),
                        #sam.method = "global",
                        #se = "robust.sem",
                        verbose = FALSE)
summary(fit.sam)

# GROWTH
model.syntax <- '
# intercept and slope with fixed coefficients
  i =~ 1*t1 + 1*t2 + 1*t3 + 1*t4
  s =~ 0*t1 + 1*t2 + 2*t3 + 3*t4

# random effects
  t1 + t2 + t3 + t4 ~ 0*1
  i + s ~ 1
  i ~~ s

# regressions
#  i ~ x1 + x2
#  s ~ x1 + x2

# time-varying covariates
#  t1 ~ c1
#  t2 ~ c2
#  t3 ~ c3
#  t4 ~ c4
'
fit.sam <- sam(model.syntax, data = Demo.growth,
                        mm.list = list(is = c("i", "s")))
summary(fit.sam)


data_principals <- read.csv("data_principals.csv")
data_pup <- read.csv("data_pupils.csv")[,-1]

model.SAM <- '
    Skill =~ skill_1 + skill_2 + skill_3 + skill_4 + skill_5 + skill_6
    skill_1 ~~ skill_2
    Use =~ use_1 + use_2 + use_3 + use_4 + use_5 + use_6

    Skill ~ Use + male + l_dialect + l_dutch
'
fit.croon <- sam(model.SAM, data = data_pup, estimator = "ML",
                          sam.method = "local")
summary(fit.croon)


model.sem2 <- '
    # measurement model
    Use =~ use_1 + use_2 + use_3 + use_4 + use_5 + use_6 + use_7 + use_8 + use_9
    Competency =~ comp_1 + comp_2 + comp_3 + comp_4 + comp_5 + comp_6 + comp_7 + comp_8 +
    comp_9 + comp_10 + comp_11 + comp_12 + comp_13 + comp_14 + comp_15 + comp_16 + comp_17 +
    comp_18 + comp_19 +  comp_20  + comp_21 + comp_22 + comp_23 + comp_24 + comp_25 + comp_26
    Policy =~ pol_1 + pol_2 + pol_3 + pol_4 + pol_5 + pol_6 + pol_7 + pol_8 + pol_9 + pol_10
    Professional =~ prof_1 + prof_2 + prof_3 + prof_4

    # structural model
    Use ~ Competency + Policy + Professional
'

fit.croon2 <- sam(model.sem2, data = data_principals, mm.args = list())
summary(fit.croon2)

HS.model <- ' visual  =~ x1 + x2 + x3
              textual =~ x4 + x5 + x6
              speed   =~ x7 + x8 + x9 '

#fit.twostep <- lavaan:::twostep(HS.model, data = HolzingerSwineford1939)
#summary(fit.twostep)

fit.sam <- sam(HS.model, data = HolzingerSwineford1939)
summary(fit.sam)

sample.nobs <- N <- 200L

# pop.model <- '
#     # factor loadings
#     Y =~ 1*y1 + 1.2*y2 + 0.8*y3
#     Y ~~ 0.5*Y
#     y1 ~~ 1.2*y1; y2 ~~ 1.0*y2; y3 ~~ 1.4*y3
#
#     M =~ 1*m1 + 0.5*m2 + 0.5*m3
#     M ~~ 1.2*M
#     m1 ~~ 1.0*m1; m2 ~~ 1.2*m2; m3 ~~ 1.5*m3
#
#     X =~ 1*x1 + 0.7*x2 + 0.6*x3
#     X ~~ 0.8*X
#     x1 ~~ 1.3*x1; x2 ~~ 1.5*x2; x3 ~~ 1.2*x3
#
#     M ~~ 0.2*X
#
#     # regression part
#     Y ~ 0.25*X + 0.40*M + 0.7*V + 0.9*W
#     M ~ -0.30*X + 1.1*V
#
#     V ~~ 2.3*V
#     W ~~ 1.4*W
#     V ~~ 0.9*W
# '

# set.seed(1234)
dat03 <- read.csv("sam_dat03.csv")

model <- '
    # factor loadings
    Y =~ y1 + y2 + y3
    M =~ m1 + m2 + m3
    X =~ x1 + x2 + x3

    # regression part
    Y ~ X + M + V + W
    M ~ X + V
'

# global
fit.gsam <- sam(model, data = dat03,
                    mm.args = list(estimator = "ML"),
                    sam.method = "global",
                    struc.args = list(fixed.x = FALSE),
                    #meanstructure = TRUE,
                    #output = "list",
                    verbose = FALSE)
summary(fit.gsam)

# local
fit.lsam <- sam(model, data = dat03,
                    mm.args = list(estimator = "ML"),
                    sam.method = "local",
                    struc.args = list(fixed.x = FALSE),
                    #meanstructure = TRUE,
                    #output = "list",
                    verbose = FALSE)
summary(fit.lsam)

# test of Fuller (1987) way to avoid a non-positive definite VETA
fit.lsam10 <- sam(model, data = dat03[1:10,])
summary(fit.lsam10)

# block 1: generating the data
# pop.model <- '
#     # factor loadings
#     Y  =~ 1*y1 + 1.2*y2  + 0.8*y3  + 0.5*y4
#     M  =~ 1*m1 + 0.5*m2  + 0.5*m3  + 0.7*m4
#     X1 =~ 1*x1 + 0.7*x2  + 0.6*x3  + 1.1*x4
#     X2 =~ 1*x5 + 0.7*x6  + 0.6*x7  + 0.9*x8
#     X3 =~ 1*x9 + 0.7*x10 + 0.6*x11 + 1.1*x12
#
#     # covariances among exogenous X1-X3
#     X1 ~~ 0.4*X2; X1 ~~ -0.2*X3; X2 ~~ 0.4*X3
#
#     # regression part
#     Y ~  0.25*X3 + 0.4*M + (-0.1)*Age
#     M ~ -0.30*X1 + 1.1*X2
# '
# set.seed(1234)
# Data <- simulateData(pop.model, sample.nobs = 200L, empirical = TRUE)
# tmp <- Data$Age
# # add missing data
# Data <- as.data.frame(lapply(Data, function(x) {
#                             x[ sample(1:length(x), 20) ] <- NA
#                             x }))
# # no missings in Age
# Data$Age <- tmp
dat04 <- read.csv("sam_dat04.csv")



# block 2: fitting traditional SEM
model <- '
    # measurement part
    Y  =~ y1 + y2  + y3  + y4
    M  =~ m1 + m2  + m3  + m4
    X1 =~ x1 + x2  + x3  + x4
    X2 =~ x5 + x6  + x7  + x8
    X3 =~ x9 + x10 + x11 + x12

    # structural part
    Y ~ X3 + M + Age
    M ~ X1 + X2
'
fit.sam <- sam(model, data = dat04, estimator = "ML", missing = "fiml")
summary(fit.sam)

HS.model <- ' visual  =~ x1 + x2 + x3
              textual =~ x4 + x5 + x6
              speed   =~ x7 + x8 + x9 '

fit <- cfa(HS.model, data=HolzingerSwineford1939, group = "school")

#fit.twostep <- lavaan:::twostep(HS.model, data=HolzingerSwineford1939,
#                                group = "school")
#summary(fit.twostep)


fit.sam <- sam(HS.model, data=HolzingerSwineford1939,
                                group = "school")
summary(fit.sam)

fit.sam <- sam(HS.model, data=HolzingerSwineford1939,
                        mm.list = list( a=c("visual", "textual"),
                                        b=c("speed") ),
                        group = "school")
summary(fit.sam)
fit <- cfa(HS.model, data=HolzingerSwineford1939, group = "school",
           group.equal = c("loadings", "intercepts"))

#fit.twostep <- lavaan:::twostep(HS.model, data=HolzingerSwineford1939,
#                                group = "school",
#                                group.equal = c("loadings", "intercepts"))
#summary(fit.twostep)


fit.sam <- sam(HS.model, data=HolzingerSwineford1939,
                        group = "school",
                        group.equal = c("loadings", "intercepts"))
summary(fit.sam)


model <- '
    level: 1
        fw1 =~ y1 + y2 + y3
        fw2 =~ y4 + y5 + y6

        fw2 ~ fw1

    level: 2
        fb1 =~ y1 + y2 + y3
        fb2 =~ y4 + y5 + y6

        fb2 ~ fb1
'
mm.list = list( f = list(c("fw1", "fw2"),
                         c("fb1", "fb2")) )

fit.sam <- sam(model, data = Demo.twolevel,
                        cluster = "cluster",
                        #sam.method = "global",
                        local.options = list(local.twolevel.method = "h1"),
                        mm.list = mm.list)
summary(fit.sam)

# pop.model <- '
#     FY =~ y1 + y2 + y3
#     FX1 =~ x1 + x2 + x3
#     FX2 =~ x4 + x5 + x6
#     FX3 =~ x7 + x8 + x9
#     FX4 =~ x10 + x11 + x12
#
#     # zero theta elements
#     x6 ~~ 0*x6
#     x12 ~~ 0*x12
#
#     # covariances
#     FX1 ~~ 0.2*FX2 + 0.3*FX3 + (-0.4)*FX4 + 0.2*Z1 + 0.3*Z2
#     FX2 ~~ 0.3*FX3 + (-0.4)*FX4 + 0.2*Z1 + 0.3*Z2
#     FX3 ~~ (-0.4)*FX4 + 0.2*Z1 + 0.3*Z2
#     FX4 ~~ 0.2*Z1 + 0.3*Z2
#     Z1  ~~ 0.3*Z2
#
#     FY ~ 1*FX1 + 1.4*FX2 + (-0.5)*FX3 + 2*FX4 + 0.3*Z1 + 0.7*Z2
#     Z1 ~~ 10*Z1; Z1 ~ 100*1
#     Z2 ~~ 20*Z2; Z2 ~  50*1
# '

dat05 <- read.csv("sam_dat05.csv")

model <- '
    FY =~ y1 + y2 + y3
    FX1 =~ x1 + x2 + x3
    FX2 =~ x4 + x5 + x6
    FX3 =~ x7 + x8 + x9
    FX4 =~ x10 + x11 + x12

    FY ~ FX1 + FX2 + FX3 + FX4 + Z1 + Z2

    FX1 + FX2 + FX3 + FX4 ~~ Z1 + Z2
    Z1 ~~ Z2
'
# using SAM
fit.sam <- sam(model, data = dat05, fixed.x = FALSE, meanstructure = TRUE,
               #output = "list",
               mm.list = list(block = c("FY", "FX1", "FX2", "FX3", "FX4")))
summary(fit.sam)

## The industrialization and Political Democracy Example
## Bollen (1989), page 332
model <- '
  # latent variable definitions
     ind60 =~ x1 + x2 + x3
     dem60 =~ y1 + d2*y2 + d3*y3 + d4*y4
     dem65 =~ y5 + d2*y6 + d3*y7 + d4*y8

  # regressions
    dem60 ~ a*ind60
    dem65 ~ c*ind60 + b*dem60

  # residual correlations
    y1 ~~ y5
    y2 ~~ y4 + y6
    y3 ~~ y7
    y4 ~~ y8
    y6 ~~ y8

    indirect := a*b
'
#fit.twostep <- lavaan:::twostep(model, data = PoliticalDemocracy,
#                  mm.list = list(ind = "ind60", dem = c("dem60", "dem65")))
#summary(fit.twostep)

fit.sam <- sam(model, data = PoliticalDemocracy,
                  #sam.method = "global",
                  mm.list = list(ind = "ind60", dem = c("dem60", "dem65")))
summary(fit.sam)

PD10 <- PoliticalDemocracy[1:10,]

# this will fail (N<11)
#fit <- sem(model, data = PD10)

#fit.twostep <- lavaan:::twostep(model, data = PD10,
#                  mm.list = list(ind = "ind60", dem = c("dem60", "dem65")))
#summary(fit.twostep)

fit.sam <- sam(model, data = PD10,
                  #sam.method = "global",
                  mm.list = list(ind = "ind60", dem = c("dem60", "dem65")))
summary(fit.sam)


# no structural part
model <- '
    visual  =~ x1 + x2 + x3
    textual =~ x4 + x5 + x6
    speed   =~ x7 + x8 + x9
'

fit.sam <- sam(model, data = HolzingerSwineford1939, std.lv = TRUE)
summary(fit.sam)





