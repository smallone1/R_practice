rm(list=ls(all=TRUE))
library(XML)
library(bitops)
library(RCurl)
library(httr)

orgURL1 = 'http://www.cbc.gov.tw/lp.asp?CtNode=645&CtUnit=308&BaseDSD=32&mp=1&nowPage='
orgURL2 = '&pagesize=50'
startPage = 1
endPage = 8
alldata = data.frame()
temp = startPage:endPage

for( i in startPage:endPage)
{
  usdURL <- paste(orgURL1, i, orgURL2, sep='')
  urlExists = url.exists(usdURL)
  
  if(urlExists)
  {
    html = getURL(usdURL, ssl.verifypeer = FALSE)
    xml = htmlParse(html, encoding ='utf-8')
    datetemp = xpathSApply(xml, "//td[1]", xmlValue)
    date = datetemp[-1]
    USDtemp = xpathSApply(xml, "//td[2]", xmlValue)
    USD = USDtemp[-1]
    tempdata = data.frame(date, USD)
  }
  alldata = rbind(alldata, tempdata)
}

write.csv(alldata,"USD.csv")