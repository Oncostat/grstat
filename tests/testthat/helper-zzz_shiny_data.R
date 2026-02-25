library(shiny)

grstat_example_ui = function() {
  fluidPage(
    titlePanel("Paramètres de grstat_example"),

    fluidRow(
      column(
        width = 4,
        h4("Paramètres d'entrée"),
        actionButton("run_sim", "Lancer la simulation"),
        br(), br(),
        tabsetPanel(
          id = "input_tabs",

          tabPanel(
            "Plot",
            fluidRow(
              column(
                12,
                numericInput("N", "Nombre de patients (N)", value = 200, min = 1, step = 1),
                numericInput("seed", "Graine aléatoire (seed)", value = 42, step = 1)
              )
            )
          ),

          tabPanel(
            "Enrol",
            fluidRow(
              column(
                12,
                sliderInput("r", "Proportion contrôle pour arm (r)", min = 0, max = 1, value = 0.5, step = 0.01),
                sliderInput("r2", "Proportion contrôle pour arm3 (r2)", min = 0, max = 1, value = 1/3, step = 0.01)
              )
            )
          ),

          tabPanel(
            "AE",
            fluidRow(
              column(
                6,
                sliderInput("p_na", "Proportion de NA (p_na)", min = 0, max = 1, value = 0, step = 0.01),
                sliderInput("p_sae", "Proportion SAE contrôle (p_sae)", min = 0, max = 1, value = 0.1, step = 0.01),
                sliderInput("p_sae_trt", "Proportion SAE traitement (p_sae_trt)", min = 0, max = 1, value = 0.1, step = 0.01),
                numericInput("n_max", "AE max par patient contrôle (n_max)", value = 15, min = 1, step = 1),
                numericInput("n_max_trt", "AE max par patient traité (n_max_trt)", value = 15, min = 1, step = 1),
              ),
              column(
                6,
                numericInput("w_soc", "Poids SOC contrôle (w_soc)", value = 1, step = 0.1),
                numericInput("w_soc_trt", "Poids SOC traitement (w_soc_trt)", value = 1, step = 0.1),
                numericInput("beta0", "Intercept grade (beta0)", value = -1, step = 0.1),
                numericInput("beta_trt", "Effet traitement (beta_trt)", value = 0.4, step = 0.1),
                numericInput("beta_sae", "Effet SAE (beta_sae)", value = 1, step = 0.1)
              )
            )
          ),

          tabPanel(
            "RECIST",
            fluidRow(
              column(
                6,
                numericInput("rc_delay", "Délai entre 2 évaluations (TODO rc_delay)", value = 15, step = 1),
                numericInput("rc_num_timepoints", "Nombre de visites (rc_num_timepoints)", value = 5, min = 2, step = 1),
                sliderInput("rc_p_new_lesions", "Proba nouvelles lésions (rc_p_new_lesions)", min = 0, max = 1, value = 0.09, step = 0.01),
                sliderInput("rc_p_na", "Proba NA (rc_p_na)", min = 0, max = 1, value = 0.005, step = 0.001),
                sliderInput("rc_p_nt_lesions_yn", "Présence NT (rc_p_nt_lesions_yn)", min = 0, max = 1, value = 0.5, step = 0.01),
                numericInput("rc_sd_tlsum_noise", "SD bruit TLSUM (rc_sd_tlsum_noise)", value = 0.5, step = 0.1),
                numericInput("rc_coef_treatement", "Coefficient traitement (rc_coef_treatement)", value = 3, step = 0.1),
              ),
              column(
                6,
                h4("Probabilités réponse NT (rc_p_nt_lesions_resp)"),
                sliderInput("rc_p_nt_CR", "CR (rc_p_nt_CR)", min = 0, max = 1, value = 0.73, step = 0.01),
                sliderInput("rc_p_nt_SD", "SD (rc_p_nt_SD)", min = 0, max = 1, value = 0.25, step = 0.01),
                sliderInput("rc_p_nt_PD", "PD (rc_p_nt_PD)", min = 0, max = 1, value = 0.01, step = 0.01),
                sliderInput("rc_p_nt_NE", "NE (rc_p_nt_NE)", min = 0, max = 1, value = 0.01, step = 0.01)
              )
            )
          ),

          tabPanel(
            "Follow-up",
            fluidRow(
              column(
                12,
                numericInput("lambda_censor", "Lambda censure (lambda_censor)", value = 0.3, step = 0.01),
                numericInput("lambda_control", "Lambda contrôle (lambda_control)", value = 0.2, step = 0.01),
                numericInput("beta_arm", "Effet bras (beta_arm)", value = -0.6, step = 0.1),
                numericInput("beta_prog_status", "Effet statut progression (beta_prog_status)", value = 0.5, step = 0.1)
              )
            )
          )
        )
      ),

      column(
        width = 8,
        tabsetPanel(
          id = "output_tabs",
          tabPanel("Plot", plotOutput("sim_plot")),
          tabPanel("Enrol", tableOutput("enrol_table")),
          tabPanel("AE", tableOutput("ae_table")),
          tabPanel("RECIST", tableOutput("recist_table")),
          tabPanel("Follow-up", tableOutput("fu_table"))
        )
      )
    )
  )
}




grstat_example_server = function(input, output, session) {

  sim = eventReactive(input$run_sim, {
    grstat_example(
      N = input$N,
      seed = input$seed,

      r = input$r,
      r2 = input$r2,

      p_na = input$p_na,
      p_sae = input$p_sae,
      p_sae_trt = input$p_sae_trt,
      n_max = input$n_max,
      n_max_trt = input$n_max_trt,
      w_soc = input$w_soc,
      w_soc_trt = input$w_soc_trt,
      beta0 = input$beta0,
      beta_trt = input$beta_trt,
      beta_sae = input$beta_sae,

      rc_delay = input$rc_delay,
      rc_num_timepoints = input$rc_num_timepoints,
      rc_p_new_lesions = input$rc_p_new_lesions,
      rc_p_na = input$rc_p_na,
      rc_p_nt_lesions_yn = input$rc_p_nt_lesions_yn,
      rc_p_nt_lesions_resp = list(
        CR = input$rc_p_nt_CR,
        SD = input$rc_p_nt_SD,
        PD = input$rc_p_nt_PD,
        NE = input$rc_p_nt_NE
      ),
      rc_sd_tlsum_noise = input$rc_sd_tlsum_noise,
      rc_coef_treatement = input$rc_coef_treatement,

      lambda_censor = input$lambda_censor,
      lambda_control = input$lambda_control,
      beta_arm = input$beta_arm,
      beta_prog_status = input$beta_prog_status
    )
  })

  output$enrol_table = renderTable({
    x = sim()
    if (is.null(x)) return(NULL)
    head(x$enrolres, 20)
  })

  output$ae_table = renderTable({
    x = sim()
    if (is.null(x)) return(NULL)
    head(x$ae, 20)
  })

  output$recist_table = renderTable({
    x = sim()
    if (is.null(x)) return(NULL)
    head(x$recist, 20)
  })

  output$fu_table = renderTable({
    x = sim()
    if (is.null(x)) return(NULL)
    head(x$fu, 20)
  })

  output$sim_plot = renderPlot({
    x = sim()
    if (is.null(x)) return(NULL)
    get_plot(x)
  })
}


# Make the plot -------------------------------------------------------------------------------


get_plot = function(db){
  set.seed(42)
  data_km = db$enrolres %>%
    left_join(db$fu, by = "subjid") %>%
    mutate(
      time_OS = as.numeric(fu_date - date_inclusion)/365.25,
      event_OS = fu_status == "Dead",
      time_PFS = time_OS - rnorm(n(), 1, 0.5),
      event_PFS = fu_status == "Dead" | rbinom(n(), 1, 0.1)
    )

  km_os = survival::survfit(survival::Surv(time_OS, event_OS) ~ arm, data = data_km)
  p_os = ggsurvfit::ggsurvfit(km_os) +
    ggsurvfit::add_censor_mark() +
    ggsurvfit::add_confidence_interval() +
    ggsurvfit::add_risktable() +
    labs(title="OS")

  #TODO : faire un KM avec la PFS RECIST
  km_pfs = survival::survfit(survival::Surv(time_PFS, event_PFS) ~ arm, data = data_km)
  p_pfs = ggsurvfit::ggsurvfit(km_pfs) +
    ggsurvfit::add_censor_mark() +
    ggsurvfit::add_confidence_interval() +
    ggsurvfit::add_risktable() +
    labs(title="PFS (données totalement aléatoires)")

  patchwork::wrap_plots(p_os, p_pfs, ncol=1, guides="collect")
}


# Run the app ---------------------------------------------------------------------------------

app = shinyApp(
  ui = grstat_example_ui,
  server = grstat_example_server
)
#FIXME décommente cette ligne pour que l'app soit lancée à chaque Ctrl+Shift+L
#Commande pour lancer l'appli
# runApp(app)
