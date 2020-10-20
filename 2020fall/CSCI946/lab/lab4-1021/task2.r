library(arulesViz)
plot(rules, measure=c("support", "confidence"), shading="lift", interactive=FALSE)

confidentRules<-rules[quality(rules)$confidence>0.9]
plot(confidentRules,method="matrix",measure=c("lift","confidence"))

highLiftRules<-head(sort(rules,by="lift"),5)
plot(highLiftRules,method="graph",control=list(type="items"))