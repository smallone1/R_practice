#install.packages("devtools")
library(devtools)
#install
library(Rfacebook)

token <- "EAACEdEose0cBALfwBwkZB7sdpjAdpCiZBgaOItZBMJqUrebWUpfhzMAQM4cMSY4mD84HtMNRGIcZB1uQgGtzdAZBdiXwUv6Sc8ZCgmgF0fbtHh7ciuJaZCyOXzvTQmqevBZBpymimawA9ZB2zG9WnDULGeZBW8qvfDSX9cLWO4yPpIvAZDZD"
me = getUsers("me",token,private_info = TRUE)
my_friends <- getFriends(token =token, simplify = TRUE )

for (i in 1:10)
{
  user = getUsers(my_friends$id[i],token,private_info = TRUE)
  print(user)
}