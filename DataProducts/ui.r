## ui.R
require(rCharts)

shinyUI(#headerPanel("rCharts: Interactive mtcars Chart"),
  navbarPage(
    "mtcars Analysis",
    tabPanel("Info",
             includeHTML("info.html")),
    tabPanel("Dataset",
             sidebarLayout(
               sidebarPanel(
                 checkboxGroupInput(
                   'show_vars', 'mtcar columns selection:', names(cbind(vehicle = rownames(mtcars), mtcars)),
                   selected = names(cbind(vehicle = rownames(mtcars), mtcars))
                 ),
                 helpText(
                   'Select the mtcars variables above to display the dataset columns in the 
                    main panel tables.  You can sort the dataset columns by clicking
                    on the column heading, or search for values in the filter boxes 
                   at the bottom of the data tables.'
                 )
                 ),
               mainPanel(dataTableOutput("table_mtcar"))
               
                 )),
    tabPanel("Correlation",
             sidebarLayout(
               # tabPanel("mtcars", dataTableOutput("mytable2")),
               
               sidebarPanel(
                 h4("Select mtcars variables to view correlation chart"),
                 selectInput(
                   inputId = "x",
                   label = "Choose X",
                   choices = names(mtcars),
                   selected = "mpg"
                 ),
                 selectInput(
                   inputId = "y",
                   label = "Choose Y",
                   choices = names(mtcars),
                   selected = "hp"
                 ),
                 helpText(
                   'Choose an X and Y variable from the available mtcars dataset to 
                    display their correlation chart in the main panel.'
                 )
                 ),
               mainPanel(
                 h4("Correlation Results"),
                 htmlOutput("corrText"),
                 showOutput("corrPlot", "polycharts")
               )
                 )),
    tabPanel("Regression",
             sidebarLayout(
               sidebarPanel(
                 selectInput(
                   inputId = "dep_var",
                   label = "Choice Dependant Variable",
                   choices = names(mtcars),
                   selected = "mpg"
                 ),
                 checkboxGroupInput(
                   "reg_vars", 'Choose Predicters', names(mtcars),
                   selected = 'hp'),
                 actionButton("btn_reg", "Calculate Regression"),
                 helpText(
                   'Select an mtcars dependant variable as the predictor value,
                   then choose from the remaining independant variables.  Click the 
                   Calculate button to show the Adjusted R-Square value for you model.
                   A sample Adjusted R-Squared is displayed which was calculated using 
                   a Step Model for the best fit.  See if you can choice the sample
                   variables to reproduce the Adjusted R-Squared shown.'
                 )
#                 actionButton("btn_reg_answer", "Show Answer?")
               ),
               mainPanel(
                 h4("Regression Results"),
                 h5("The adjusted R-squared using the Step model for predicting mpg is:"),
                 strong(textOutput("ar2_step_model")),
                 br(),
                 h5("Your selected formula is;"),
                 textOutput("sel_vars"),
                 h5("Which yeilds the following R-Squared results:"),
                 strong(textOutput("reg_ar2"))
#                  br(),
#                  textOutput("reg_answer")
               )
             )
             )
#     tabPanel("Prediction",
#              sidebarLayout(
#                sidebarPanel(
#                  helpText(
#                    'For the diamonds data, we can select variables to show in the table;
#                    for the mtcars example, we use bSortClasses = TRUE so that sorted
#                    columns are colored since they have special CSS classes attached;
#                    for the iris data, we customize the length menu so we can display 5
#                    rows per page.'
#                  )
#                ),
#                mainPanel(
#                  h4("Prediction Results")
#                )
#              )
#     )
    ))