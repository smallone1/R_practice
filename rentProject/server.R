
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library('e1071')
source('main_prepareData.R')


shinyServer(function(input, output, session) {
  
  selAll <- observeEvent(input$SelectAll, {
    updateCheckboxGroupInput(session,"Retailers", selected=as.character(c(4,9:12)))
  })
  
  delALL <- observeEvent(input$DelAll, {
    updateCheckboxGroupInput(session,"Retailers", selected=c(""))
  })  
  
  
  output$regression <- renderPlot({
    #fetch the chosen Retailers
    Retailerselect_n <- as.numeric(input$Retailers)
    #divide into test data and train data
    ind <- sample(2, nrow(AllData), replace=TRUE, prob=c(0.9,0.1))
    ind
    trainData <- AllData[ind==1,]
    testData <- AllData[ind==2,]
    oneV = rep(1, nrow(trainData))
    
    #### TRAIN ####
    # INPUT>>>>>欄位由USER選擇(1:Starbucks,2:cosmed,3:postOffice,4:MRT)
    X = as.matrix( cbind(oneV, AllData[ind==1,Retailerselect_n]) )
    # OUTPUT>>>>房租每坪租金
    Y = as.matrix( AllData[ind==1, 13] )
    Beta = solve(t(X) %*% X) %*% t(X) %*% Y
    #plot(1:nrow(trainData), X%*%Beta, type="p", col="red")
    
    #### TEST ####
    oneV = rep(1, nrow(testData))
    Xpred = as.matrix( cbind(oneV, AllData[ind==2,Retailerselect_n]) )
    # predict
    plot(1:nrow(testData), Xpred%*%Beta, type="p", col="red",ylab="每坪租金(元)",xlab="測試資料",sub="紅：預測；藍：測試資料正解")
    # real
    lines(1:nrow(testData), AllData[ind==2,13],type="p", col="blue")
  })
  
  output$RentRegression <- renderDataTable({
    #fetch the chosen Retailers
    Retailerselect_n <- as.numeric(input$Retailers)
    subX = AllData[,Retailerselect_n]
    Y = AllData[,13]
    subData = data.frame(Y, subX)
    names(subData) = c("Rent", names(AllData[,Retailerselect_n]))
    testResult = summary(lm(Rent ~ ., data = subData ))
    print(testResult$coefficients)
  })
  
  # output$RetailersToRentFarePerSquare <- renderPlot({
  #   #Retailerselect <- as.vector(input$Retailers)
  #   Retailerselect_n <- as.numeric(input$Retailers)
  #   subRent <- data.frame(AllData$FarePerSquare, AllData[,Retailerselect_n])
  #   names(subRent) = c("rent", names(AllData[,Retailerselect_n]))
  #   lmresult <- with(subRent, lm(rent ~ .))
  #   plot(rentFare ~ ., data=subRent, main="",
  #        xlab="Retailers",
  #        ylab="rentFare")
  #   abline(lmresult, lwd=2)
  # })

  output$svmResult <- renderPlot({
    degree_user = as.numeric(input$degree)
    gamma_user = as.numeric(input$gamma)
    cost_user = as.numeric(input$cost)
    
    svm.model = svm( FarePerSquare ~ ., AllData[ind==1,], kernal='radial', type = 'eps-regression', cost = cost_user, gamma = gamma_user, degree = degree_user, epsilon = 0.001)
    svm.pred = predict(svm.model, AllData[ind==2,])

    plot(AllData[ind==2,13] , col="blue",ylab="每坪租金(元)",xlab="測試資料",sub="紅：預測；藍：測試資料正解")
    par(new=TRUE)
    plot(svm.pred, col="red",ylab="每坪租金(元)",xlab="測試資料",sub="紅：預測；藍：測試資料正解")
    #RMSE = mean( abs(TestData$label - svm.pred) / TestData$label )
  })
  
})
