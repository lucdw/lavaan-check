select_tests <- function() {
  groupdefs <- c(
    All = "\\.[rR]$",
    Vika = "^VIKA.*\\.[rR]$",
    Testfitov = "^testfitov.*\\.[rR]$",
    Testfitlv = "^testfitlv.*\\.[rR]$",
    Social = "^social_.*\\.[Rr]$",
    Parser = "^parse.*\\.[Rr]$"
  )
  groups <- lapply(groupdefs, function(re) list.files(".", pattern = re))
  groups$Overige <- setdiff(groups$All, groups$Vika)
  groups$Overige <- setdiff(groups$Overige, groups$Testfitov)
  groups$Overige <- setdiff(groups$Overige, groups$Testfitlv)
  groups$Overige <- setdiff(groups$Overige, groups$Social)
  groups$Overige <- setdiff(groups$Overige, groups$Parser)
  testfiles <- groups$All
  if (interactive()) {
    select_i <- menu(names(groups), FALSE, "select group")
    if (select_i > 1L) {
      select_ii <- menu(c("All", groups[[select_i]]), FALSE, "select test")
      if (select_ii == 1L) {
        testfiles <- groups[[select_i]]
      } else {
        testfiles <- groups[[select_i]][select_ii - 1L]
      }
    }
  }
  testfiles
}