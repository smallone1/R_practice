rm(list=ls(all=TRUE))
library(XML)
library(bitops)
library(RCurl)
library(NLP)
library(httr)
library(readr)


Sys.setlocale("LC_ALL", "cht")
#rentURL1 = 'https://store.591.com.tw/'
#rentURL2 ='index.php?firstRow='
#rentURL3 = #(頁面-1)*20
#rentURL4 ='&totalRows=6347&storeType=1&module=house&action=rentSale'
#rentURL5 = '.html'

#startPage = 1
#endPage = 1

#temp = startPage:endPage
alldata = data.frame() 

#for (i in startPage:endPage){ 
  #if(i==1){
    rentURL <- 'https://rent.591.com.tw/house-rentSale-1.html'
    #paste(rentURL1,rentURL5,sep="")
  #}
  #第二頁以後
  #if(i>=2){
  #  num <- paste("-",(i-1)*20,sep="")
  #  rentURL <- paste(rentURL1,rentURL2,i,rentURL4,rentURL5,sep="")
  #}
  
  urlExists = url.exists(rentURL)
  if(urlExists)  {
    # If encoding error , than fetch from local files
    # html = mystring <- read_file("star.txt",locale = default_locale())
    html = getURL(rentURL, ssl.verifypeer = FALSE,.encoding = "big5")
    xml = htmlParse(html, encoding ='utf-8')
    
    #591店面租賃資訊
    title = xpathSApply(xml, "//div[@id='shContent']//a/strong", xmlValue) #店面抬頭
    
    #各店面URL(抓座標)
    detailURL=xpathSApply(xml, "//div[@id='shContent']//p[@class='title']//a/@href")
    
    #各店面坪數
    size=xpathSApply(xml, "//*[@id='shContent']/div/ul/li[2]/text()", xmlValue)
    
    #各店面租金
    rentFare=xpathSApply(xml, "//*[@id='shContent']/div/ul/li[3]/strong/text()", xmlValue)
    
    #phone = xpathSApply(xml, "//td[@height='33'][2]//text()",xmlValue)
    #addre = xpathSApply(xml, "//td[@height='33'][3]//text()",xmlValue)
    tempdata = data.frame(title,detailURL,size,rentFare )
  }
  
  alldata = rbind(alldata, tempdata)
  
#}
  
# write data to csv file
# write.csv(alldata, 'rentURL.csv')