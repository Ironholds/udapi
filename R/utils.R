#'@importFrom httr user_agent stop_for_status GET content
ud_query <- function(params, ...){
  url <- paste0("http://api.urbandictionary.com/v0/", params)

  result <- httr::GET(url, httr::user_agent("udapi - https://github.com/Ironholds/udapi"))
  httr::stop_for_status(result)
  output <- httr::content(result)
  if("result_type" %in% names(output) && output$result_type == "no_results"){
    stop("No results found")
  }
  return(output)
}

clean_results <- function(full_results){
  output <- full_results_to_data_frame(full_results)
  clean_output <- clean_results_data_frame(output)
  return(clean_output)
}

full_results_to_data_frame <- function(full_results) {
  results <- full_results$list
  output_names <- names(results[[1]])
  output <-  data.frame(matrix(unlist(results), nrow = length(results), byrow = TRUE),
                        stringsAsFactors = FALSE)
  names(output) <- output_names
  return(output)
}

clean_results_data_frame <- function(output) {
  numerics <- names(output) %in% c("thumbs_up", "defid", "thumbs_down")
  output[numerics] <- lapply(output[numerics], as.numeric)
  output[!numerics] <- lapply(output[!numerics], gsub, pattern = "\r", replacement = "", fixed = TRUE)
  output[!numerics] <- lapply(output[!numerics], gsub, pattern = "\n+", replacement = "\n")
  return(output)
}

clean_tags <- function(term, result) {
  if(!length(result$tags)){
    stop("There are no tags associated with this term.")
  }
  return(data.frame(term = term, tags = unique(unlist(result$tags)), stringsAsFactors = FALSE))
}