#'@title Retrieve Urban Dictionary definitions for a term
#'@description \code{get_term} gets definitions for a specific term from
#'Urban Dictionary, along with associated metadata such as the submitter,
#'up- and down-votes, and a permalink.
#'
#'@param term the term to search for.
#'
#'@param ... further arguments to pass to httr's GET function.
#'
#'@examples
#'# Simple example - retrieve the entry for "friendly fade"
#'fade_definitions <- get_term("friendly fade")
#'
#'@seealso \code{\link{random_term}} for retrieving a set of random definitions
#'for random terms, and \code{\link{get_tags}} for retrieving tags associated
#'with a specific term.
#'
#'@importFrom curl curl_escape
#'@export
get_term <- function(term, ...){
  url <- paste0("define?term=", curl::curl_escape(term))
  return(clean_results(ud_query(params = url, ...)))
}

#'@title Retrieve random Urban Dictionary definitions
#'@description \code{random_term} retrieves a random set of 10
#'Urban Dictionary definitions, along with associated metadata.
#'
#'@param ... arguments to pass to httr's GET function.
#'
#'@examples
#'# Grab 10 random entries
#'entries <- random_term()
#'
#'@seealso \code{\link{get_term}} for retrieving a set of definitions for
#'a specific term.
#'@export
random_term <- function(...){
  return(clean_results(ud_query(params = "random", ...)))
}

#'@title Get tags associated with a Term
#'@description \code{get_tags} retrieves the tags associated
#'with a particular term on Urban Dictionary.
#'
#'@param term the term to search for.
#'
#'@param ... further arguments to pass to httr's GET function.
#'
#'@return a data.frame containing the term and the top 10 tags associated with it.
#'
#'@examples
#'# Simple example - retrieve the entry for "dab"
#'fade_definitions <- get_tags("dab")
#'
#'@seealso \code{\link{get_term}} for retrieving a set of \emph{definitions} for
#'a specific term.
#'
#'@export
get_tags <- function(term, ...){
  url <- paste0("define?term=", curl::curl_escape(term))
  result <- ud_query(params = url, term = FALSE, ...)
  if(!length(result$tags)){
    stop("There are no tags associated with this term.")
  }
  return(data.frame(term = term, tags = unique(unlist(result$tags)), stringsAsFactors = FALSE))
}