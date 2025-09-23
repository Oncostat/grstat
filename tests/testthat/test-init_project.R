
skip_if(is_checking())

test_that("gr_new_project works", {
  path = fs::path_temp("/test/test_init_project_dir")
  unlink(path, recursive=TRUE)

  gr_new_project(path, open=FALSE, verbose=FALSE, trial_name="TEST", headers=NULL)

  # browseURL(path)
  # fs::dir_tree(path)

  copied_files = dir_ls(path, type="file", recurse=TRUE)
  templ_dir = path_package("/init_proj", package="grstat")
  pkg_files = dir_ls(templ_dir, type="file", recurse=TRUE)

  expect_equal(length(copied_files), length(pkg_files))


  gr_new_project(path, open=FALSE, verbose=FALSE, trial_name="TEST", headers=NULL) %>%
    expect_error(class="gr_new_project_notempty_error")

  unlink(path, recursive=TRUE)
})

