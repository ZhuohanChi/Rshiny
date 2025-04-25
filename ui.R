# ui.R

library(shiny)
library(plotly)

# Read the datasets
nicu_30_mean <- read.csv("./data/nicu_30_mean.csv", stringsAsFactors = FALSE)
nicu_120_mean <- read.csv("./data/nicu_120_mean.csv", stringsAsFactors = FALSE)
nicu_120_cb <- read.csv("./data/nicu_120_cb_data.csv", stringsAsFactors = FALSE)
nicu_30_cb  <- read.csv("./data/nicu_30_cb_data.csv",  stringsAsFactors = FALSE)
nicu_120_gb <- read.csv("./data/nicu_120_gb_data.csv", stringsAsFactors = FALSE)
nicu_30_gb  <- read.csv("./data/nicu_30_gb_data.csv",  stringsAsFactors = FALSE)

# Build UI
fluidPage(
  
  titlePanel("NICU data description"),
  
  tabsetPanel(
    
    # Box Plot Tab
    tabPanel("Box Plot",
             sidebarLayout(
               sidebarPanel(
                 selectInput('timeSel', 'Time Window:',
                             choices = c('30min', '120min')),
                 selectInput('varSel', 'Variable:',
                             choices = names(nicu_30_mean)[-c(1,11)],
                             selected = "Heart Rate_mean_30")
               ),
               mainPanel(
                 plotlyOutput('boxPlot'),
                 h4("Take-away for Box Plot"),
                 p("This box plot shows the distribution of the selected variable, comparing infected vs. non-infected patients over different time windows. Hovering displays summary statistics. People can know basic data distribution in the dataset.")
               )
             )
    ),
    
    # Line Chart Tab
    tabPanel("Line Chart of Model Performance",
             sidebarLayout(
               sidebarPanel(
                 selectInput('dataSel', 'Choose Dataset:',
                             choices = c('120min CatBoost' = '120min CatBoost',
                                         '30min CatBoost'  = '30min CatBoost',
                                         '120min GradientBoost' = '120min GradientBoost',
                                         '30min GradientBoost'  = '30min GradientBoost'))
               ),
               mainPanel(
                 plotlyOutput('linePlot'),
                 h4("Take-away for Line Chart"),
                 p("This line plot compares CV Score, Precision, Recall, F1, and Accuracy for different ranks of model performance. Hovering shows the hyperparameter details. It is easily to find the best machine learning hyperparameter in different machine learning models.")
               )
             )
    ),
    
    # Dataset Description Tab
    tabPanel("Dataset Description",
             fluidRow(
               column(12,
                      h3("Dataset Overview"),
                      p("Data Source: Neonatal intensive care unit (NICU) electronic health record extracts from MIMIC-III public dataset."),
                      p("Sample Size: 2,450 patient encounters (approximately 12 million time‑stamped vital‑sign observations)."),
                      p("Collection Method: Retrospective SQL extraction of electronic health records from MIMIC-III public dataset."),
                      p("Study Population: Infants admitted to the NICU once, and alive in the first two hours after admitted to ICU."),
                      p("Study Time: Due to the privacy concern, the time period of the patient could not provide, but data gathered on Feb.18 2025 by SQL from MIMIC-III.")
               )
             )
    )
    
  ),
  
  # ===== Real-world Impact Section at the Bottom =====
  br(), hr(),
  fluidRow(
    column(12,
           h4("Real-World Impact"),
           p("My work helps identify infections in NICU infants faster, enabling earlier intervention and potentially reducing ICU mortality rates."),
           p("By visualizing key clinical variables and optimizing model hyperparameters, it supports more informed and timely medical decision-making by my model."),
           p("Github Link: https://github.com/ZhuohanChi/Rshiny")
    )
  )
)
