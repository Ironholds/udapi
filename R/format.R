#' @export
print.udapi <- function(x, ...) {
  cat(format(x), sep = "\n\n")
  invisible(x)
}

#' @export
format.udapi <- function(x, ...) {
  thumbs_and_definition <-
    md_itemize(paste0("(+", x$thumbs_up, "/-", x$thumbs_down, ") ", x$definition))
  examples <-
    md_quote(x$example, "    > ")
  merge_def_and_examples(thumbs_and_definition, examples)
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

merge_def_and_examples <- function(definition, examples) {
  paste0(definition, ifelse(examples == "", "", "\n"), examples)
}

parskip <- function(x) {
  gsub("\n", "\n\n", x, fixed = TRUE)
}

indent <- function(x, spaces) {
  indented <- strwrap(x, indent = spaces, exdent = spaces, simplify = FALSE)
  vcapply(indented, paste, collapse = "\n")
}