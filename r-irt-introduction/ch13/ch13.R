library(irtoys)
item <- read.csv('../RIRT実習データ/chap12/item_vocab.csv',fileEncoding = "SJIS")
x <- read.csv('../RIRT実習データ/chap12/data_vocab(sim).csv',fileEncoding = "SJIS")
head(item)
j <- 10
tgf(choices=x,key=item$KEY,item=j,main=paste0("項目",j), co=NA, label=TRUE)

out <- tia(choices=as.matrix(x),key=item$KEY)
ls(out)
out$testlevel
out$itemlevel
lapply(out$optionlevel,round,4)

u <- sco(choices = x, key = item$KEY, na.false = FALSE)
head(u)

ip <- est(resp=u,model='2PL',engine='icl',a.prior=FALSE, b.prior=FALSE, c.prior=FALSE,run.name='vocab_2PL')
