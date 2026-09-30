check_unique_key <- function(config, table, column) {
  
  missing_keys <- which(config[[table]][[column]] %in% c(NA, ""))
  
  if(length(missing_keys) > 0) {
    
    excel_rows <- config[[table]]$row[missing_keys]
    
    issues_create(
      stage = "validate_config",
      message = sprintf("Verplichte %s in rij '%s' ontbreekt", column, excel_rows),
      table = table,
      column = column,
      row = excel_rows
    )
    
  } else
  
  issues_empty()
  
}

config_test <- list(
  data = tibble(
    data_id   = c("a", "b", "c"),
    data_path = c("x.sav", "y.sav", "z.sav"),
    time_var  = c("jaar", "jaar", "jaar"),
    row       = 2:4
  )
)

check_unique_key(config_test, table = "data", column = "data_id") %>% str()

