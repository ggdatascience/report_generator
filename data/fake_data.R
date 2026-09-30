# Benodigde packages laden
library(haven)
library(tidyverse)

# Random seed bepalen zodat random samples altijd hetzelfde zijn
set.seed(123)

# Random data genereren
data <- data.frame(
  Onderzoeksjaar = labelled(sample(c(2012, 2016, 2020, 2022, 2024), size = 20000, replace = T, prob = c(0.2,0.2,0.2,0.2,0.2)),
                            label = 'Onderzoeksjaar'),
  weegfactor2024 = labelled(runif(20000, min = 0.2, max = 5) %>% { . / sum(.) * 20000 },
                        label = 'Weegfactor2024'),
  weegfactor2022 = labelled(runif(20000, min = 0.2, max = 5) %>% { . / sum(.) * 20000 },
                            label = 'Weegfactor2022'),
  weegfactor2020 = labelled(runif(20000, min = 0.2, max = 5) %>% { . / sum(.) * 20000 },
                        label = 'Weegfactor2020'),
  weegfactor2016 = labelled(runif(20000, min = 0.2, max = 5) %>% { . / sum(.) * 20000 },
                            label = 'Weegfactor2016'),
  weegfactor2012 = labelled(runif(20000, min = 0.2, max = 5) %>% { . / sum(.) * 20000 },
                            label = 'Weegfactor2012'),
  GENDER = labelled(x = sample(c(1,2, NA), size = 20000, replace = T, prob = c(0.45,0.45,0.1)), 
                    labels = c('Jongen' = 1, 'Meisje' = 2),
                    label = 'Gender in twee categorieën'),
  KLAS = labelled(x = sample(c(1,2, NA), size = 20000, replace = T, prob = c(0.45,0.45,0.1)), 
                  labels = c('Klas 2' = 1, 'Klas 4' = 2),
                  label = 'Leerjaar in 3 cat'),
  MBOKK3S31 = labelled(x = sample(c(1,2, NA), size = 20000, replace = T, prob = c(0.45,0.45,0.1)), 
                            labels = c('Vmbo' = 1, 'Havo/Vwo' = 2),
                            label = 'Onderwijssoort in 2 groepen'),
  MBOKK3S32 = labelled(x = sample(c(1,2,3, NA), size = 20000, replace = T, prob = c(0.3,0.3,0.3,0.1)), 
                       labels = c('Vmbo' = 1, 'Havo' = 2, 'Vwo' = 3),
                       label = 'Onderwijssoort in 2 groepen'),
  PBMHK3S3 = labelled(x = sample(c(0,1, NA), size = 20000, replace = T, prob = c(0.71,0.28,0.01)), 
                      labels = c('Nee' = 0,  'Ja' = 1),
                      label = 'Heeft psychische klachten (MHI-5 <= 60)'),
  MCMZGB208 = labelled(x = sample(c(1,2, NA), size = 20000, replace = T, prob = c(0.14,0.85,0.01)), 
                      labels = c('Ja' = 1,  'Nee' = 2),
                      label = 'Geeft mantelzorg'),
  EBEGK311 = labelled(x = sample(c(1,2,3,4,5,NA), size = 20000, replace = T, prob = c(0.30,0.49,0.17,0.02,0.01,0.01)), 
                      labels = c('Zeer goed' = 1, 'Goed' = 2, 'Gaat wel' = 3, 'Slecht' = 4, 'Zeer slecht' = 5),
                      label = 'Hoe is over het algemeen je gezondheid?'),
  FLBMK301 = labelled(sample(c(25:75, NA), size = 20000, replace = T),
                      label = 'Hoeveel kilo weeg je? (Zonder kleren aan)'),
  STRESS1 = labelled(x = sample(c(0,1, NA), size = 20000, replace = T, prob = c(0.4,0.59,0.01)), 
                      labels = c('Nee' = 0,  'Ja' = 1),
                      label = 'Ervaart stress door huiswerk'),
  STRESS2 = labelled(x = sample(c(0,1, NA), size = 20000, replace = T, prob = c(0.3,0.69,0.01)), 
                     labels = c('Nee' = 0,  'Ja' = 1),
                     label = 'Ervaart stress door thuissituatie'),
  STRESS3 = labelled(x = sample(c(0,1, NA), size = 20000, replace = T, prob = c(0.1,0.89,0.01)), 
                     labels = c('Nee' = 0,  'Ja' = 1),
                     label = 'Ervaart stress door werk'),
  STRESS4 = labelled(x = sample(c(0,1, NA), size = 20000, replace = T, prob = c(0.5,0.49,0.01)), 
                     labels = c('Nee' = 0,  'Ja' = 1),
                     label = 'Ervaart stress door ouders'),
  STRESS5 = labelled(x = sample(c(0,1, NA), size = 20000, replace = T, prob = c(0.6,0.39,0.01)), 
                     labels = c('Nee' = 0,  'Ja' = 1),
                     label = 'Ervaart stress door vrienden'),
  gemeente = labelled(x = sample(c(1,2,3), size = 20000, replace = T, prob = c(0.50,0.30,0.20)), 
                        labels = c('Zandwijk' = 1,  'Bosmeer' = 2, 'Heideveen' = 3),
                        label = 'Gemeente'),
  nederland = labelled(x = rep(1, 20000), 
                   labels = c('Nederland' = 1),
                   label = 'Nederland')
)

# Data opslaan als SPSS databestand
write_sav(data, 'data/data.sav')

# Random data genereren
data2 <- data.frame(
  Jaar = labelled(sample(c(2012, 2016, 2020, 2022, 2024), size = 20000, replace = T, prob = c(0.2,0.2,0.2,0.2,0.2)),
                            label = 'Onderzoeksjaar'),
  GENDER = labelled(x = sample(c(1,2, NA), size = 20000, replace = T, prob = c(0.45,0.45,0.1)), 
                    labels = c('Jongen' = 1, 'Meisje' = 2),
                    label = 'Gender in twee categorieën'),
  GELUK = labelled(x = sample(c(0,1, NA), size = 20000, replace = T, prob = c(0.2,0.79,0.01)), 
                     labels = c('Nee' = 0,  'Ja' = 1),
                     label = 'Voelt zich meestal of altijd gelukkig'),
  wijk = labelled(x = sample(c(1,2,3), size = 20000, replace = T, prob = c(0.20,0.50,0.30)), 
                      labels = c('Bosrand' = 101,  'Centrum' = 201, 'Oud-West' = 301),
                      label = 'Gemeente')
)

# Data opslaan als SPSS databestand
write_sav(data2, 'data/data2.sav')
