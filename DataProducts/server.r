## server.r
require(rCharts)
require(ggplot2)

## Regression
fmtcarsFactors <- function(){
  mtcars$cyl <- as.factor(mtcars$cyl)
  mtcars$vs <- as.factor(mtcars$vs)
  mtcars$am <- as.factor(mtcars$am)
  mtcars$gear <- as.factor(mtcars$gear)
  mtcars$carb <- as.factor(mtcars$carb)
  return(mtcars)
}

mtcarsFactors <- fmtcarsFactors()

# Create Step Model
fmtcarsReg <- function(predicter){
  flm <- as.formula(paste(predicter, " ~ ."))
  lmAll <- lm(flm, data=mtcars)
  stepModel <- step( lmAll, k=log(nrow(mtcars)) )
  return(stepModel)
}

#mtcarsSumReg <<- summary(fmtcarsReg("mpg"))


shinyServer(function(input, output, clientData, session) {
 
  #############################
  # Navbar - Tab 1 - Info
  #############################
  
  #############################
  # Navbar - Tab 2 - Dataset
  #############################
  # Display mtcars dataset
  dsMtcars <- reactive({
    cbind(vehicle = rownames(mtcars), mtcars)
  })
  
  output$table_mtcar = renderDataTable({
    ldataset <- dsMtcars()
    ldataset[, input$show_vars, drop = FALSE]}, options = list(orderClasses = TRUE))
    #dsMtcars()}, options = list(orderClasses = TRUE))
  
  #############################
  # Navbar - Tab 3 - Correlation
  #############################
  # Create formula
  mtform <- reactive({
    as.formula(paste(input$x, input$y, sep='~'))
  })
  
  # Text lm formula
  txtFormula <- reactive({
    lformula <- mtform()
    deparse(lformula)
  })
  
  # Calculate Correlation Value
  corValue <- reactive({
    x <- input$x
    y <- input$y
    round(cor(mtcars[x], mtcars[y]), 6)
  })
  
  # Correlation Value
  output$corrText <- renderUI({
    str1 <- paste("The formula for the variables you have selected is:", txtFormula())
    str2 <- paste("This yields a correlation of", as.character(corValue()))
    HTML(paste(str1, str2, sep = '<br/>'))
    #HTML(paste(str1, str2, sep = '<br/>'))
  })
  
  # Render Chart
  output$corrPlot <- renderChart({
    lformula <- mtform()
    dat = fortify(lm(lformula, data = mtcars))
    names(dat) = gsub('\\.', '_', names(dat))
    p1 <- rPlot(lformula, data = dat, type = 'point')
    p1$layer(y = '_fitted', copy_layer = T, type = 'line',
             color = list(const = 'red'),
             tooltip = "function(item){return item._fitted}")
    p1$addParams(dom = 'corrPlot')
    return(p1)
  })

  #############################
  # Navbar - Tab 4 - Regression
  #############################

  
  #mtcarsReg <- fmtcarsReg()
  #mtcarsSumReg <<- 0
  
  # Update Predicter choices based on choosen dependant var
  observe({
    searchResult <- reactive({setdiff(names(mtcars), input$dep_var)})
    
    mtcarsSumReg <<- summary(fmtcarsReg(input$dep_var))
    
    updateCheckboxGroupInput(session, "reg_vars",
                             'Choose Predicters',
                             searchResult()
                             )
  })
  
  # Show Step model R-Squared
  output$ar2_step_model = renderText({mtcarsSumReg$adj.r.squared})
  
  # Show entered formula
  lFormula <- function(dvars, ivars){
    vars <- paste(ivars, collapse = " ")
    vars <- gsub(" ", " + ", vars)
    paste(dvars, vars, sep = " ~ ")
  }
  
  output$sel_vars = renderText({
      #dvars <- paste(input$reg_vars, collapse = " ")
      #dvars <- gsub(" ", " + ", dvars)
      #paste(input$dep_var, dvars, sep = " ~ ")
    lFormula(input$dep_var, input$reg_vars)
  })
  
  # Calculate R-Squared
  calc_reg <- eventReactive(input$btn_reg, {
    flm <- lFormula(input$dep_var, input$reg_vars)
    lmcalc <- lm(flm, data=mtcars)
    summary(lmcalc)$adj.r.squared
  })
  
  output$reg_ar2 <- renderText({calc_reg()})

  # Show answer
  reg_ans <- eventReactive(input$btn_reg_answer, {
    as.character(mtcarsSumReg$call[2])
  })
  
  output$reg_answer <- renderText({reg_ans})
  
  #############################
  # Navbar - Tab 5 - Prediction
  #############################
})
