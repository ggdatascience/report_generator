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
      issues_format(issues),
      i = "Alle problemen: rlang::last_error()$issues"
    ),
    class  = "issues_error",
    issues = issues
  )
}

issues_has_errors <- function(issues) {
  any(issues$severity == "error", na.rm = TRUE)
}

issues_format <- function(issues, max_n = 10) {
  
  if (nrow(issues) == 0) return(character(0))
  
  # errors eerst, dan warnings; binnen severity blijft de oorspronkelijke volgorde
  issues <- issues[order(match(issues$severity, c("error", "warning"))), ]
  
  shown <- utils::head(issues, max_n)
  
  lines <- vapply(seq_len(nrow(shown)), function(i) {
    issue_location(shown[i, ])
    loc <- issue_location(shown[i, ])
    if (nzchar(loc)) paste0("[", loc, "] ", shown$message[i]) else shown$message[i]
  }, character(1))
  
  names(lines) <- ifelse(shown$severity == "error", "x", "!")
  
  n_more <- nrow(issues) - nrow(shown)
  if (n_more > 0) {
    lines <- c(lines, c(" " = paste0("\u2026 en ", n_more, " meer")))
  }
  
  lines
}

issue_location <- function(issue) {
  
  parts <- c(
    if (!is.na(issue$table))        issue$table,
    if (!is.na(issue$row))          paste("rij", issue$row),
    if (!is.na(issue$column))       paste("kolom", issue$column),
    if (!is.na(issue$report_id))    paste("rapport", issue$report_id),
    if (!is.na(issue$slide_number)) paste("slide", issue$slide_number)
  )
  
  paste(parts, collapse = ", ")
}

run_checks <- function(input, checks) {
  
    issues <- issues_empty()
    
    for (check in checks) {
      issues <- dplyr::bind_rows(issues, check(input))
      if (issues_has_errors(issues)) break
    }
    
    issues
}
  