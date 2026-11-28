validate_all_present <- function(required, available, label = "elementen") {

  missing_elements <- setdiff(required, available)

  if (length(missing_elements) > 0) {

    rlang::abort(
      message = paste("De volgende", label, "ontbreken:", paste(missing_elements, collapse = ", "))
    )
    
  }

  invisible(TRUE)
  
}

find_missing_elements <- function(required, available) {

  missing_elements <- setdiff(required, available)

  if (length(missing_elements) > 0) {

    return(missing_elements)
    
  }

  invisible(NULL)
  
}

