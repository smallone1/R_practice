library(reshape2)
library(ggplot2)

index = c("EUR", "GBP", "FXR", "USD", "GOLD")
endid = 2

price = data.frame()
priceSum = c()
for( i in 1:2 )
{
  filename = paste(index[i],".csv",sep="")
  temp = read.csv(filename)
  
  if( length(price) == 0 )
  {
    price = rbind( price, temp )
  }
  else
  {
    price = data.frame( price, temp[,2] )
  }
  names(price)[i+1] <- index[i]
  
  priceSum = rbind( priceSum, summary(temp[,2]) )
}

mdf <- melt(price, id.vars="date", value.name="Price", variable.name="FX")
at = seq(1, length(price[,1]), by=80)

ggplot(data=mdf, aes(x=date, y=Price, group=FX, colour=FX)) +
  geom_line() +
  geom_point( size=1, shape=1, fill="white" ) +
  scale_x_discrete(at, mdf$date[at]) +
  xlab("Date")

