sales <- read.csv("../yearly_sales.csv")

sales$per_order <- sales$sales_total/sales$num_of_orders

write.table(sales, "sales_modified.txt", sep="\t", row.names=FALSE)

jpeg(file="./sales_hist.jpeg") #create a new jpeg file

hist(sales$num_of_orders)

dev.off()

save.image()

load(".RData")

