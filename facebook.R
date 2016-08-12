install.packages("devtools")
library(devtools)
#install_github("Rfacebook", "smallone1/Rfacebook", subdir="Rfacebook")
library(Rfacebook)

token<-"EAACEdEose0cBAH74u4dg32tqEVp7ZCxOxM6EK69DwnseqUhbpj3ugZBoSrXkz6lHtAY0bEZABSA5YJgmOrGuHINqJuKp2AKjPTgphwJawApUHVxMZAbllVVXLTHb8vZBqhaEUYSEuYg8kUrZBmZBM8ZAUeeIQkpISiZAkthq2RkTNrAZDZD"
me = getUsers("me",token,private_info = TRUE)
my_friends <- getFriends(token =token, simplify = TRUE )

for (i in 1:10)
{
  user = getUsers(my_friends$id[i],token,private_info = TRUE)
  print(user,locale)
}
