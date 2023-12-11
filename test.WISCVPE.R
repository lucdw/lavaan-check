#WISCVPE_LAV_MLSC-V: Longitudinal Multivariate WISC Data with Dynamic Models
#(C) 2012_01 by Jack McArdle, Longitudinal Research Institute
test.id <- "WISCVPE"
lavaan.model <- '
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
lavaan.call <-  "sem" 
lavaan.args <- list(
  data = "wisc.rds"
)
reports <- c("all", "data", "con")
test.comment <- '6a. example JMcA'
if (!exists("group.environment") || is.null(group.environment)) {
  source("utilities.R")
  execute_test(test.id, lavaan.model, lavaan.call, lavaan.args, reports, test.comment)
}