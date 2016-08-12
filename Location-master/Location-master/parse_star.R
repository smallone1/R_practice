rm(list=ls(all=TRUE))
library(XML)
library(bitops)
library(RCurl)
library(NLP)
library(httr)
library(readr)


Sys.setlocale("LC_ALL", "cht")
govURL1 = 'http://www.319papago.idv.tw/lifeinfo/starbucks/starbucks-'
govURL2 = '.html'

startPage = 1
endPage = 22

temp = startPage:endPage
strid = sprintf("%02d", temp)
alldata = data.frame() 

for (i in startPage:endPage)
{
 govURL = paste(govURL1,strid[i],govURL2,sep = '') 
urlExists = url.exists(govURL)
if(urlExists)
{
# If encoding error , than fetch from local files
# html = mystring <- read_file("star.txt",locale = default_locale())
  html = getURL(govURL, ssl.verifypeer = FALSE,.encoding = "big5")
  xml = htmlParse(html, encoding ='utf-8')
  
  title = xpathSApply(xml, "//td[@height='33'][1]//text()", xmlValue)
  phone = xpathSApply(xml, "//td[@height='33'][2]//text()",xmlValue)
  addre = xpathSApply(xml, "//td[@height='33'][3]//text()",xmlValue)
  tempdata = data.frame(title[-1],phone,addre) 

}

alldata = rbind(alldata, tempdata)

}

# write data to csv file
write.csv(alldata, 'star.csv')