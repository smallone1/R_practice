library("quantmod")
getFX("EUR/TWD", form ="2015-01-01")

write.zoo(EURTWD,"EUR.csv",index.name="date",sep=",")