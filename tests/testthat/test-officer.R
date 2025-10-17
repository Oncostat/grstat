

test_that("Officer Template is working", {

  authors = dplyr::bind_rows(
    c(name="Dr Armin Clusion", role="Coordinating investigator",
      address="Gustave Roussy", phone="+33", email="name@gustaveroussy.fr"),
    c(name="Jeanne Alise ", role="Biostatistician",
      address="Gustave Roussy, Bureau of Biostatistic and Epidemiology"),
    c(name="Bertrand Domise", role="Data-manager",
      address="Gustave Roussy, Bureau of Biostatistic and Epidemiology"),
    c(name="Arnaud Cébo", role="Pharmacovigilant",
      address="Gustave Roussy, Pharmacovigilance Unit"),
  )
  sponsor = data.frame(name="Gustave Roussy", address="114 Rue Edouard Vaillant",
                       code="94805 Villejuif Cedex")

  doc = gr_officer_template(
    title="The Great Study", acronym="TGreStu",
    phase="III",
    date_report="2025-01-01",
    date_first="2024-01-01",
    date_last="2024-06-01",
    date_cutoff="2024-09-01",
    date_freeze="2024-09-01",
    cset_number="CSET2099/999",
    eudract_number="2099-99",
    ctgov_number="NCT00099999",
    authors=authors,
    sponsor=sponsor
  )

  for(i in 1:9){
    doc = doc %>%
      body_add_title("Titre de niveau {i}", level = i)%>%
      body_add_normal("Lorem ipsum sinet dolor blablabla je suis dans un chapitre de niveau {i}")
  }

  doc %>%
    body_add_title("Titre 1, le retour", level = 1)

  expect_snapshot_value(docx_summary(doc), style="json2")
})
