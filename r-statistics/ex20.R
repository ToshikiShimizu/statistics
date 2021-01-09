t値<-numeric(length=100000)
有意回数<-0
for(i in 1:10000){
  第1群<-rnorm(n=10,mean=0,sd=1)
  第2群<-rnorm(n=10,mean=0.5,sd=1)
  検定結果<-t.test(第1群,第2群,var.equal=TRUE)
  t値[i]<-検定結果[[1]]
  有意回数 <- 有意回数+ifelse(検定結果[[3]]<0.05,1,0)
}