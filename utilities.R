library(lavaan)
TheCalls <- as.character(sys.calls())
if (!grepl("run.all.tests", TheCalls[[1]], fixed = TRUE) && !grepl("utilities", TheCalls[[1]], fixed = TRUE) &&
      !grepl(paste0(".", test.id, "."), TheCalls[[1]], fixed = TRUE)) stop("Source file and test.id do not match!")
ownrep <- "own_reports.R"
if (file.exists(ownrep)) source(ownrep) # global own reports
# function to execute test with parameters set in .R files in subdirectories
# group.environment is NULL when function is called from this R-file
# the logging of differences is stored in the group.environment or displayed immediately
execute_test <- function(test.id, lavaan.model, lavaan.call, lavaan.args, reports,
                         comment = "", group.environment = NULL) {
  stopifnot(is.character(test.id), length(test.id) == 1L)
  stopifnot(is.character(lavaan.call), length(lavaan.call) == 1L)
  stopifnot(is.character(lavaan.model))
  stopifnot(is.list(lavaan.args))
  stopifnot(is.list(reports))
  if (!file.exists("utilities.R")) stop(paste("The working directory", getwd(), "is not the right one!"))
  if (!dir.exists("snapshots")) dir.create("snapshots")
  if (!dir.exists("reports")) dir.create("reports")
  if (exists("group.environment") && !is.null(group.environment)) cat("  handling ", sprintf("%-50s", test.id), " ...: ")
  logfile <- file() # anonymous file connection, see R-help for file, examples
  on.exit({if (isOpen(logfile)) close(logfile)})
  cat("\nTest.id :", test.id, "\n", file = logfile)
  cat(strrep("=", 12 + nchar(test.id)), "\n", file = logfile)
  if (comment != "") {
    cat("test comment:\n# ", 
        gsub("\n","\n# ",gsub("^ *\n", "", gsub("\n *$", "", comment))),
        "\n", sep="", file = logfile)
  }
  lavaan.args$model <- lavaan.model
  if (!is.null(lavaan.args$data) && is.character(lavaan.args$data)) lavaan.args$data <- readRDS(lavaan.args$data)
  snapshotfile <- paste0("snapshots/", test.id, ".rds")
  testnow <- tryCatch.W.E(do.call(lavaan.call, lavaan.args))
  noerrors <- TRUE
  totdiff <- 0L
  if (file.exists(snapshotfile)) {
    testold <- readRDS(snapshotfile)
    noerrors <- compare_messages(testold, testnow, logfile)
    if (!noerrors) totdiff <- 1L
  } else {
    saveRDS(testnow, snapshotfile)
  }
  if (noerrors && length(reports) > 0) {
    for (rpt.i in seq_along(reports)) {
      rptname <- names(reports)[rpt.i]
      report <- reports[[rpt.i]]
      value.report <- !is.null(report$rep.tol.abs) || !is.null(report$rep.tol.rel)
      if (value.report) {
        rptsnapshotfile <- paste0("snapshots/", test.id, ".", rptname, ".rds")
        reports[[rpt.i]]$rep.args$object <- testnow$value
        rptval <- do.call(reports[[rpt.i]]$rep.call, reports[[rpt.i]]$rep.args)
        if (!is.numeric(rptval)) stop("error in ", rptname , ": output is not a numeric vector")
        if (is.null(names(rptval))) stop("error in ", rptname , ": output is not a named vector")
        if (length(names(rptval)) != length(unique(names(rptval)))) 
          stop("error in ", rptname , ": names output vector are not unique")
        if (file.exists(rptsnapshotfile)) {
          cat("Comparing reports", rptname, "\n", file = logfile)
          rptvalold <- readRDS(rptsnapshotfile)
          diffs <- compare_values(rptvalold, rptval, report$rep.tol.abs, report$rep.tol.rel, logfile)
          if (diffs == 0L) {
            cat("   all report value differences within tolerance level\n", file = logfile)
          } else {
            totdiff <- diffs + totdiff
          }
        } else {
          saveRDS(rptval, rptsnapshotfile)
        }
      } else {
        rptsnapshotfile <- paste0("snapshots/", test.id, ".", rptname, ".txt")
        rptdifffile <- paste0("reports/", test.id, ".", rptname, ".diff")
        removelines <- reports[[rpt.i]]$rep.ignore
        reports[[rpt.i]]$rep.args$object <- testnow$value
        rptcon <- file() # anonymous file
        sink(rptcon)
        print(do.call(reports[[rpt.i]]$rep.call, reports[[rpt.i]]$rep.args))
        sink()
        rptnow <- readLines(rptcon)
        close(rptcon)
        if (file.exists(rptsnapshotfile)) {
          cat("Comparing reports", rptname, "\n", file = logfile)
          rptnowcon <- textConnection(rptnow)
          diffs <- compare_files(rptsnapshotfile, rptnowcon, rptdifffile, removelines)
          if (diffs == 0L) {
            cat("   reports are identical\n", file = logfile)
            file.remove(rptdifffile)
          } else {
            cat("  ", diffs, " differences in reports, see", rptdifffile, "\n", file = logfile)
          }
          totdiff <- diffs + totdiff  
        } else {
          writeLines(rptnow, rptsnapshotfile)
        }
      }
    }
  }
  if (!exists("group.environment") || is.null(group.environment)) {
    cat(paste(readLines(logfile), collapse="\n"))
  } else {
    i <- get("i", group.environment)
    i <- i + 1L
    assign("i", i, group.environment)
    ich <- formatC(i, width=4, flag="0")
    df1 <- data.frame(
      test = test.id,
      diffs = totdiff
    )
    assign(paste0("res", ich), df1, group.environment)
    assign(paste0("log", ich), paste(readLines(logfile), collapse="\n"), group.environment)
  }
  if (!is.null(group.environment)) cat("done\n")
  invisible()
}
tryCatch.W.E <- function(expr)   # see demo(error.catching)
{
  W <- NULL
  w.handler <- function(w) {
    # warning handler
    W <<- w
    invokeRestart("muffleWarning")
  }
  list(value = withCallingHandlers(tryCatch(
    expr,
    error = function(e)
      e
  ),
  warning = w.handler),
  warning = W)
}
handle_dcf <- function(dcf) {
  for (i in seq_along(dcf)) { # items with ';' are vectors
    if (is.character(dcf[[i]]) && grepl(";", dcf[[i]])) {
      dcfi <- strsplit(dcf[[i]], ";")[[1]]
    } else {
      dcfi <- dcf[[i]]
    }
    if (!anyNA(suppressWarnings(as.numeric(dcfi)))) {
      dcfi <- as.numeric(dcfi)
    } else {
      if (!anyNA(suppressWarnings(as.logical(dcfi)))) dcfi <- as.logical(dcfi) 
    }
    dcf[[i]] <- dcfi
  }
  return(dcf)
}
compare_messages <- function(testold, testnow, logcon) {
  if (!is.null(testold$warning)) {
    if (is.null(testnow$warning)) {
      cat("Warning(s) in old snapshot while not in new:\n", file = logcon)
      cat(testold$warning$message, sep = "\n", file = logcon)
    } else {
      if (!identical(testold$warning$message, testnow$warning$message)) {
        oldtxt <- textConnection(testold$warning$message)
        newtxt <- textConnection(testnow$warning$message)
        cat("Warning differences:\n", file = logcon)
        compare_files(oldtxt, newtxt, logcon)
      }
    }
  } else {
    if (!is.null(testnow$warning)) {
      cat("Warning(s) in new snapshot while not in old:\n", file = logcon)
      cat(testnow$warning$message, sep = "\n", file = logcon)
    }
  }
  if (inherits(testold$value, "error")) {
    if (!inherits(testnow$value, "error")) {
      cat("Error in old snapshot while not in new:\n", file = logcon)
      cat(testold$value$message, sep = "\n", file = logcon)
    } else {
      if (!identical(testold$value$message, testnow$value$message)) {
        oldtxt <- textConnection(testold$value$message)
        newtxt <- textConnection(testnow$value$message)
        cat("Error message differences:\n", file = logcon)
        compare_files(oldtxt, newtxt, logcon)
      }
    }
  } else {
    if (inherits(testnow$value, "error")) {
      cat("Error in new snapshot while not in old:\n", file = logcon)
      cat(testnow$value$message, sep = "\n", file = logcon)
    } else {
      return(TRUE) # no errors occured
    }
  }
  return(FALSE) # at least one of both has errors (and so no 'normal' value)
}
.ldw_lines_to_text <- function(welke) {
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
compare_files <- function(infile1, infile2,
                          outfile = paste0(dirname(infile1), "/", basename(infile1), basename(infile2), ".diff"),
                          remove.lines = NULL) {
  stopifnot(is.character(infile1) || inherits(infile1, "connection"))
  stopifnot(is.character(infile2) || inherits(infile2, "connection"))
  stopifnot(is.character(outfile) || inherits(outfile, "connection"))
  suppressWarnings(lines1 <- readLines(infile1))
  if (length(lines1) == 0L) stop("infile1 empty")
  if (!is.character(infile1) && isOpen(infile1, "r")) close(infile1) 
  if (!is.null(remove.lines)) {
    for (rml in remove.lines) {
      toremove <- grepl(rml, lines1, fixed = TRUE)
      lines1[toremove] <- "... removed line for comparison ..."
    }
  }
  suppressWarnings(lines2 <- readLines(infile2))
  if (length(lines2) == 0L) stop("infile2 empty")
  if (!is.character(infile2) && isOpen(infile2, "r")) close(infile2) 
  if (!is.null(remove.lines)) {
    for (rml in remove.lines) {
      toremove <- grepl(rml, lines2, fixed = TRUE)
      lines2[toremove] <- "... removed line for comparison ..."
    }
  }
  if (is.character(outfile)) { 
    oc <- file(outfile, open = "wt")
  } else {
    oc <- outfile
    if (!isOpen(oc, "w")) open(oc, "wt")
  }
  i1 <- 1L
  i2 <- 1L
  aantal <- 0L
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
            txtje <- .ldw_lines_to_text(welke)
            cat(paste(txtje, collapse=""), "\n", sep = "", file = oc)
            if (j > 1L) cat(paste0("< ", lines1[seq.int(i1, i1 + j - 2L)], "\n"), sep = "", file = oc)
            if (txtje[2L] == "c") cat("---\n", file = oc)
            if (m[j] > 1L) cat(paste0("> ", lines2[seq.int(i2, i2 + m[j] - 2L)], "\n"), sep = "", file = oc)
            aantal <- aantal + 1L
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
          txtje <- .ldw_lines_to_text(welke)
          cat(paste(txtje, collapse=""), "\n", sep = "", file = oc)
          if (length(welke1) > 0L) cat(paste0("< ", lines1[welke1], "\n"), sep = "", file = oc)
          if (txtje[2L] == "c") cat("---\n", file = oc)
          if (length(welke2) > 0L) cat(paste0("> ", lines2[welke2], "\n"), sep = "", file = oc)
          i1 <- length(lines1) + 1L
          i2 <- length(lines2) + 1L
          aantal <- aantal + 1L
          break
        }
        window <- 2L * window
      }
    }
  }
  if (is.character(outfile)) close(oc)
  return(aantal)
}
compare_values <- function(rptvalold, rptval, rep.tol.abs = NULL, rep.tol.rel = NULL, logfile) {
  differences <- 0L
  if (!setequal(names(rptvalold), names(rptval))) {
    cat(" report elements aren't the same : \n",
        " old report : ", paste(names(rptvalold), collapse = ", "), "\n",
        " new report : ", paste(names(rptval), collapse = ", "), "\n",
        file = logfile)
    differences <- 1L
  } else {
    for (i in seq_along(rptvalold)) {
      elem.name <- names(rptvalold)[i]
      elem.diff <- abs(rptvalold[elem.name] - rptval[elem.name])
      if (is.null(rep.tol.abs) || is.na(rep.tol.abs)) {
        max.diff <- rep.tol.rel * abs(rptvalold[elem.name] + rptval[elem.name]) / 2
      } else {
        max.diff <- rep.tol.abs
      }
      if (elem.diff > max.diff) {
        differences <- differences + 1L
        cat(" element", elem.name, "old value:",  rptvalold[elem.name], ", new value:", rptval[elem.name], "\n",
            file = logfile)
      }
    }    
  }
  return(differences)
}
