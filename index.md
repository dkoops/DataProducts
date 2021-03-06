---
title       : Data Products Assignment
subtitle    : mtcars Analysis
author      : dkoops
job         : student
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---

## Welcome to mtcars Analysis shinyapp.

This shinyapp was created perform some basic analysis on the mtcars dataset.  The application is made of three tabs which illustrate three basic technics.

1. Review the dataset
2. Check variable correlation
3. Preform regression analysis

The app can be found [here](https://dkoops.shinyapps.io/ShinyApp/)

--- .class #id 

## Exploring mtcars Dataset

The Dataset tab allows you to

1. Select variables to view
2. Sort columns by clicking column heading
3. Filter rows by using filter boxes at bottom of table
4. Set number of rows to view per page

---

## Review Variable Correlation

The Correlation tab allows you to select both an X and Y variable which is used to render a correlation value and plot.

<iframe src=' assets/fig/unnamed-chunk-1-1.html ' scrolling='no' frameBorder='0' seamless class='rChart polycharts ' id=iframe- corrPlot ></iframe> <style>iframe.rChart{ width: 100%; height: 400px;}</style>

```
Code failed to render chart
```

---

## Test Regression Analysis

The Regression tab allows you to select a dependant variable and choose the predicters you would like to use in your regression analysis.  The resulting Adjusted R-Squared value is shown.

The tab also contains a Step Method lm model for predicting mpg.  It showns the Adjusted R-Squared value for this model.  You can attempt to choose the right predicters for mpg and match the Adgusted R-Squared shown.
