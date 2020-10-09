sales <- read.csv("../yearly_sales.csv")

head(sales)

summary(sales)

plot(sales$num_of_orders, sales$sales_total, main="Number of Orders vs. Sales") 