library(glpkAPI)
library(irtoys)

item <- read.csv('../RIRT実習データ/chap15/item_math.csv')
head(item)

(nj <- nrow(item))

ni <- 11
A <- matrix(0, nrow = ni, ncol = nj)
A[1,] <- 1
A[2,item$area==1] <- 1
A[3,item$area==2] <- 1
A[4,item$area==3] <- 1

A[5,c(30,60,90)] <- 1

A[6,1:3] <- c(2,-1,-1)

theta.m <- c(-2,-1,0,1,2)

ip <- cbind(item$a, item$b,0)
item.info <- iif(ip,theta.m)$f
dif(item.info)