#AllData <- read.csv('rent_dist_temp.csv')
#AllData <- AllData[!is.na(AllData[,8]),]

AllData <- read.csv('rent_dist.csv')
#刪除NA那筆資料
AllData <- AllData[!is.na(AllData[,8]),]


