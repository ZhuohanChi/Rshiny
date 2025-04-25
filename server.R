# server.R

library(shiny)
library(plotly)

# Read the datasets
nicu_30_mean <- read.csv("./data/nicu_30_mean.csv", stringsAsFactors = FALSE)
nicu_120_mean <- read.csv("./data/nicu_120_mean.csv", stringsAsFactors = FALSE)
nicu_120_cb <- read.csv("./data/nicu_120_cb_data.csv", stringsAsFactors = FALSE)
nicu_30_cb  <- read.csv("./data/nicu_30_cb_data.csv",  stringsAsFactors = FALSE)
nicu_120_gb <- read.csv("./data/nicu_120_gb_data.csv", stringsAsFactors = FALSE)
nicu_30_gb  <- read.csv("./data/nicu_30_gb_data.csv",  stringsAsFactors = FALSE)

# Build server
server <- function(input, output) {
  
  # Reactive data for Box Plot
  selectedDataBox <- reactive({
    if (input$timeSel == "30min") {
      nicu_30_mean
    } else {
      nicu_120_mean
    }
  })
  
  output$boxPlot <- renderPlotly({
    df_box <- selectedDataBox()
    
    plot_ly(
      data = df_box,
      x = ~factor(is_infected),
      y = ~.data[[input$varSel]],
      color = ~factor(is_infected),
      type = "box",
      boxpoints = "all",
      jitter = 0.3
    ) %>%
      layout(
        title = paste("Boxplot of", input$varSel, "by Infection Status"),
        xaxis = list(title = "Infection (0 = No, 1 = Yes)"),
        yaxis = list(title = input$varSel)
      )
  })
  
  # Reactive data for Line Chart
  selectedDataLine <- reactive({
    df_line <- switch(input$dataSel,
                      "120min CatBoost" = nicu_120_cb,
                      "30min CatBoost"  = nicu_30_cb,
                      "120min GradientBoost" = nicu_120_gb,
                      "30min GradientBoost"  = nicu_30_gb)
    
    # Clean up
    df_line$Ranking <- as.numeric(df_line$Ranking)
    if (!"Hyperparameters" %in% colnames(df_line)) {
      df_line$Hyperparameters <- "N/A"
    } else {
      df_line$Hyperparameters <- as.character(df_line$Hyperparameters)
    }
    df_line
  })
  
  output$linePlot <- renderPlotly({
    df_line <- selectedDataLine()
    
    hover_text <- ~paste(
      "Rank:", Ranking,
      "<br>CV Score:", round(CV_Score, 4),
      "<br>Precision:", round(Precision, 4),
      "<br>Recall:", round(Recall, 4),
      "<br>F1:", round(F1_Score, 4),
      "<br>Accuracy:", round(Accuracy, 4),
      "<br>Hyperparameters:", Hyperparameters
    )
    
    plot_ly(df_line, x = ~Ranking) %>%
      add_trace(y = ~CV_Score,  name = "CV Score",   type = "scatter", mode = "lines+markers",
                text = hover_text, hoverinfo = "text") %>%
      add_trace(y = ~Precision, name = "Precision",  type = "scatter", mode = "lines+markers",
                text = hover_text, hoverinfo = "text") %>%
      add_trace(y = ~Recall,    name = "Recall",     type = "scatter", mode = "lines+markers",
                text = hover_text, hoverinfo = "text") %>%
      add_trace(y = ~F1_Score,  name = "F1",         type = "scatter", mode = "lines+markers",
                text = hover_text, hoverinfo = "text") %>%
      add_trace(y = ~Accuracy,  name = "Accuracy",   type = "scatter", mode = "lines+markers",
                text = hover_text, hoverinfo = "text") %>%
      layout(
        title = paste("Line Chart -", input$dataSel),
        xaxis = list(title = "Ranking"),
        yaxis = list(title = "Score")
      )
  })
  
}
