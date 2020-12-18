mean <- numeric(length(5000))
for(i in 1:5000){
  s <- rnorm(n=20,mean=50,sd=10)
  mean[i] <- mean(s)
}

