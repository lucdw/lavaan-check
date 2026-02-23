test.id <- 'parse_testbadscale'
lavaan.model <- '
  Hopeless~~Hopeless
TB~~TB
PB~~PB
SI~~SI
Hopeless~1
TB~1
PB~1
SI~1
Time~~Time
Hopelesslag~~Time
TBlag~~Time
PBlag~~Time
SIlag~~Time
Hopelesslag~~Hopelesslag
TBlag~~Hopelesslag
PBlag~~Hopelesslag
SIlag~~Hopelesslag
TBlag~~TBlag
PBlag~~TBlag
SIlag~~TBlag
PBlag~~PBlag
SIlag~~PBlag
SIlag~~SIlag
Time~1
Hopelesslag~1
TBlag~1
PBlag~1
SIlag~1
Time~0*Hopeless
Time~0*TB
Time~0*PB
Time~0*SI
Hopelesslag~0*Hopeless
Hopelesslag~0*TB
Hopelesslag~0*PB
Hopelesslag~0*SI
TBlag~0*Hopeless
TBlag~0*TB
TBlag~0*PB
TBlag~0*SI
PBlag~0*Hopeless
PBlag~0*TB
PBlag~0*PB
PBlag~0*SI
SIlag~0*Hopeless
SIlag~0*TB
SIlag~0*PB
SIlag~0*SI
Hopeless~Hopelesslag
TB~TBlag
PB~PBlag
SI~SIlag
TB~PB
PB~Hopeless
SI~PB
'
lavaan.call <- 'lavParseModelString'
lavaan.args <- list(as.data.frame. = TRUE)
reports <- 'parser'
test.comment <- 'imported from ldwParse project'
if (!exists('group.environment') || is.null(group.environment)) {
    source('utilities.R')
    execute_test(test.id, lavaan.model, lavaan.call, lavaan.args, reports, test.comment)
}
