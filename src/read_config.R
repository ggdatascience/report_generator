read_sheet <- function(path, 
                       sheet) {
  
  readxl::read_excel(path = path, sheet = sheet, col_types = "text") %>%
    dplyr::mutate(row = dplyr::row_number() + 1L)
}

read_config <- function(path) {
  
  path %>%
    readxl::excel_sheets() %>%
    rlang::set_names() %>%
    purrr::map(~ read_sheet(path = path, sheet = .x))
}


validate_config <- function(path) {
  
  config_file_issues <- validate_config_file(path)
  
  if(issues_has_errors(config_file_issues)) {
    
    issues_assert_none(config_file_issues)
    
  }
  
  config <- read_config(path)
  
  validate_config_tables(config)
  
}
