validate_config <- function(path) {
  
  config_file_issues <- validate_config_file(path)
  
  issues_assert_none(config_file_issues)
  
  config <- read_config(path)
  
  config_table_issues <- validate_config_tables(config)
  
  issues_assert_none(config_table_issues)
  
  config  
}

# validate_config("config/config.xlsx")
# 
# validate_config("config/config - error.xlsx")
# 
# validate_config("config/bestandnaam is fout.xlsx")