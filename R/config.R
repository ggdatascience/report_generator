validate_config <- function(config, required_tables = REQUIRED_TABLES) {

  validate_all_present(required_tables$rapportages, names(config$rapportages))
  validate_all_present(required_tables$data, names(config$data))
  validate_all_present(required_tables$gebiedsniveaus, names(config$gebiedsniveaus))
  validate_all_present(required_tables$labels, names(config$labels))
  validate_all_present(required_tables$weergave, names(config$weergave))
  
  config
  
}

load_config <- function(path, required_tables = REQUIRED_TABLES) {

  check_file_exists(path)

  sheetnames <- readxl::excel_sheets(path)
  
  validate_all_present(names(required_tables), sheetnames, "Configuratietabellen")

  config <- read_xlsx_sheets(path, sheetnames)

  validate_config(config, required_tables = required_tables)

}

get_file_paths <- function(config) {

  config[["data"]][["bestandsnaam_data"]]
  
}

get_file_extension <- function(filename) {

  stringr::str_extract(filename, "(?<=\\.)[^.]+$")
  
}

return_slide_configs <- function(config, required_tables = REQUIRED_TABLES) {
  
config[!names(config) %in% names(required_tables)]

}

validate_slide_config <- function(slide_config, required_columns = REQUIRED_TABLES$slides) {
  
  validate_all_present()

}