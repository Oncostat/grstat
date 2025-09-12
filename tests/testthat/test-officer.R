

test_that("Officer Template is working", {
  template = gr_officer_template(title = "The Study", acronym = "ThSdu")

  for(i in 1:9){
    template = template %>%
      body_add_title("Titre de niveau {i}", level = i)%>%
      body_add_normal("Lorem ipsum sinet dolor blablabla je suis dans un chapitre de niveau {i}")
  }


  template %>%
    body_add_title("Titre 1, le retour", level = 1)

  docx_summary(template) %>%
    as_tibble() %>%
    expect_snapshot_value(style="json2")
})
