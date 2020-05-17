m = matrix(runif(9000),3000,3)
m = m*256
write.table(m,file="./colorsInput.csv",quote=F,col.names=F,row.names=F,sep=",")

