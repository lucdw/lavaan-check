# Check gebruik van lav_functies voor berichten ('message'), 
# errors ('stop') en waarschuwingen ('warning').

# Opgelet: volgende lijn indien nodig aanpassen zodat rmap verwijst naar
#          directory waar lavaan R code staat !

rmap <- normalizePath("~/src/R/lavaan/R", "/") # ! machine dependent !
get_parsed <- function(filename) {
  stopifnot(is.character(filename), length(filename) == 1)
  stopifnot(file.exists(filename))
  filelines <- suppressWarnings(readLines(filename))
  temp <- try(getParseData(parse(text = filelines, keep.source = TRUE)))
  if (inherits(temp, "try-error")) {
    stop(gettextf("file %s cannot be parsed", filename))
  }
  attr(temp, "basename") <- basename(filename)
  return(invisible(temp))
}
parents <- function(id, tree) {
  p <- tree$parent[tree$id == id]
  if (length(p) == 0) p <- 0
  if (p <= 0) NULL else c(p, parents(p, tree))
}
files <- list.files(rmap, pattern = ".[rR]$", all.files = TRUE)
nfiles <- length(files)
df <- data.frame(message = integer(nfiles),
                 warning = integer(nfiles),
                 stop = integer(nfiles),
                 msg = integer(nfiles),
                 result = character(nfiles),
                 gettext = rep.int("", nfiles)
)
row.names(df) <- files
nottranslated <- 0L
multigettext <- 0L
for (i in seq_along(files)) {
  if (tolower(files[i]) == "lav_msg.r") next # skip this one
  file_to_handle <- file.path(rmap, files[i])
  psd <- get_parsed(file_to_handle)
  functioncalls <- psd$token == "SYMBOL_FUNCTION_CALL"
  functions <- psd$text[functioncalls]
  df[i, "message"] <- sum(functions == "message")
  df[i, "warning"] <- sum(functions == "warning")
  df[i, "stop"] <- sum(functions == "stop")
  df[i, "msg"] <- sum(functions == "lav_msg_warn") + 
    sum(functions == "lav_msg_stop") + sum(functions == "lav_msg_note")
  if (df[i, "msg"] > 0) {
    ids <- psd$id[psd$text %in% c("lav_msg_note", "lav_msg_warn", "lav_msg_stop")]
    pas <- sapply(ids, function(j) psd$parent[psd$id == j])
    opas <- sapply(pas, function(j) psd$parent[psd$id == j])
    gettextids <- psd$id[grepl("gettext", psd$text)]
    gettextparents <- lapply(gettextids, function(j) parents(j, psd))
    gettextnumbers <- sapply(opas, function(j) {
      sum(sapply(gettextparents, function(k) j %in% k))
    })
    indicator <- ""
    if (any(gettextnumbers == 0L)) {
      indicator <- "none "
      nottranslated <- nottranslated + 1L
    }
    if (any(gettextnumbers > 1L)) {
      indicator <- paste0(indicator, "multi")
      multigettext <- multigettext +1L
    }
    df[i, "gettext"] <- indicator
  }
}
nnul <- (df$message + df$warning + df$stop + df$msg > 0)
todos <- (df$message + df$warning + df$stop > 0 | df$gettext != "")
df$result <- ifelse(todos, ifelse(df$msg > 0, "PARTLY", "TODO"), "DONE")
aantal <- length(files)
nullen <- length(files) - sum(nnul)
gedaan <- sum(df$result == "DONE")
gedaanmsg <- sum(df$msg)
tedoen <- sum(df$result == "TODO")
tedoenmsg <- sum(df$message) + sum(df$warning) + sum(df$stop)
deels <- sum(df$result == "PARTLY")

cat("Todo errors, warnings, messages and internationalization.\n",
    "---------------------------------------------------------\n\n",
    "Samenvatting op ", format(Sys.Date()), ":\n",
    "Er zijn ", aantal, " bestanden, waarvan één (lav_msg.r) het message ",
    "handling bestand\nen ", nullen, " bestanden die niets te zien hebben ",
    "met messages.\nVerder zijn er ", gedaan, " bestanden gedaan, ", deels, 
    " bestanden gedeeltelijk gedaan\nen ", tedoen,
    " bestanden nog helemaal te doen.\n",
    "Er zijn ", tedoenmsg, " statements (message, warning, stop) nog te doen",
    " en\ner zijn er ", gedaanmsg, " gedaan (gebruiken lav_msg_*).\n\n", sep = "")
if (nottranslated > 0) cat(
    "Er zijn ", nottranslated, " bestanden die mogelijks beroep doen op ", 
    "de lav_msg_* functies en\nniet vertaald zullen worden omdat er geen",
    "gebruik wordt gemaakt van [n]gettext[f]. ",
    "Aangeduid met 'none' in kolom gettext.", sep = "")
if (multigettext > 0) cat(
    "Er zijn ", multigettext, 
    " bestanden die soms méér dan één gettext functie per lav_msg_* hebben",
    ",\nwat vervelend kan zijn voor de vertaling.",
    "Aangeduid met 'multi' in kolom gettext", sep = ""
)
cat("De lijst met bestanden waar eventueel verbeteringen dienen aangebracht:\n")
print(knitr::kable(df[which(todos), ], format.args = list(zero.print = " ")))
