get_required_variables <- function(config) {
  dplyr::bind_rows(
    config$data           |> dplyr::select(data_id, variable = tijd_variabele),
    config$slides         |> dplyr::select(data_id, variable = variabele),
    config$slides         |> dplyr::select(data_id, variable = uitsplitsing_variabele),
    config$slides         |> dplyr::select(data_id, variable = weegfactor_indicator),
    config$gebiedsniveaus |> dplyr::select(data_id, variable = gebied_variabele),
    config$gebiedsniveaus |> dplyr::select(data_id, variable = weegfactor_gebied)
  ) |>
    dplyr::filter(!is.na(variable), variable != "") |>
    dplyr::distinct() |>
    dplyr::group_by(data_id) |>
    dplyr::summarise(variables = list(unique(variable)), .groups = "drop")
}

load_data <- function(path, variables = NULL) {
  check_file_exists(path)
  read_sav_data(path, variables = variables)
}

validate_data_variables <- function(file_name, required_variables, data_dir = DATA_DIR) {
  available_variables <- read_sav_columns(file.path(data_dir, file_name))
  validation_errors <- find_missing_elements(required_variables, available_variables)

  if (!is.null(validation_errors) && nrow(validation_errors) > 0) {
    rlang::abort(paste(validation_errors$missing_variable, collapse = ", "))
  }

}

load_all_data <- function(config, required_variables, data_dir = DATA_DIR) {
  plan <- config$data |>
    dplyr::inner_join(required_variables, by = "data_id") |>
    dplyr::select(data_id, bestandsnaam_data, variables)

  purrr::set_names(
    purrr::pmap(plan, \(data_id, bestandsnaam_data, variables) {
      load_data(file.path(data_dir, bestandsnaam_data), variables = variables)
    }),
    plan$data_id
  )
}

validate_all_data_files <- function(config, required_variables, data_dir = DATA_DIR) {
  plan <- config$data |>
    dplyr::inner_join(required_variables, by = "data_id") |>
    dplyr::select(data_id, bestandsnaam_data, variables)

  purrr::pmap(plan, \(data_id, bestandsnaam_data, variables) {
    missing <- validate_data_variables(bestandsnaam_data, variables, data_dir)
    if (length(missing) > 0) {
      data.frame(
        data_id = data_id,
        file_name = bestandsnaam_data,
        missing_variable = missing
      )
    }
  }) |>
    dplyr::bind_rows()
}