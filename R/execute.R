# Run the full report pipeline: validate packages and config, then load data,
# compute results, generate content, render reports, and write the log.
run_report_pipeline <- function(config_path = CONFIG_PATH, data_dir = DATA_DIR) {

  cli::cli_progress_step("Beschikbare packages controleren")
  check_required_packages()

  cli::cli_progress_step("Configuratie valideren en laden")
  config <- load_config(config_path)

  required_variables <- get_required_variables(config)

  cli::cli_progress_step("Databestanden valideren")  
  validate_all_data_files(config, required_variables, data_dir)

  cli::cli_progress_step("Databestanden laden")  
  data_list <- load_all_data(config, required_variables, data_dir)

  cli::cli_progress_step("Stappenplan voor berekeningen maken")
  create_report_plan(config)

  # cli::cli_progress_step("Cijfers berekenen")
  # compute_report_results()

  # cli::cli_progress_step("Figuren en dynamische tekst genereren")
  # generate_report_content()
  
  # cli::cli_progress_step("Rapportages genereren")
  # render_reports()
  
  # cli::cli_progress_step("Logboek schrijven")
  # write_report_log()

}
