# Packages die geinstalleerd moeten zijn om het script uit te kunnen voeren
REQUIRED_PACKAGES <- c("cli", "dplyr", "haven", "officer", "purrr", "rlang", "readxl", "stringr")

# Pad-constanten
CONFIG_PATH <- "config/configuratie.xlsx"
TEMPLATES_DIR <- "templates"
OUTPUT_DIR <- "output"
DATA_DIR <- "data"

# Verwachte schema per tabblad
REQUIRED_TABLES <- list(
  rapportages = c("rapportage_id", "bestandsnaam_rapportage",
                 "bestandsnaam_template", "tabblad_id"),
  data = c("data_id", "bestandsnaam_data", "tijd_variabele"),
  gebiedsniveaus = c("rapportage_id", "data_id", "gebiedsniveau_id",
                    "gebied_variabele", "gebied_waarde",
                    "gebied_naam", "weegfactor_gebied"),
  labels = c("variabele", "waarde", "label"),
  slides = c("slide_id", "placeholder_id", "omschrijving", "type",
            "variabele", "waarde", "uitsplitsing_variabele",
            "data_id", "gebiedsniveau_id", "tijd_waarde",
            "weging_type", "weegfactor_indicator"),
  weergave = c("tabblad_id", "slide_id", "placeholder_id", "limiet_y_as",
              "grafiek_richting", "legenda_positie")
)

# Geldige waarden (Enums)
WEGING_TYPES <- c("gebied", "indicator", "ongewogen")
GRAFIEK_RICHTINGEN <- c("verticaal", "horizontaal")


