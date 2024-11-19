

# Init ----------------------------------------------------------------------------------------

folder = glue("graph/{date_extraction}/")
dir.create(folder, showWarnings=FALSE)

SAVE_PLOTS = FALSE

ggsave_here = function(filename, ...){
  if(SAVE_PLOTS) ggsave(glue("{folder}{filename}"), ...)
}


# Inclusions ----------------------------------------------------------------------------------

plots$inclusions = iris %>%
  ggplot(aes(x = Sepal.Length, y = Sepal.Width))+
  geom_point()

ggsave_here("inclusions.png", plots$inclusions, width=10, height=5)


# Efficacy ------------------------------------------------------------------------------------

#https://www.danieldsjoberg.com/ggsurvfit/articles/gallery.html#kmunicate

plots$km_efficacy = survfit2(Surv(time, status) ~ surg, data = df_colon) %>%
  ggsurvfit(linetype_aes = TRUE) +
  add_confidence_interval() +
  add_risktable(
    risktable_stats = c("n.risk", "cum.censor", "cum.event")
  ) +
  theme_ggsurvfit_KMunicate() +
  scale_y_continuous(limits = c(0, 1)) +
  scale_x_continuous(expand = c(0.02, 0)) +
  theme(legend.position.inside = c(0.85, 0.85))

ggsave_here("km_efficacy.png", plots$km_efficacy, width=10, height=5)

