lines_to_text <- function(welke) {
  if (welke[1] < welke[2]) {
    welke12 <- paste0(welke[1], ",", welke[2])
  } else {
    welke12 <- as.character(welke[2])
  }
  if (welke[3] < welke[4]) {
    welke34 <- paste0(welke[3], ",", welke[4])
  } else {
    if (welke[3] == welke[4]) {
      welke34 <- as.character(welke[4])
    } else {
      welke34 <- ""
    }
  }
  if (welke[1] <= welke[2] && welke[3] <= welke[4]) {
    return(c(welke12, "c", welke34))
  } else if (welke[1] > welke[2]) {
    return(c(welke12, "a", welke34))
  } else {
    return(c(welke12, "d", welke34))
  }
}
compare_files <- function(infile1, infile2, outfile,
                          remove.lines = 
                            c("This is lavaan",
                              "bootstrap draw",
                              "ended normally after",
                              "R version ",
                              "Copyright ")
                            ) {
  stopifnot(is.character(infile1))
  stopifnot(is.character(infile2))
  stopifnot(is.character(outfile))
  suppressWarnings(lines1 <- gsub(" +$", "", readLines(infile1)))
  if (length(lines1) == 0L) stop("infile1 empty")
  lines1 <- chartr("“”‘’", "\"\"''", lines1)
  if (!is.null(remove.lines)) {
    for (rml in remove.lines) {
      toremove <- grepl(rml, lines1, fixed = TRUE)
      lines1[toremove] <- "... removed line for comparison ..."
    }
  }
  suppressWarnings(lines2 <- gsub(" +$", "", readLines(infile2)))
  if (length(lines2) == 0L) stop("infile2 empty")
  lines2 <- chartr("“”‘’", "\"\"''", lines2)
  if (!is.null(remove.lines)) {
    for (rml in remove.lines) {
      toremove <- grepl(rml, lines2, fixed = TRUE)
      lines2[toremove] <- "... removed line for comparison ..."
    }
  }
  oc <- file(outfile, open = "wt")
  i1 <- 1L
  i2 <- 1L
  aantal <- c(0L, 0L)
  while (i1 <= length(lines1) || i2 <= length(lines2)) {
    window <- 8L
    found <- FALSE
    while (!found) {
      welke <- c(i1, i1-1L, i2, i2 - 1L)
      welke1 <- welke2 <- integer(0)
      if (i1 <= length(lines1)) {
        welke[2] <- min(i1 + window, length(lines1))
        welke1 <- seq.int(welke[1L], welke[2L])
      }
      if (i2 <= length(lines2)) {
        welke[4L] <- min(i2 + window, length(lines2))
        welke2 <- seq.int(welke[3L], welke[4L])
      }
      m <- match(lines1[welke1], lines2[welke2], nomatch = 0L)
      for (j in which(m > 0L)) {
        if ((i1 + j <= length(lines1) && i2 + m[j] <= length(lines2) && lines1[i1 + j] == lines2[i2 + m[j]]) ||
            (i1 + j > length(lines1) && i2 + m[j] > length(lines2))) {
          if (j > 1L || m[j] > 1L) {
            welke[2L] <- i1 + j - 2L
            welke[4L] <- i2 + m[j] - 2L
            txtje <- lines_to_text(welke)
            cat(paste(txtje, collapse=""), "\n", sep = "", file = oc)
            aantal[2L] <- aantal[2L]  + 1L
            if (j > 1L) {
              cat(paste0("< ", lines1[seq.int(i1, i1 + j - 2L)], "\n"), sep = "", file = oc)
              aantal[2L] <- aantal[2L] + j - 1L
            }
            if (txtje[2L] == "c") {
              cat("---\n", file = oc)
              aantal[2L] <- aantal[2L]  + 1L
            }
            if (m[j] > 1L) {
              cat(paste0("> ", lines2[seq.int(i2, i2 + m[j] - 2L)], "\n"), sep = "", file = oc)
              aantal[2L] <- aantal[2L]  + m[j] - 1L
            }
            aantal[1L] <- aantal[1L] + 1L
          }
          jj1 <- j + 1L
          jj2 <- m[j] + 1L
          while (i1 + jj1 <= length(lines1) && i2 + jj2 <= length(lines2) && lines1[i1 + jj1] == lines2[i2 + jj2]) {
            jj1 <- jj1 + 1L
            jj2 <- jj2 + 1L
          }
          i1 <- i1 + jj1
          i2 <- i2 + jj2
          found <- TRUE
          break
        }
      }
      if (!found) {
        if (i1 + window >= length(lines1) && i2 + window >= length(lines2)) {
          txtje <- lines_to_text(welke)
          cat(paste(txtje, collapse=""), "\n", sep = "", file = oc)
          if (length(welke1) > 0L) cat(paste0("< ", lines1[welke1], "\n"), sep = "", file = oc)
          if (txtje[2L] == "c") cat("---\n", file = oc)
          if (length(welke2) > 0L) cat(paste0("> ", lines2[welke2], "\n"), sep = "", file = oc)
          i1 <- length(lines1) + 1L
          i2 <- length(lines2) + 1L
          aantal[1L] <- aantal[1L] + 1L
          aantal[2L] <- aantal[2L]  + length(welke1) + length(welke2) + 2L
          break
        }
        window <- 2L * window
      }
    }
  }
  close(oc)
  return(aantal)
}
if (file.exists("README.md")) setwd("tests")
source("../select_tests.R")
testfiles <- select_tests()
extra <- substr(Sys.info()[["sysname"]], 1, 1) # because results depend on OS
for (test.i in seq_along(testfiles)) {
  testfile <- testfiles[test.i]
  file1 <- paste0(testfile, extra, "out.save")
  file2 <- paste0(testfile, extra, "out")
  filediff <- gsub(".R$", ".diff", testfile)
  cat("Checking", sprintf("%-50s", testfile), ":" )
  if (!file.exists(file2)) {
    cat("no R", extra, "out file!\n", sep = "")
  } else if (!file.exists(file1)) {
    cat("no R", extra, "out.save file!\n", sep = "")
  } else {
    aantal <- compare_files(
      infile1 = file1,
      infile2 = file2,
      outfile = filediff
    )
    if (aantal[1L] > 0L) {
      cat(aantal[1L], "differences!\n")
      if (aantal[2L] < 30L) {
        cat(paste(readLines(filediff, warn = FALSE), collapse = "\n"))
        cat("\n")
      } else {
        cat("+++++ Too many diff lines to show here. See", filediff, "+++++\n")
      }
    } else {
      cat("identical.\n")
      unlink(filediff)
    }
  }
}
