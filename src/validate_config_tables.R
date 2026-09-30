check_required_columns <- function(table, 
                                   table_name, 
                                   required_columns = REQUIRED_COLUMNS) {
  
  if(!table_name %in% names(required_columns)) {
    
    rlang::abort(message = paste(table_name, 
                                 "komt niet voor in de noodzakelijke tabellen:", 
                                 paste(names(required_columns), collapse = ", ")))
    
  }
  
  required_columns_for_table <- required_columns[[table_name]]
  
  missing_column_names <- setdiff(required_columns_for_table, names(table))
  
  if(length(missing_column_names) == 0) {
    return(issues_empty())
  } 
  
  issues_create(
    stage = "validate_config",
    message = sprintf("Verplichte kolom '%s' ontbreekt", missing_column_names),
    table = table_name,
    column = missing_column_names
  )
  
}

check_config_columns <- function(config, 
                                 required_columns = REQUIRED_COLUMNS) {
  
  missing_tables <- setdiff(names(required_columns), names(config))
  
  if(length(missing_tables) > 0) {
    
    rlang::abort(message = paste("Verplichte tabel(len) staan niet in de configuratie:",
                                 paste(missing_tables, collapse = ", ")))
    
  }
  
  purrr::map(names(required_columns), 
             ~ check_required_columns(config[[.x]], .x, required_columns = required_columns)) %>%
    purrr::list_rbind()
  
}

validate_config_tables <- function(config,
                                   checks = list(check_config_columns)) {
  
  run_checks(config, checks)

  
}