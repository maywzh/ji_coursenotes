m = read.table("ColorsResults.csv",header=F,sep=",")
nbRows <- 50
nbCols <- 50
output = matrix(nrow=nbRows,ncol=nbCols)
row <- 1
col <- 1

for (i in 1:(nbRows*nbCols)){
  output[row,col] = rgb(m[i,],max=256)
  col = col+1
  if (col==51){
     row=row+1
     col=1
  }
}

t = matrix(seq(1,nbRows*nbCols),nbRows,nbCols,byrow=T)
image(t,col=output,axes=F)



