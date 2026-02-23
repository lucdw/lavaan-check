test.id <- 'parse_YR_OKT18_1'
lavaan.model <- "

    O1 ~~ 0 * O2                          #The manifest variables are uncorrelated.
    O1 + O2 ~ rep('int', 4 ) * 1           #The manifest variables are fed the same intercept (for all groups).

    E1 =~ rep('e', 4 ) * O1  #Declare the contributions of E to Subject1 (for all groups).
    E2 =~ rep('e', 4 ) * O2  #Declare the contributions of E to Subject2 (for all groups).

    E1 ~~ 0 * E2                          #The Es are uncorrelated
    E1 ~~ 1 * E1                          #The Es have a variance of 1
    E2 ~~ 1 * E2
    e2 := e * e                           #Declare e^2 for easy point and variance estimation.
   
    A1 =~ rep('a', 4 ) * O1   #Declare the contributions of A to Subject1 (for all groups).
    A2 =~ rep('a', 4 ) * O2   #Declare the contributions of A to Subject2 (for all groups).
    A1 ~~ c( 0.25, 0.375, 0.5, 1 ) * A2           #Declare the genetic relatedness between Subject1 and Subject2. This coefficient differs for all groups.

    A1 ~~ 1 * A1                          #The As have a variance of 1
    A2 ~~ 1 * A2
    a2 := a * a                           #Declare a^2 for easy point and variance estimation.
   
    C1 =~ rep('c', 4 ) * O1   #Declare the contributions of C to Subject1 (for all groups).
    C2 =~ rep('c', 4 ) * O2   #Declare the contributions of C to Subject2 (for all groups).

    C1 ~~ 1 * C2                          #The Cs are perfectly correlated. !!Note this restricts the sample to immediate families!!
    C1 ~~ 1 * C1                          #The Cs have a variance of 1
    C2 ~~ 1 * C2
    c2 := c * c                           #Declare c^2 for easy point and variance estimation.
  
"
lavaan.call <- 'lavParseModelString'
lavaan.args <- list(as.data.frame. = TRUE)
reports <- 'parser'
test.comment <- 'imported from ldwParse project'
if (!exists('group.environment') || is.null(group.environment)) {
    source('utilities.R')
    execute_test(test.id, lavaan.model, lavaan.call, lavaan.args, reports, test.comment)
}
