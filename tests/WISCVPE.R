# Test_id : WISCVPE
# =================
# 6a. example JMcA

library(lavaan)

set.seed(1234)

Model <- c(
'
# No labels are required!
#setup invariant measurement model first
# Factor Loadings Invariant
V6 =~ L1*IN_06 + L2*CO_06 + L3*SI_06 + L4*VO_06;
V7 =~ L1*IN_07 + L2*CO_07 + L3*SI_07 + L4*VO_07;
V9 =~ L1*IN_09 + L2*CO_09 + L3*SI_09 + L4*VO_09;
V11 =~ L1*IN_11 + L2*CO_11 + L3*SI_11 + L4*VO_11;

#Intercepts invariant
IN_06~I_IN*1; CO_06~I_CO*1;SI_06~I_SI*1; VO_06~I_VO*1; 
IN_07~I_IN*1; CO_07~I_CO*1;SI_07~I_SI*1; VO_07~I_VO*1; 
IN_09~I_IN*1; CO_09~I_CO*1;SI_09~I_SI*1; VO_09~I_VO*1; 
IN_11~I_IN*1; CO_11~I_CO*1;SI_11~I_SI*1; VO_11~I_VO*1; 

#uniqueness invariant
IN_06~~U_IN2*IN_06; CO_06~~U_CO2*CO_06; SI_06~~U_SI2*SI_06; VO_06~~U_VO2*VO_06; 
IN_07~~U_IN2*IN_07; CO_07~~U_CO2*CO_07; SI_07~~U_SI2*SI_07; VO_07~~U_VO2*VO_07;
IN_09~~U_IN2*IN_09; CO_09~~U_CO2*CO_09; SI_09~~U_SI2*SI_09; VO_09~~U_VO2*VO_09;
IN_11~~U_IN2*IN_11; CO_11~~U_CO2*CO_11; SI_11~~U_SI2*SI_11; VO_11~~U_VO2*VO_11;

# Part 1 -- Verbal scores first
# set up "preliminary" latent variables
lv0=~1*V6; lv1=~1*V7; lv2=~0*V6; lv3=~1*V9; lv4=~0*V6; lv5=~1*V11;

# set up auto-regressive relations fixed at 1
lv1~1*lv0; lv2~1*lv1; lv3~1*lv2; lv4~1*lv3; lv5~1*lv4;

# set up latent change scores
dv1=~1*lv1; dv2=~1*lv2; dv3=~1*lv3; dv4=~1*lv4; dv5=~1*lv5;

# set up latent level and slope 
G0=~1*lv0; G1=~1*dv1 + 1*dv2 + 1*dv3 + 1*dv4 + 1*dv5;

# set up auto-proportional beta effects
dv1~Bg*lv0; dv2~Bg*lv1; dv3~Bg*lv2; dv4~Bg*lv3; dv5~Bg*lv4;

# set latent statistics
G0~~1*G0; # so variance of factor is fixed at 1; 
G1~~V1*G1; G0~~C01*G1;
G0~0*1; # so mean of factor is fixed at zero
G1~M1*1;
# Uniquenesses of factor all equal
V6~~U_v2*V6; V7~~U_v2*V7; V9~~U_v2*V9; V11~~U_v2*V11;
'
)
object <- try(sem(
data = readRDS("wisc.rds"), model = Model, parser = 'new'
), outFile = stdout())
if (!inherits(object, 'try-error')) {withAutoprint({
AIC(object)
anova(object)
BIC(object)
coef(object)
fitted(object)
fitted.values(object)
as.numeric(lavInspect(object,  what = 'converged'))
lavInspect(object,  what = 'cov.lv')
lavInspect(object,  what = 'cov.ov')
lavInspect(object,  what = 'coverage')
lavInspect(object,  what = 'dx.free')
lavInspect(object,  what = 'est')
fitMeasures(object)
fitMeasures(object, 'chisq')
fitMeasures(object, c('chisq', 'df', 'pvalue', 'rmsea', 'cfi'))
lavInspect(object,  what = 'hessian')
lavCor(object)
lavTables(object, dimension = 0L)
lavTables(object, dimension = 1L)
lavTables(object, dimension = 2L)
lavTestLRT(object)
lavInspect(object,  what = 'mean.lv')
lavInspect(object,  what = 'mean.ov')
parameterEstimates(object)
parameterTable(object)
lavInspect(object,  what = 'partable')
lavInspect(object,  what = 'patterns')
lavInspect(object,  what = 'rsquare')
lavInspect(object,  what = 'sampstat')
lavInspect(object,  what = 'se')
standardizedSolution(object)
lavInspect(object,  what = 'start')
lavInspect(object,  what = 'std.all')
lavInspect(object,  what = 'std.lv')
lavInspect(object,  what = 'std.nox')
lavInspect(object,  what = 'th')
lavInspect(object,  what = 'theta')
lavInspect(object,  what = 'theta.cor')
varTable(object)
lavInspect(object,  what = 'wls.est')
lavInspect(object,  what = 'wls.obs')
lavInspect(object,  what = 'wls.v')
lavInspect(object)
lavNames(object, 'all')
logLik(object)
coef(update(object, orthogonal = TRUE))
summary(object)
vcov(object)
attr(lavPredict(object, fsm = TRUE, se = TRUE, acov = TRUE, method = 'Bartlett'), 'acov')
attr(lavPredict(object, fsm = TRUE, se = TRUE, acov = TRUE, method = 'Bartlett'), 'fsm')
attr(lavPredict(object, fsm = TRUE, se = TRUE, acov = TRUE, method = 'Bartlett'), 'se')
lavInspect(object,  what = 'gamma')
head(lavScores(object))
nobs(object)
head(resid(object, 'obs'))
head(predict(object))
attr(lavPredict(object, fsm = TRUE, se = TRUE, acov = TRUE), 'acov')
attr(lavPredict(object, fsm = TRUE, se = TRUE, acov = TRUE), 'fsm')
attr(lavPredict(object, fsm = TRUE, se = TRUE, acov = TRUE), 'se')
resid(object)
residuals(object)[[2]]
})}
