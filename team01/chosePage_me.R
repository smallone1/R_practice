library(xml2)
library(stringr)

chosePage <- function(starpage,endpage){
  Sys.setlocale("LC_ALL", "cht")
  
  part1_url <-"http://www.backpackers.com.tw/forum/forumdisplay.php?f=121" 
  #part3_url <- ".aspx"
  part4_url <- "&order=desc&page="
  for(i in starpage:endpage){
    if(i==1){
      testurl <- part1_url
    }
    if(i>=2){
      num <- paste("-",i,sep="")
      testurl <- paste(part1_url,part4_url,i,sep="")
    }
    url <- testurl
    doc <- read_html(url)
    titlexpath <- "//td[@class='alt1']//a"  #//td[@class='alt1']//a/@href
    title <- xml_text(xml_find_all(doc, titlexpath))              #title
    
    urlxpath <- "//*[@class='subject']//a"
    content_url <- xml_attrs(xml_find_all(doc, urlxpath))
    content_url <- gsub(pattern="[[:space:]]",replacement="",x= content_url)
    part_url <-"http://www.moneydj.com"
    content_url <- paste(part_url,content_url,sep="")            #content_url
    
    authorxpath <-"//*[@class='author']//a"
    author <- xml_text(xml_find_all(doc,authorxpath))           #author
    
    timexpath <- "//*[@ class='author']//em"
    time <- xml_text(xml_find_all(doc,timexpath))
    time <- gsub(pattern="[[:space:]]",replacement="",x= time)   #time
    time <- paste(substr(time,1,10),substr(time,11,nchar(time)),sep="_")
    
    rvxpath <- "//*[@ class='nums']"
    rv <- xml_text(xml_find_all(doc,rvxpath))                   #rv
    
    content=0
    scraping_time=0
    for(j in 1:length(content_url)){
      url <- content_url[j]
      doc <- read_html(url)
      contentxpath <-"//*[@id='firstpost']"
      contenttemp <- xml_text(xml_find_all(doc,contentxpath))
      content[j] <- gsub(pattern="[[:space:]]",replacement="",x= contenttemp)
      scraping_time[j] <- gsub(pattern="[[:space:]]",replacement="_",Sys.time())
      Sys.sleep(1)
      #print(i)
    }
    if(testurl=="http://www.moneydj.com/forum/showforum-8.aspx"){
      author<- author[-1] 
      time <- time[-1]   
      rv <- rv[-c(1,2)]      #First page will scrape the hot subject rv  so need if to control
    }
    if(testurl!="http://www.moneydj.com/forum/showforum-8.aspx"){
      rv <- rv[-1]   
    }
    
    response <- unlist(strsplit(rv,split="/"))[seq(1,length(unlist(strsplit(rv,split="/"))),by=2)]   
    viewcount <- unlist(strsplit(rv,split="/"))[seq(0,length(unlist(strsplit(rv,split="/"))),by=2)]
    
    title <- as.data.frame(title)
    author <- as.data.frame(author)
    time <- as.data.frame(time)
    content_url <- as.data.frame(content_url)
    content <- as.data.frame(content)
    scraping_time  <- as.data.frame(scraping_time)
    response <- as.data.frame(response)
    viewcount <- as.data.frame(viewcount)
    
    MoneyDJForum <- cbind(title,author,time,scraping_time,content_url,content,response,viewcount )
    file_name <- paste("./temp/",paste("newsPage_",i,sep=""),".txt",sep="")
    write.csv(MoneyDJForum,file=file_name)
  }
}

#chosePage(1,2) #input starpage & endpage