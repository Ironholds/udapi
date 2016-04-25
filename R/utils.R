#'@importFrom httr user_agent stop_for_status GET content
ud_query <- function(params, term = TRUE, ...){
  url <- paste0("http://api.urbandictionary.com/v0/", params)

  result <- httr::GET(url, httr::user_agent("udapi - https://github.com/Ironholds/udapi"))
  httr::stop_for_status(result)
  output <- httr::content(result)
  if("result_type" %in% names(output) && output$result_type == "no_results"){
    stop("No results found")
  }
  if(term){
    return(output$list)
  }
  return(output)
}

clean_results <- function(results){
  output_names <- names(results[[1]])
  output <-  data.frame(matrix(unlist(results), nrow = length(results), byrow = TRUE),
                        stringsAsFactors = FALSE)
  names(output) <- output_names
  output$thumbs_up <- as.numeric(output$thumbs_up)
  output$defid <- as.numeric(output$defid)
  output$thumbs_down <- as.numeric(output$thumbs_down)
  return(output)
}