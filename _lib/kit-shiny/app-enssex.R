library(shiny)
# DESAFIO OPCIONAL: la misma idea con la base 1 de la ENSSEX.
# Necesita enssex_base1.csv en la misma carpeta que este archivo.
enssex <- read.csv("enssex_base1.csv")
enssex$sexo <- factor(enssex$sexo, levels = 1:2, labels = c("Hombre", "Mujer"))
# Cada indicador: su variable, el codigo que cuenta como "si"
# y los codigos validos
indicadores <- list(
  "Casado o casada" =
    list(variable = "p7", si = 1, validos = 1:8),
  "Alcohol en el mes previo" =
    list(variable = "i_5_p26", si = 1, validos = 1:3),
  "Depende por completo de su pareja" =
    list(variable = "p93", si = 1, validos = 1:3)
)
# UI: lo que se ve
ui <- fluidPage(
  titlePanel("ENSSEX: indicadores por sexo y edad"),
  sidebarLayout(
    sidebarPanel(
      selectInput("indicador", "Indicador", choices = names(indicadores)),
      sliderInput("edad", "Rango de edad", min = 18, max = 100,
                  value = c(30, 59))
    ),
    mainPanel(
      plotOutput("grafico"),
      tableOutput("tabla")
    )
  )
)
# SERVER: lo que se calcula
server <- function(input, output) {
  # Porcentaje por sexo; se recalcula cuando cambia un control
  porcentajes <- reactive({
    elegido <- indicadores[[input$indicador]]
    respuesta <- enssex[[elegido$variable]]
    en_rango <- enssex$edad >= input$edad[1] & enssex$edad <= input$edad[2]
    personas <- enssex[en_rango & respuesta %in% elegido$validos, ]
    cumple <- personas[[elegido$variable]] == elegido$si
    100 * tapply(personas$ponderador * cumple, personas$sexo, sum) /
      tapply(personas$ponderador, personas$sexo, sum)
  })
  output$grafico <- renderPlot({
    barplot(porcentajes(), ylim = c(0, 100), ylab = "Porcentaje",
            col = c("#555555", "#bc7777"), main = input$indicador)
  })
  output$tabla <- renderTable({
    data.frame(Sexo = names(porcentajes()), Porcentaje = porcentajes())
  }, digits = 1)
}
shinyApp(ui, server)
