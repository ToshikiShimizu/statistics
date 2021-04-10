library(plink)

paramT <- read.csv('../RIRT実習データ/chap14/paramT.csv')
head(paramT, 5)

paramF <- read.csv('../RIRT実習データ/chap14/paramF.csv')
head(paramF, 5)

pm <- list(paramT, paramF)

pm

pretheta<- read.csv('../RIRT実習データ/chap14/paramtheta.csv')
thetaT <- pretheta[,1]
thetaF <- pretheta[,2]

theta <- list(thetaT, thetaF) 

comx <- data.frame("T"=6:20, "F"=1:15)

JT <- 20
JF <- 20

(rescat <- list(rep(2,JT), rep(2,JF)))

pmT <- as.poly.mod(n=JT, model="drm", items=1:JT)
pmF <- as.poly.mod(n=JF, model="drm", items=1:JF)
p.mod <- list(pmF, pmT)

res <- as.irt.pars(x=pm, common = comx, cat = rescat, poly.mod = p.mod)
out <- plink(x=res, common=comx, ability=theta, rescale="MS", base.grp=1)

summary(out)

link.pars(out)

equateparam <- cbind(link.pars(out)[[2]],paramF)

colnames(equateparam) <- c(paste0("等化後",c("a","b","c")), paste0("等化前",c("a","b","c")))
head(equateparam)

link.ability(out)

eqtheta <- cbind(link.ability(out)[[2]], thetaF)
colnames(eqtheta) <- c("等化後 theta", "等化前 theta")
head(eqtheta)

paramT <- read.csv('../RIRT実習データ/chap14/pgrmT.csv')
paramT2 <- read.csv('../RIRT実習データ/chap14/pgrmT2.csv')
paramF <- read.csv('../RIRT実習データ/chap14/pgrmF.csv')
paramF2 <- read.csv('../RIRT実習データ/chap14/pgrmF2.csv')
pm <- list(paramT, paramF)
pm2 <- list(paramT2, paramF2)

comx <- data.frame("T"=6:20, "F"=1:15)
JT <- 20
JF <- 20

rescat <- list(rep(4,JT), rep(4,JF))

pmT <- as.poly.mod(n=JT, model="grm", items=1:JT)
pmF <- as.poly.mod(n=JF, model="grm", items=1:JF)

res <- as.irt.pars(x=pm, common=comx, cat=rescat, poly.mod=list(pmT, pmF), location=FALSE)

out <- plink(res, rescale="MS", base.grp=1)

summary(out)

link.pars(out)

equatetest = read.csv("../RIRT実習データ/chap14/equatetest.csv")

head(equatetest)
N = 100

M <- cbind(5,25,45,65,85)
ls_rescale <- cbind("MM","MS","HB","SL")
for (m in M){
  for (rescale in ls_rescale){
  print(m)
  print(rescale)
  paramT = equatetest[,1:2]
  paramF = equatetest[,3:4]
  pm = list(paramT, paramF)
  comx <- data.frame("T"=1:m, "F"=1:m)
  JT <- N
  JF <- N

  rescat <- list(rep(2,JT), rep(2,JF))

  pmT <- as.poly.mod(n=JT, model="drm")
  pmF <- as.poly.mod(n=JF, model="drm")
  p.mod <- list(pmT, pmF)

  res <- as.irt.pars(x=pm, common=comx, cat=rescat, poly.mod=p.mod)
  out <- plink(x=res, common=comx, ability=theta, rescale=rescale, base.grp=1)
  summary(out)

  }
}



