第1種の誤り <- 0
for (i in 1:100000){
群A <- rnorm(n=10)
群B <- rnorm(n=10)
群C <- rnorm(n=10)
検定1 <- t.test(群A,群B,var.equal=TRUE)
検定2 <- t.test(群B,群C,var.equal=TRUE)
検定3 <- t.test(群C,群A,var.equal=TRUE)
ifelse(検定1$p.value<0.05 | 検定2$p.value<0.05 | 検定3$p.value<0.05,"誤り", "正しい" )
第1種の誤り <- 第1種の誤り +  ifelse(検定1$p.value<0.05 | 検定2$p.value<0.05 | 検定3$p.value<0.05,1, 0 )
}
第1種の誤り