
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library('e1071')
source('main_prepareData.R')

shinyUI(navbarPage("店面租金與附近機能之研究",
                   tabPanel("迴歸",
                            sidebarLayout(
                              sidebarPanel(
                                checkboxGroupInput("Retailers", label=h2("影響變數"),
                                                   choices=list("行政區"=4,
                                                                "Starbucks"=9,
                                                                "Cosmed"=10,
                                                                "PostOffice"=11,
                                                                "MRT"=12),
                                                   selected = c(4,9:12)),
                                actionButton("SelectAll", label = "SelectAll"),
                                actionButton("DelAll", label = "DelAll")),
                              mainPanel(
                                plotOutput("regression"),
                                dataTableOutput("RentRegression")  
                              )
                              
                            )
                   )
                   ,tabPanel("使用SVM模型估店面租金",
                            sidebarLayout(
                              sidebarPanel(
                                sliderInput("degree", "degree：",
                                            min = 0,
                                            max = 10,
                                            value = 1,step=1),
                                sliderInput("gamma",
                                            "gamma：",
                                            min = 0.01,
                                            max = 1,
                                            value = 0.1,step=0.01),
                                sliderInput("cost",
                                            "cost:",
                                            min = 1,
                                            max = 10,
                                            value = 1,step=1)),
                              mainPanel(
                                plotOutput("svmResult")
                              )
                            )
)))
