mean <- numeric(length(10000))
median <- numeric(length(10000))
for(i in 1:10000){
  s <- rnorm(n=1000,mean=50,sd=10)
  mean[i] <- mean(s)
  median[i] <- median(s)
}

