

#' Create a clinical research project
#'
#' Create a clinical research project with a standardized structure:
#' \preformatted{
#' ├── main.R
#' ├── NEWS.md
#' ├── README.md
#' └── my_proj.Rproj
#' ├── R
#' │   ├── init.R
#' │   ├── read.R
#' │   ├── check.R
#' │   ├── description.R
#' │   ├── population.R
#' │   ├── graph.R
#' │   └── report.R
#' }
#'
#' @param path Destination directory for the project root. Wille be created if needed.
#' @param trial_name The abbreviated name of the trial.
#' @param headers Optional key–value headers to inject at the top of created files
#' @param open If `TRUE`, opens the new project in RStudio.
#' @param verbose If `TRUE`, print diagnostics.
#' @param ... Dots are ignored. Reserved for future extensions.
#'
#' @section Structure:
#' At the root of the project:
#' * `README.md`: short project description
#' * `NEWS.md`: version log
#' * `main.R`: central script that orchestrates the workflow
#' * `<project>.Rproj`: RStudio project
#'
#' In the R folder:
#' * `init.R`: packages loading and global options
#' * `read.R`: data import and global variables
#' * `population.R`: protocol populations
#' * Files ranging from `09_xxx` to `15_xxx` hold your analyses
#' * `check.R`: data checks (e.g., `edc_data_warn()`)
#' * `report.R`: report generation (e.g., `{{officer}}`)
#'
#'
#' @return Invisibly, the normalized path to the created project.
#' @export
#' @importFrom cli cli_abort cli_inform cli_warn
#' @importFrom dplyr setdiff
#' @importFrom fs dir_create dir_ls file_copy is_dir path path_dir path_package
#' @importFrom purrr walk
#' @importFrom rlang check_dots_empty is_installed
#' @importFrom stringr fixed str_replace
#'
#' @examples
#' \dontrun{
#'   headers = c("Statistician"="Dan",
#'               "Creation date"="2025-01-01")
#'   gr_new_project(headers=headers, trial_name="MYSTUDY")
#' }
gr_new_project = function(path, ..., trial_name=NULL,
                          headers=NULL, open=TRUE, verbose=TRUE){
  check_dots_empty()
  if(missing(path)){
    path = .user_input_directory()
    if(is.null(path)) cli_abort("Operation cancelled by user.")
  }
  if(is.null(trial_name)){
    trial_name =.user_input_text("What is the abbreviated name of the trial?")
    if(is.null(trial_name)) cli_abort("Operation cancelled by user.")
  }
  add_headers = !is.null(headers)
  if(add_headers){
    headers = c("Trial"=trial_name, headers)
  }

  dir_create(path)
  if(!is_dir(path)){
    cli_abort("`path` should be a directory.")
  }
  path_files = dir_ls(path)
  if(length(path_files)>0){
    cli_abort(c("`path` should be empty, but has {length(path_files)} child{?s}.",
                i="{.path {str_remove(path_files, path)}}"),
              class="gr_new_project_notempty_error")
  }

  #copy template files from package to path
  rproj_file = paste0(basename(path), ".Rproj")
  templ_dir = path_package("/init_proj", package="grstat")
  pkg_files = dir_ls(templ_dir, type="file", recurse=TRUE)
  new_files = pkg_files %>%
    str_replace(fixed(as.character(templ_dir)), path) %>%
    str_replace("xxxxxx.Rproj", rproj_file) %>%
    path()
  new_dirs = paste(path, c("data", "output/check", "output/graph", "output/report"), sep="/")
  dir_create(c(unique(path_dir(new_files)), new_dirs))
  file_copy(pkg_files, new_path=new_files, overwrite=TRUE)

  #replace template variables
  header = .get_proj_header(headers)
  new_files %>%
    walk(~{
      .x %>%
        file_prepend(header, do=add_headers) %>%
        file_str_replace(
          "VAR_PROJ_NAME"=trial_name,
          "VAR_GRSTAT_VERSION"=as.character(packageVersion("grstat")),
          "VAR_RPROJ_FILE"=rproj_file,
          "VAR_DATE"=today_ymd()
        )
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

  #open in RStudio
  if(missing(open)){
    open = .user_input_yesno("Open it in RStudio right now?") %>%
      replace_na(FALSE)
  }
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

#' @noRd
#' @keywords internal
file_prepend = function(file, txt, do) {
  if(!is_true(do)) return(file)
  txt %>%
    c(readLines(file)) %>%
    writeLines(con=file)
  file
}


.user_input_text = function(msg, default=NULL){
  if(requireNamespace("rstudioapi", quietly=TRUE) && rstudioapi::hasFun("showPrompt")) {
    rtn = rstudioapi::showPrompt(title="Enter text", message=msg, default=default)
  } else if(.Platform$OS.type == "windows") {
    rtn = winDialogString(msg, default=default)
  } else{
    rtn = readline(msg)
  }
  rtn
}

.user_input_yesno = function(msg){
  if(requireNamespace("rstudioapi", quietly=TRUE) && rstudioapi::hasFun("showQuestion")) {
    rtn = rstudioapi::showQuestion(title="Confirm", message=msg, ok="Yes", cancel="No")
  } else {
    rtn = askYesNo(msg)
  }
  rtn
}



.user_input_directory = function(){
  cli_inform("Select the root directory of the new project")
  if (requireNamespace("rstudioapi", quietly=TRUE) && rstudioapi::hasFun("selectFile")) {
    return(rstudioapi::selectDirectory(
      caption="Select the root directory of the new project",
      label="Select"
    ))
  }
  if (.Platform$OS.type == "windows") {
    rtn = utils::choose.dir()
    if(all(is.na(rtn))) rtn = NULL
    return(rtn)
  }
  if (requireNamespace("tcltk", quietly=TRUE)) {
    return(tcltk::tk_choose.dir(getwd()))
  }
  cli_abort("Cannot")
}


#' @importFrom cli boxx
#' @importFrom stringr str_split_1
.get_proj_header = function(headers){
  header_data = paste(names(headers), headers, sep=": ")
  boxx(header_data, ) %>%
    str_split_1("\n") %>%
    paste0("# ", .)
}


