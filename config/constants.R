REQUIRED_SHEETS <- c("reports", "data", "dimensions")

REQUIRED_COLUMNS <- list(
  reports    = c("report_id", "output_filename", "template_path", "slideconfig_sheetname"),
  data       = c("data_id", "data_path", "time_var"),
  dimensions = c("report_id", "data_id", "dim_var", "dim_val", "dim_name", "weight_var")
)