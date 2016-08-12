rm(list=ls(all=TRUE))
library(XML)
library(bitops)
library(RCurl)
library(NLP)
library(httr)

tier1_url <- "http://www.319papago.idv.tw/lifeinfo/life-index.html"
urlExists = url.exists(tier1_url)

#//*[@id="left-column"]/div[3]/table[2]/tbody/tr[1]/td/div/a
Sys.setlocale("LC_ALL","cht")

if(urlExists)
{
  html = getURL(tier1_url, ssl.verifypeer = FALSE)
  xml = htmlParse(html,encoding = 'utf-8')
  title=xpathSApply(xml,"
//table[2]/tbody/tr[1]/td/div/a") #7/11,全家,萊爾富,OK
  downloadPath_1 = xpathSApply(xml,"
//*/div[3]/table[2]/tbody/tr[1]/td/div/a/@href")
  downloadPath_1
  
}
