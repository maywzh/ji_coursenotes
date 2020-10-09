sales <- read.csv("../yearly_sales.csv")
results <- lm(sales$sales_total ~ sales$num_of_orders)

results

summary(results)

hist(results$residuals, breaks=800)