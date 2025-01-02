

#' Create a clinical research project
#'
#' Create a clinical research project with a standardized structure:
#' \preformatted{
#' ├── main.R
#' ├── NEWS.md
#' ├── R
#' │   ├── init.R
#' │   ├── read.R
#' │   ├── check.R
#' │   ├── description.R
#' │   ├── graph.R
#' │   └── report.R
#' ├── README.md
#' └── my_proj.Rproj
#' }
#'
#' @param path A path. If it does not exist, it is created.
#' @param open If `TRUE`, opens the new project in RStudio.
#' @param verbose If `TRUE`, shows diagnostics.
#'
#' @section Structure:
#' At the root of the project:
#' * `README.md` contains a short description of the project
#' * `NEWS.md` contains the descriptions of the versions of the project
#' * `main.R` is the central script that sequentially calls all the others
#'
#' In the R folder:
#' * `init.R` loads all used packages and set options
#' * `read.R` reads the data and sets global variables
#' * `check.R` checks the data, e.g. using `edc_data_warn()`
#' * `description.R` describe the data, e.g. using [crosstable::crosstable()]
#' * `graph.R` create plots, and saves them on the disk or in the `plots` global list
#' * `report.R` creat the report, e.g. using the `officer` package
#'
#'
#' @return The path to the project, invisibly.
#' @export
#' @importFrom cli cli_abort cli_inform cli_warn
#' @importFrom dplyr setdiff
#' @importFrom fs dir_create dir_ls file_copy is_dir path path_dir path_package
#' @importFrom purrr walk
#' @importFrom rlang is_installed
#' @importFrom stringr fixed str_replace
#'
#' @examples
#' \dontrun{
#'   gr_new_project("projects/my_project_folder")
#' }
gr_new_project = function(path, open=TRUE, verbose=TRUE){
  dir_create(path)
  if(!is_dir(path)){
    cli_abort("`path` should be a directory.")
  }
  path_files = dir_ls(path)
  if(length(path_files)>0){
    cli_abort(c("`path` should be empty, but has {length(path_files)} child{?s}.",
                i="{length(path_files)}"),
              class="gr_new_project_notempty_error")
  }

  proj_name = basename(path)
  stat_name = Sys.getenv("USERNAME", unset="Myself")
  rproj_file = paste0(proj_name, ".Rproj")

  #copy template files from package to path
  templ_dir = path_package("/init_proj", package="grstat")
  pkg_files = dir_ls(templ_dir, type="file", recurse=TRUE)
  new_files = pkg_files %>%
    str_replace(fixed(as.character(templ_dir)), path) %>%
    str_replace("xxxxxx.Rproj", rproj_file) %>%
    path()
  dir_create(path_dir(new_files))
  file_copy(pkg_files, new_path=new_files, overwrite=TRUE)

  #replace template variables
  new_files %>%
    walk(~{
      .x %>%
        file_str_replace("VAR_PROJ_NAME"=proj_name,
                         "VAR_STAT_NAME"=stat_name,
                         "VAR_RPROJ_FILE"=rproj_file,
                         "VAR_DATE"=today_ymd())
    })

  #check copy success
  copied_files = dir_ls(path, type="file", recurse=TRUE)
  a=copied_files %>% str_replace(".*Rproj", "xxxxxx.Rproj")
  missing_files = setdiff(basename(pkg_files), basename(a))
  if (length(missing_files) > 0) {
    cli_warn(c("Copied {length(copied_files)}/{length(pkg_files)} files to {.path {path}}",
               "Could not copy files: {.val {missing_files}}"))
  } else if(verbose) {
    cli_inform("Copied {length(copied_files)} files to {.path {path}}")
  }

  #adding box headers?
  # header_data = c("Project: {proj_name}",
  #                 "Statistician: {stat_name}") %>%
  #   map_chr(glue, .envir=current_env())
  #
  # header = cli::boxx(header_data, width=80) %>% paste0("# ", .)

  #open in RStudio
  if(isTRUE(open) && is_installed("rstudioapi")) {
    if(rstudioapi::isAvailable() && rstudioapi::hasFun("openProject")) {
      cli_inform(c("v"="Opening {.path {path}} in new RStudio session"))
      rstudioapi::openProject(path, newSession = TRUE)
      invisible(FALSE)
    }
  }

  invisible(path)
}


# Utils ---------------------------------------------------------------------------------------

#' @noRd
#' @keywords internal
#' @param ... names=pattern, values=replacement
#' @importFrom stringr str_replace_all
file_str_replace = function(file, ...) {
  readLines(file) %>%
    str_replace_all(c(...)) %>%
    writeLines(con=file)
  file
}
