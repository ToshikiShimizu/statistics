sv <- numeric(length=10000)
uv <- numeric(length=10000)

for(i in 1:10000){
  s <- rnorm(n=10, mean=50, sd=10)
  sv[i] <- mean((s-mean(s))^2)
  uv[i] <- var(s)
}

