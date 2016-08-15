rm(list=ls(all=TRUE))
library(xml2)
library(stringr)
library(XML)
library(bitops)
library(RCurl)
library(NLP)
library(httr)
library(readr)

#背包客棧
#part1_url <-"http://www.backpackers.com.tw/forum/forumdisplay.php?f=121" 
#第二頁以後
#part2_url <- "&order=desc&page="
#放結果字串
#result<-""

for(i in 1:1){#starpage:endpage
  #第一頁網址
  #if(i==1){
  #  testurl <- part1_url
  #}
  #第二頁以後
  #if(i>=2){
  #  num <- paste("-",i,sep="")
  #  testurl <- paste(part1_url,part2_url,i,sep="")
  #}
  #url <- testurl
  #html = getURL(url, ssl.verifypeer = FALSE, encoding='UTF-8')
  html = read_file("back.txt",locale = default_locale())
  xml = htmlParse("html",encoding = 'UTF-8')
  title=xpathSApply(xml,"
//table[@id='threadslist']//td[@class='alt1']/@title") #抓PO文的文章

  result<-paste(title,sep='') #串一起做文字雲
  
}
#file_name <- paste("./temp/",paste("backPakerPage_","",sep=""),".txt",sep="")
#write.csv(result,file=file_name)

#orgPath = "./temp"
#text = Corpus(DirSource(orgPath), list(language = NA))
#text <- tm_map(text, removePunctuation)
#text <- tm_map(text, removeNumbers)
# text <- tm_map(text, function(word)
# { gsub("[A-Za-z0-9]", "", word) })

# 進行中文斷詞
# mixseg = worker()
# mat <- matrix( unlist(text) )
# totalSegment = data.frame()
# for( j in 1:length(mat) )
# {
#   for( i in 1:length(mat[j,]) )
#   {
#     result = segment(as.character(mat[j,i]), jiebar=mixseg)
#   }
#   totalSegment = rbind(totalSegment, data.frame(result))
# }
# 
# # define text array that you want
# # delete text length < 2
# delidx = which( nchar(as.vector(totalSegment[,1])) < 2 )
# countText = totalSegment[-delidx,]
# countResult = count(countText)[,1]
# countFreq = count(countText)[,2] / sum(count(countText)[,2])
# wordcloud(countResult, countFreq, min.freq = 1, random.order = F, ordered.colors = T, 
#           colors = rainbow(length(countResult)))