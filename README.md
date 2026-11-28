# report_generator
Tool om met behulp van officer package PowerPoint in bulk rapportages te genereren. Deze repo is een rewrite van https://github.com/ggdatascience/reports_excel_to_powerpoint.

## Handleiding

nog in te vullen


## Conventies

| Laag | Taal | Voorbeeld |
|------|------|-----------|
| Configuratie (tabbladen, kolommen) | Nederlands | `rapportages`, `weegfactor_gebied`, `slides_tabblad` |
| Variabelen in data / placeholders | Zoals in de bron | `GENDER`, `Onderzoeksjaar` |
| R-code (functienamen, variabelen) | Engels (snake_case) | `compute_counts()`, `weight_variable` |
| R-code | Altijd namespace expliciet voor niet-basis-R functies | `dplyr::filter()`, `haven::read_sav()` |


## Bestandsstructuur

```
project/
├── config/
│   └── config.xlsx
├── templates/
│   └── *.pptx
├── output/
│   └── *.pptx
├── data/
│   └── *.sav
└── R/
```

## Tabbladen configuratie

| Tabblad | Doel |
|-------|------|
| `rapportages` | Welke rapportages te maken |
| `data` | Welke databestanden te laden (data moet in data/ staan) |
| `gebiedsniveaus` | Geografische niveaus (gemeente, provincie, land) |
| `labels` | Variabele labels voor figuren aanpassen (standaard worden SPSS value_labels gebruikt) |
| `slides` | Bepalen welke cijfers berekent moeten worden en waar die op welke slide moeten worden geplaatst |
| `weergave` | Standaardopmaak van figuren aanpassen |

## Kolommen configuratie

| Tabblad | Kolom | Doel |
|---|---|---|
| `rapportages` | `rapportage_id` | Unieke naam voor een rapportage en sleutel voor koppeling met gebiedsniveaus |
| `rapportages` | `bestandsnaam_rapportage` | Bestandsnaam voor de rapportage (wordt opgeslagen in map output/) |
| `rapportages` | `bestandsnaam_template` | Bestandsnaam voor het PowerPoint template (wordt opgehaald uit map templates/) |
| `rapportages` | `tabblad_id` | Naam en sleutel van het tabblad waar de configuratie voor de slides in staat. Verschillende rapportages mogen dezelfde slideconfiguratie gebruiken. Je kunt ook verschillende slideconfiguraties toevoegen en gebruiken per rapportage.  |
| `data` | `data_id` | Unieke naam voor een databestand en sleutel voor koppeling met slideconfiguratie |
| `data` | `bestandsnaam_data` | Bestandsnaam voor het databestand (wordt opgehaald uit map data/). Alleen `.sav` bestanden worden ondersteund |
| `data` | `tijd_variabele` | Naam van de variabele met de tijdsaanduiding (meestal Onderzoeksjaar) |
| `gebiedsniveaus` | `rapportage_id` | Unieke naam voor een rapportage en sleutel voor koppeling met rapportages |
| `gebiedsniveaus` | `data_id` | Unieke naam voor een databestand en sleutel voor koppeling met data |
| `gebiedsniveaus` | `gebiedsniveau_id` | Unieke naam voor een gebiedsniveau en sleutel voor koppeling met slideconfiguratie|
| `gebiedsniveaus` | `gebied_variabele` | Naam van de variabele van een gebiedsniveau |
| `gebiedsniveaus` | `gebied_waarde` | Waarde van een gebied (moet overeenkomen met de waarde in de data) |
| `gebiedsniveaus` | `gebied_naam` | Naam van het gebied (wordt gebruikt in figuren i.p.v. waarde_labels) |
| `gebiedsniveaus` | `weegfactor_gebied` | Variabele met de weegfactor voor een gebied (indien relevant) |
| `labels` | `variabele` | Variabele waarvoor een ander label moet worden getoond |
| `labels` | `waarde` | Waarde waarvoor een ander label moet worden getoond |
| `labels` | `label` | Label dat moet worden getoond |
| `slides` | `slide_id` | Naam van slide en sleutel die samen met placeholder_id refereert aan figuur of type content |
| `slides` | `placeholder_id` | Naam van placeholder en sleutel die samen met slide_id refereert aan figuur of type content |
| `slides` | `omschrijving` | Kolom die bij een grafiek de grafiektitel bevat, bij type tekst de platte tekst, bij overige tekst types de tekst inclusief placeholder die met regex kunnen worden vervangen door percentages |
| `slides` | `type` | Type content dat moet worden gegenereerd (aanvullen met geldige typen zodra deze af zijn) |
| `slides` | `variabele` | Naam van de variabele waarvoor cijfers moeten worden berekend |
| `slides` | `waarde` | Waarde die moet worden getoond in een figuur of tekst|
| `slides` | `uitsplitsing_variabele` | Uitsplitsing waarvoor cijfers moeten worden berekend en getoond |
| `slides` | `data_id` | Sleutel die refereert aan de data die moet worden gebruikt voor deze regel |
| `slides` | `gebiedsniveau_id` | Sleutel die refereert aan het gebiedsniveau waarvoor cijfers moeten worden berekend |
| `slides` | `tijd_waarde` | De waarde van de tijd_variabele waarvoor cijfers moeten worden berekend (meestal een jaartal, bijv. "2026") |
| `slides` | `weging_type` | Type weging dat moet worden toegepast, op basis van gebied, indicator of ongewogen (= geen weging) |
| `slides` | `weegfactor_indicator` | Indien gewogen wordt op indicatorniveau de variabelenaam van de weegfactor |
| `weergave` | `tabblad_id` | Sleutel die refereert het tabblad waarop de slideconfiguratie staat |
| `weergave` | `slide_id` | Sleutel die refereert aan de slide waarop de content staat |
| `weergave` | `placeholder_id` | Sleutel die refereert aan de naam van de placeholder van een grafiek |
| `weergave` | `limiet_y_as` | Getal tussen 0 en 1 die de hoogte van de y-as aangeeft (1: as loopt tot 100%) |
| `weergave` | `grafiek_richting` | Richting/ligging van een grafiek (standaard verticaal, vul "horizontaal" in voor horizontale grafiek) |
| `weergave` | `legenda_positie` | Positie van legenda (opties aanvullen, "n" = geen legenda) |


## Weegtypes

De kolom `weging_type` in het tabblad met de slideconfiguratie bepaalt hoe gewogen wordt:

| `weging_type` | Betekenis |
|---|---|
| `gebied` | Gebruik `weegfactor_gebied` uit `gebiedsniveaus` |
| `indicator` | Gebruik `weegfactor_indicator` zoals opgegeven in de slides-sheet |
| `ongewogen` | Geen weging |

