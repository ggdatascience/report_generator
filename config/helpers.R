issues_empty <- function() {
  
  tibble::tibble(stage = character(0),
                 severity = character(0),
                 message = character(0),
                 table = character(0),
                 row = integer(0),
                 column = character(0),
                 report_id = character(0),
                 slide_number = integer(0))
}

issues_create <- function(stage,
                          message,
                          severity = "error",
                          table = NA_character_,
                          row = NA_integer_,
                          column = NA_character_,
                          report_id = NA_character_,
                          slide_number = NA_integer_) {
  
  new_rows <- tibble::tibble(
    stage        = stage,
    severity     = severity,
    message      = message,
    table        = table,
    row          = as.integer(row),
    column       = column,
    report_id    = as.character(report_id),
    slide_number = as.integer(slide_number)
  )
  
  dplyr::bind_rows(issues_empty(), new_rows)
  
}

issues_assert_none <- function(issues) {
  
  n_errors   <- sum(issues$severity == "error",   na.rm = TRUE)
  n_warnings <- sum(issues$severity == "warning", na.rm = TRUE)
  
  if (n_warnings > 0) {
    rlang::inform(paste0("Let op: ", n_warnings, " waarschuwing(en) gevonden."))
  }
  
  if (n_errors == 0) {
    return(invisible(issues))
  }
  
  rlang::abort(
    message = c(
      paste0(n_errors, " fout(en) gevonden in de configuratie."),
      i = "Bekijk alle problemen met: rlang::last_error()$issues"
    ),
    class  = "issues_error",
    issues = issues
  )
}

issues_has_errors <- function(issues) {
  any(issues$severity == "error", na.rm = TRUE)
}

issues_format <- function(issues) {
  
}

run_checks <- function(input, checks) {
  
    issues <- issues_empty()
    
    for (check in checks) {
      issues <- dplyr::bind_rows(issues, check(input))
      if (issues_has_errors(issues)) break
    }
    
    issues
}
  