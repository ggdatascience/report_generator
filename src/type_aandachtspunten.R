# Inladen van berekende percentages
PERCENTAGES <- read.xlsx("data/percentages.xlsx", sheet = "percentages")

# Inladen van tabel met definitie per indicator die aangeeft of een hogere waarde positief is of niet
INDICATOR_RICHTING <- read.xlsx("data/percentages.xlsx", sheet = "indicator_richting")

# Drempelwaarde die bepaalt of een indicator sterk afwijkt
DREMPEL_STERK <- 10

# Drempelwaarde die bepaalt of een indicator licht afwijkt 
DREMPEL_LICHT <- 5

# Gunstig: significante afwijking van 10 procentpunten in positieve zin.
# Mogelijk aandachtspunt: significante afwijking van 5-10 procentpunten in negatieve zin.
# Ongunstig: significante afwijking van 10 of meer procentpunten in negatieve zin.

# Categorieen die worden gebruikt in de eindtabel en een kleur
# Namen en kleuren zijn volledig aanpasbaar
CATEGORIEEN <- c("Gunstig" = "#C6EFCE", "Ongunstig" = "#FFC7CE", "Mogelijk aandachtspunt" = "#FFEB9C")

type_aandachtspunten <- function(report_params, ...) {
  
  school <- report_params$report_name
  
  data_regio <- PERCENTAGES %>%
    filter(gebied == "Regio") %>%
    select(jaar, indicator, waarde_regio = waarde)
  
  tabel <- PERCENTAGES %>%
    filter(gebied == school) %>%
    left_join(data_regio, by = c("jaar", "indicator")) %>%
    left_join(INDICATOR_RICHTING, by = c("indicator")) %>%
    mutate(aandachtspunt = case_when(
      waarde - waarde_regio >= DREMPEL_STERK & hoger_is_positief == "ja" ~ names(CATEGORIEEN)[1],
      waarde - waarde_regio >= DREMPEL_STERK & hoger_is_positief == "nee" ~ names(CATEGORIEEN)[2],
      waarde - waarde_regio <= -DREMPEL_STERK & hoger_is_positief == "ja" ~ names(CATEGORIEEN)[2],
      waarde - waarde_regio <= -DREMPEL_STERK & hoger_is_positief == "nee" ~ names(CATEGORIEEN)[1],
      waarde - waarde_regio >= DREMPEL_LICHT & waarde - waarde_regio < DREMPEL_STERK & hoger_is_positief == "nee" ~ names(CATEGORIEEN)[3],
      waarde - waarde_regio <= -DREMPEL_LICHT & waarde - waarde_regio > -DREMPEL_STERK & hoger_is_positief == "ja" ~ names(CATEGORIEEN)[3],
      TRUE ~ "overig"
    ))
  
  aandachtspunten_overig <- paste(tabel$indicator[tabel$aandachtspunt == "overig"], collapse = ", ")
  
  aandachtspunten_tabel <- tabel %>%
    select(indicator, aandachtspunt) %>%
    filter(aandachtspunt %in% names(CATEGORIEEN)) %>%
    mutate(aandachtspunt = factor(aandachtspunt, levels = names(CATEGORIEEN))) %>%
    group_by(aandachtspunt) %>%
    mutate(rij = row_number()) %>%
    ungroup() %>%
    pivot_wider(names_from = aandachtspunt, values_from = indicator, names_expand = TRUE) %>%
    select(all_of(names(CATEGORIEEN)))
  
  ft <- aandachtspunten_tabel %>%
    flextable() %>%
    bg(j = names(CATEGORIEEN)[1], bg = CATEGORIEEN[[1]], part = "header") %>% # Achtergrondkleur van header aanpassen
    bg(j = names(CATEGORIEEN)[2], bg = CATEGORIEEN[[2]], part = "header") %>% # Achtergrondkleur van header aanpassen
    bg(j = names(CATEGORIEEN)[3], bg = CATEGORIEEN[[3]], part = "header") %>% # Achtergrondkleur van header aanpassen
    width(j = names(CATEGORIEEN)[1], width = 3) %>% # Kolombreedte aanpassen
    width(j = names(CATEGORIEEN)[2], width = 3) %>% # Kolombreedte aanpassen
    width(j = names(CATEGORIEEN)[3], width = 3) %>% # Kolombreedte aanpassen
    colformat_char(na_str = "") %>%
    add_footer_lines(paste0("Onderwerpen waar de school vergelijkbaar is met de regio: ", aandachtspunten_overig)) %>%
    font(fontname = "Calibri", part = "all") %>% # Lettertype aanpassen
    fontsize(size = 11, part = "body") %>% # Font size aanpassen
    fontsize(size = 11, part = "header") %>% # Font size aanpassen
    fontsize(size = 8, part = "footer") %>% # Font size aanpassen
    align(align = "center", part = "header") %>% # header centreren
    autofit()
  
  ft

}
