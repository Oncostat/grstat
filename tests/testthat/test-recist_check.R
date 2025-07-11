test_that("RECIST checks: rc_check_missing()", {

  # Patient 1 : pas d'erreur
  id1 = tibble(
    subjid = 1,
    rc_date = 0,
    target_site = "lung",
    target_diam = 15,
    new_lesions = "No",
    target_resp = "SD",
    nontarget_yn = "No",
    nontarget_resp = "NE",
    global_resp = "SD"
  )

  # Patient 2 : target_diam manquant mais pas target_site → ERROR
  id2 = tibble(
    subjid = 2,
    rc_date = 0,
    target_site = "liver",
    target_diam = NA,
    new_lesions = "No",
    target_resp = "CR",
    nontarget_yn = "Yes",
    nontarget_resp = "PR",
    global_resp = "CR"
  )

  # Patient 3 : target_diam présent mais pas target_site → ERROR
  id3 = tibble(
    subjid = 3,
    rc_date = 0,
    target_site = NA,
    target_diam = 20,
    new_lesions = "No",
    target_resp = "PR",
    nontarget_yn = "Yes",
    nontarget_resp = "SD",
    global_resp = "PR"
  )

  # Patient 4 : réponse partiellement manquante → WARNING
  id4 = tibble(
    subjid = 4,
    rc_date = 0,
    target_site = "lung",
    target_diam = 10,
    new_lesions = NA,
    target_resp = "SD",
    nontarget_yn = "Yes",
    nontarget_resp = "SD",
    global_resp = NA
  )

  # Patient 5 : tout manquant dans les réponses → OK (ignoré)
  id5 = tibble(
    subjid = 5,
    rc_date = 0,
    target_site = "lung",
    target_diam = 10,
    new_lesions = NA,
    target_resp = NA,
    nontarget_yn = "Yes",
    nontarget_resp = NA,
    global_resp = NA
  )

  chk = bind_rows(id1, id2, id3, id4, id5) %>%
    rc_check_missing()

  expect_equal(chk$target_missing_values$data[[1]]$subjid, c(2, 3))
  expect_equal(chk$resp_missing_values$data[[1]]$subjid, 4)
})


test_that("RECIST checks: rc_check_target_lesions()", {

  # Patient 1 : no error
  id1 = tibble(
    subjid = 1,
    rc_date = 0,
    target_site = paste0("site", 1:3),
    target_diam = 15,
    target_is_node = FALSE
  )
  # Patient 2 : ERROR target_lesions_sup5
  id2 = tibble(
    subjid = 2,
    rc_date = 0,
    target_site = paste0("site", 1:6),
    target_diam = 10,
    target_is_node = FALSE
  )
  # Patient 3 : ERROR target_nodes_sup2
  id3 = tibble(
    subjid = 3,
    rc_date = 0,
    target_site = c("node1", "node2", "node3"),
    target_diam = 10,
    target_is_node = TRUE
  )
  # Patient 4 : ERROR target_bone_lesion
  id4 = tibble(
    subjid = 4,
    rc_date = 0,
    target_site = c("bone", "lung", "bone marrow"),
    target_diam = 10,
    target_is_node = FALSE
  )
  # Patient 5 : ERROR target_sites_sup2
  id5 = tibble(
    subjid = rep(5, 3),
    rc_date = 0,
    target_site = "liver",
    target_diam = 10,
    target_is_node = FALSE
  )

  chk = bind_rows(id1, id2, id3, id4, id5) %>%
    rc_check_target_lesions()

  expect_equal(chk$target_lesions_sup5$data[[1]]$subjid, 2)
  expect_equal(chk$target_nodes_sup2$data[[1]]$subjid, 3)
  expect_equal(chk$target_bone_lesion$data[[1]]$subjid, 4)
  expect_equal(chk$target_sites_sup2$data[[1]]$subjid, 5)
})


test_that("Limit-case test", {
  skip("WIP recist tests")

  #limit case 1
  #Radiologist: sum+20% & +5cm, but not a PD because LN<10
  #If a lesion is CR, it disappeared. Reappearance is a new lesion.
  #page 243
  rc=bind_rows(
    #baseline
    tibble(subjid=1, rc_date=0, target_site="Organ",      target_diam=11,
           target_resp=NA, target_is_node=FALSE),
    tibble(subjid=1, rc_date=0, target_site="Lymph Node", target_diam=16,
           target_resp=NA, target_is_node=TRUE),
    #t1: cr
    tibble(subjid=1, rc_date=1, target_site="Organ",      target_diam=0,
           target_resp="complete", target_is_node=FALSE),
    tibble(subjid=1, rc_date=1, target_site="Lymph Node", target_diam=1,
           target_resp="complete", target_is_node=FALSE),
    #t2: pd?
    tibble(subjid=1, rc_date=2, target_site="Organ",      target_diam=0,
           target_resp="progress", target_is_node=FALSE),
    tibble(subjid=1, rc_date=2, target_site="Lymph Node", target_diam=9,
           target_resp="progress", target_is_node=FALSE),
  ) %>%
    mutate(nontarget_resp="CR", global_resp="CR", new_lesions=FALSE, nontarget_yn=FALSE) %>%
    mutate(target_sum = sum(target_diam), .by=subjid)

  #TODO: appliquer rc_check_target_response
  rc_check_target_response(rc, .summarise_recist(rc))


  #limit case 2 = exception de bon sens à la précédente
  rc=bind_rows(
    #baseline
    tibble(subjid=1, rc_date=0, target_is_node=TRUE, target_site="Lymph Node", target_diam=16),
    #T1: CR = disapearance
    tibble(subjid=1, rc_date=1, target_is_node=TRUE, target_site="Lymph Node", target_diam=9),
    #T2: PD on new lesion
    tibble(subjid=1, rc_date=2, target_is_node=TRUE, target_site="Lymph Node", target_diam=13),
  )
  #



})
