


if(!is_testing() && !is_checking()){

  db = grstat_example(N=200, p_na=0)
  df_ae = db$ae
  df_enrol = db$enrolres

  ae_plot_x1(db$ae, df_enrol=db$enrolres)
  ae_plot_grade_ridges(db$ae, df_enrol=db$enrolres) %>% print()
  butterfly_plot2(db$ae, df_enrol=db$enrolres) %>% print()
  butterfly_plot2(db$ae, df_enrol=db$enrolres, arm = "arm") %>% print()

}

