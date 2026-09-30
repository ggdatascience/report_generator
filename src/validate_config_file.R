check_file_exists <- function(path) {
  
  if (file.exists(path)) {
    return(issues_empty())
  }
  
  issues_create(
    stage   = "validate_config",
    message = sprintf("Configuratiebestand '%s' bestaat niet.", path)
  )
}

check_required_sheets <- function(path, 
                                  required_sheets = REQUIRED_SHEETS) {
  
  missing_sheets <- setdiff(required_sheets, readxl::excel_sheets(path))
  
  if(length(missing_sheets) == 0) {
    return(issues_empty())
  } 
  
  issues_create(
    stage   = "validate_config",
    message = sprintf("Verplicht tabblad '%s' ontbreekt in het Excelbestand.", missing_sheets),
    table   = missing_sheets
  )
  
}

validate_config_file <- function(path,
                                 checks = list(check_file_exists,
                                               check_required_sheets)) {
  run_checks(path, checks)
  
}

# validate_config_file("config.xlsx")
# validate_config_file("config - error.xlsx")
# validate_config_file("bestandsnaam bestaat niet")

