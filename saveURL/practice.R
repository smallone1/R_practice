rm(list=ls(all=TRUE))
library(XML)
library(bitops)
library(RCurl)
library(httr)

orgURL = 'http://taqm.epa.gov.tw/taqm/tw/'
#orgURL = 'https://www.ptt.cc/bbs/StupidClown/index.html'

##startPage = 500
##endPage = 501
alldata = data.frame()
for( i in startPage:endPage)
{
  pttURL <- paste(orgURL, i, '.html', sep='')
  urlExists = url.exists(pttURL)
  
  if(urlExists)
  {
    html = getURL(pttURL, ssl.verifypeer = FALSE)
    xml = htmlParse(html, encoding ='utf-8')
    title = xpathSApply(xml, "//div[@class='title']/a//text()", xmlValue)
    author = xpathSApply(xml, "//div[@class='author']", xmlValue)
    path = xpathSApply(xml, "//div[@class='title']/a//@href")
    date = xpathSApply(xml, "//div[@class='date']", xmlValue)
    response = xpathSApply(xml, "//div[@class='nrec']", xmlValue)
    tempdata = data.frame(title, author, path, date, response)
  }
  alldata = rbind(alldata, tempdata)
}

allDate = levels(alldata$date)
alldata$date
allDate

res = hist(as.numeric(alldata$date), nclass=length(allDate), axes=F) 
axis(1, at=1:length(allDate), labels=allDate)
axis(2, at=1:max(res$counts), labels=1:max(res$counts))

write.csv(alldata,"alldata.csv")