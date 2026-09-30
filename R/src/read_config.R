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



