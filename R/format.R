#' @export
format.udapi <- function(x, ...) {
  thumbs_and_definition <-
    md_itemize(paste0("(+", x$thumbs_up, "/-", x$thumbs_down, ") ", x$definition))
  examples <-
    md_quote(x$example, "    > ")
  paste0(thumbs_and_definition, "\n\n", examples)
}

#' @export
print.udapi <- function(x, ...) {
  cat(format(x), sep = "\n")
  invisible(x)
}

md_itemize <- function(x, bullet = "* ") {
  indented <- indent(parskip(x), nchar(bullet))
  substr(indented, 1, nchar(bullet)) <- bullet
  indented
}

md_quote <- function(x, quote = "> ") {
  xl <- strsplit(x, "\n")
  xlq <- lapply(xl, md_itemize, bullet = quote)
  lapply(xlq, paste, collapse = "\n\n")
}

parskip <- function(x) {
  gsub("\n", "\n\n", x, fixed = TRUE)
}

indent <- function(x, spaces) {
  indented <- strwrap(x, indent = spaces, exdent = spaces, simplify = FALSE)
  vcapply(indented, paste, collapse = "\n")
}