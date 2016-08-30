#AllData <- read.csv('rent_dist_temp.csv')
#AllData <- AllData[!is.na(AllData[,8]),]

AllData <- read.csv('rent_dist.csv')

#刪除NA那筆資料
#AllData <- AllData[!is.na(AllData[,10]),]

#刪除電洽
#AllData <- AllData[!(AllData[,AllData$square]=='電洽'),]

#加一個每坪租金多少的欄位
#AllData$rentFare <- AllData$price / AllData$square


# regression y = b1 x1 + b2 x2 + b3 x3 + b4 x4

# 隨機抽樣9:1
ind <- sample(2, nrow(AllData), replace=TRUE, prob=c(0.9,0.1))
ind
#table(ind)

trainData <- AllData[ind==1,]
testData <- AllData[ind==2,]
oneV = rep(1, nrow(trainData))


#### TRAIN ####
# INPUT>>>>>欄位由USER選擇(1:Starbucks,2:cosmed,3:postOffice,4:MRT)
X = as.matrix( cbind(oneV, AllData[ind==1,c(11)]) )
# OUTPUT>>>>房租每坪租金
Y = as.matrix( AllData[ind==1, 13] )
Beta = solve(t(X) %*% X) %*% t(X) %*% Y
#plot(1:nrow(trainData), X%*%Beta, type="p", col="red")

#### TEST ####
oneV = rep(1, nrow(testData))
Xpred = as.matrix( cbind(oneV, AllData[ind==2,c(11)]) )
# predict
#plot(1:nrow(testData), Xpred%*%Beta, type="p", col="red",ylab="每坪租金(元)",xlab="測試資料",sub="紅：預測；藍：測試資料正解")
# real
#lines(1:nrow(testData), AllData[ind==2,13],type="p", col="blue")
