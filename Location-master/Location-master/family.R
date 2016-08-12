rm(list=ls(all=TRUE))
library(XML)
library(bitops)
library(RCurl)
library(NLP)
library(httr)
library(readr)

#網址位置不同且檔案格式不同
Sys.setlocale("LC_ALL", "cht")
govURL1 = 'http://www.319papago.idv.tw/lifeinfo/family/family-'
govURL2 = '.html'

startPage = 100
endPage = 999

temp = startPage:endPage
#strid = sprintf("%03d", temp)
alldata = data.frame() 

for (i in startPage:endPage)
{
  govURL = paste(govURL1,i,govURL2,sep = '') 
  urlExists = url.exists(govURL)
  if(urlExists)
  {
    # If encoding error , than fetch from local files
    # html = mystring <- read_file("star.txt",locale = default_locale())
    html = getURL(govURL, ssl.verifypeer = FALSE,.encoding = "big5")
    xml = htmlParse(html, encoding ='utf-8')
    
    title = xpathSApply(xml, "//td[@height='33'][2]//text()", xmlValue)
    phone = xpathSApply(xml, "//td[@height='33'][3]//text()",xmlValue)
    addre = xpathSApply(xml, "//td[@height='33'][4]//text()",xmlValue)
    tempdata = data.frame(title,phone,addre) 
  }
  
  alldata = rbind(alldata, tempdata)
  
}

# write data to csv file
write.csv(alldata, 'family.csv')