compute_counts <- function(data, group_vars, weight_variable = NULL) {

  has_weight <- !is.null(weight_variable) && !is.na(weight_variable)

  vars <- c(group_vars, if (has_weight) weight_variable) |>
    unique()

  data |>
    dplyr::select(dplyr::all_of(vars)) |>
    dplyr::group_by(dplyr::across(dplyr::all_of(group_vars))) |>
    dplyr::summarise(
      n = dplyr::n(),
      n_weighted = if (has_weight) sum(.data[[weight_variable]]) else NA_real_,
      .groups = "drop")
  
}

create_report_plan <- function(config) {

  geolevels <- config$gebiedsniveaus |>
      dplyr::distinct(data_id, gebiedsniveau_id, gebied_variabele, weegfactor_gebied, .keep_all = FALSE)

  config$slides |>
      dplyr::left_join(geolevels, by = c("data_id", "gebiedsniveau_id")) |>
      dplyr::filter(!is.na(variabele), variabele != "") |>
      dplyr::mutate(
        weegfactor_variabele =  dplyr::case_when(
          weging_type == "indicator" ~ weegfactor_indicator,
          weging_type == "gebied" ~ weegfactor_gebied,
          TRUE ~ NA_character_
        )
      ) |>
      dplyr::select(data_id, variabele, uitsplitsing_variabele, gebied_variabele, weegfactor_variabele)  
  
}