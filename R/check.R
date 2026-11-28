#' Check Required Packages
#'
#' This function checks if all required packages are installed. If any are missing,
#' it will throw an error with installation instructions.
#'
#' @param required_packages A character vector of package names to check for.
#'   Defaults to the global variable `REQUIRED_PACKAGES`.
#'
#' @return Invisible `TRUE` if all packages are installed, otherwise an error is thrown.
#'
#' @examples
#' \dontrun{
#' # Check default required packages
#' check_required_packages()
#' }
#'
#' @export
check_required_packages <- function(required_packages = REQUIRED_PACKAGES) {

  missing_packages <- setdiff(required_packages, row.names(installed.packages()))

  if (length(missing_packages) > 0) {
    # Create a clear, educational error message
    package_list <- paste(missing_packages, collapse = ", ")
    install_instructions <- paste(
      "De volgende packages zijn nodig maar niet geïnstalleerd:",
      package_list,
      "",
      "Installeer deze handmatig met:",
      "install.packages(c(\"", paste(missing_packages, collapse = "\", \""), "\"))",
      sep = "\n"
    )

    rlang::abort(install_instructions)
  }

  invisible(TRUE)
}

check_file_exists <- function(path) {

  if (!file.exists(path)) {

    rlang::abort(message = paste("Controleer de opgegeven padnaam:", path, "is niet gevonden."))
    
  }
  
  invisible(TRUE)

}
