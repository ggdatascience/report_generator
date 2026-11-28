read_sav_data <- function(path, user_na = TRUE, variables = NULL) {

  if (is.null(variables)) {
    haven::read_sav(path, user_na = user_na)
  } else {
    haven::read_sav(path, user_na = user_na, col_select = dplyr::all_of(variables))
  }

}

read_sav_columns <- function(path) {
  names(haven::read_sav(path, n_max = 0))
}

read_xlsx_sheets <- function(path, sheetnames) {

  sheetnames |>
    purrr::map(~ readxl::read_xlsx(path, sheet = .x)) |>
    setNames(sheetnames)
  
}