rm(list=ls(all=TRUE))
library(XML)
library(bitops)
library(RCurl)
library(httr)
URL = 'http://210.69.61.217/pxweb2007-tp/Dialog/Saveshow.asp'
#r <- POST("http://210.69.61.217/pxweb2007-tp/Dialog/Saveshow.asp")
#r
r <- POST("http://210.69.61.217/pxweb2007-tp/dialog/statfile9.asp")
r
