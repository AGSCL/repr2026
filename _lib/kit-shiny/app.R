library(shiny)
# DATOS: postulaciones a la Universidad de Berkeley en 1973, por resultado,
# sexo y departamento. Vienen con R: no hay que cargar ningun archivo.
datos <- UCBAdmissions
# UI: lo que se ve
ui <- fluidPage(
  titlePanel("Admision a Berkeley en 1973, por sexo"),
  sidebarLayout(
    # Un control: el menu de departamentos
    sidebarPanel(
      selectInput("depto", "Departamento", choices = c("Todos", LETTERS[1:6]))
    ),
    # Dos resultados: un grafico y una tabla
    mainPanel(
      plotOutput("grafico"),
      tableOutput("tabla")
    )
  )
)
# SERVER: lo que se calcula
server <- function(input, output) {
  # Postulantes por resultado y sexo, en el departamento elegido.
  # Es reactive(): se recalcula solo cuando cambia el menu
  conteo <- reactive({
    if (input$depto == "Todos") {
      apply(datos, c(1, 2), sum)
    } else {
      datos[, , input$depto]
    }
  })
  # Porcentaje de admitidos en cada sexo; lo usan el grafico y la tabla
  porcentaje <- reactive({
    100 * conteo()["Admitted", ] / colSums(conteo())
  })
  output$grafico <- renderPlot({
    barplot(porcentaje(), names.arg = c("Hombres", "Mujeres"),
            ylim = c(0, 100), ylab = "Porcentaje de admitidos",
            col = c("#555555", "#bc7777"),
            main = paste("Departamento:", input$depto))
  })
  output$tabla <- renderTable({
    data.frame(Sexo = c("Hombres", "Mujeres"),
               Postulantes = as.integer(colSums(conteo())),
               Admitidos = as.integer(conteo()["Admitted", ]),
               Porcentaje = porcentaje())
  }, digits = 1)
}
# La linea que une las dos mitades
shinyApp(ui, server)
