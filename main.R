# Environment leegmaken
rm(list = ls())

# Functies laden ---------------------------------------------------------
list.files(path = 'R',
           pattern = "\\.R$", 
           recursive = T,
           full.names = TRUE) |>
  purrr::walk(source)

# Instellingen -----------------------------------------------------------


# Rapportages genereren en opslaan ---------------------------------------
run_report_pipeline(config_path = CONFIG_PATH)



