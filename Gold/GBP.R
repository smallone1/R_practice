library("quantmod")
getFX("GBP/TWD", form ="2015-01-01")

write.zoo(GBPTWD,"GBP.csv",index.name="date",sep=",")