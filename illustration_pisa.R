library("readxl")
library(ggplot2)
library(gridExtra)
library(causal.decomp)


setwd("U:/Educational disparity")

#Read data
data <- read_excel("dat1.xls")
data <- data.frame(data)
data1 <- na.omit(data)
data$racesex <- as.factor(data$racesex)
data[,c("math", "xses", "otl", "escs")] <- scale(data[,c("math", "xses", "otl", "escs")], scale = TRUE)
data$lang <- relevel(as.factor(data$lang), ref = "313")

#racesex 0: White male, 1: White female, 2: Black male, 3: Black female, 4: Hispanic male, 5: Hispanic female, 6: Asian male, 7: Asian female
#outcome: math score (math)
#mediator: school SES (xses)
#baseline covariate: age
#intermediate confounder: student SES (escs)

# intervention 1: school SES
fit.m1 <- lm(xses ~ racesex + lang, data = data)
fit.y1 <- lm(math ~ racesex + xses + racesex*xses + escs + lang, data = data)
summary(fit.y1)
coef(fit.y1)[9]
res.1a1 <- smi( fit.m = fit.m1,
               fit.y = fit.y1, sims = 1000, cluster=data$schoolID,
               covariates = c("lang"), treat = "racesex")

round(res.1a1$result,2)

# intervention 2: OTL
fit.m2 <- lm(otl ~ racesex + lang, data = data)
fit.y2 <- lm(math ~ racesex + otl + racesex*otl + escs + lang + 
             xses + propblck  + city  + proplang +  tracking   +abgrp  +       
            schtype +   propcert   + grade+ 
             mathintfc  + matwketh   +  repeat1   +  outhours  +  subnorm, data = data)
summary(fit.y2)
res.1b1 <- smi( fit.m = fit.m2,
                 fit.y = fit.y2, sims = 1000, cluster=data$schoolID,
                 covariates = c("lang"), treat = "racesex")

round(res.1b1$result,2)

# Sensitivity analysis for xses
sensRes2 <- sensitivity(boot.res = res.1a1, fit.m = fit.m1, fit.y = fit.y1,mediator="xses", 
                       covariates = c("lang"), treat = "racesex",sel.lev.treat = 2, max.rsq = 0.3)
sensRes3 <- sensitivity(boot.res = res.1a1, fit.m = fit.m1, fit.y = fit.y1,mediator="xses", 
                       covariates = c("lang"), treat = "racesex",sel.lev.treat = 3, max.rsq = 0.3)
sensRes4 <- sensitivity(boot.res = res.1a1, fit.m = fit.m1, fit.y = fit.y1,mediator="xses", 
                        covariates = c("lang"), treat = "racesex",sel.lev.treat = 4, max.rsq = 0.3)
sensRes5 <- sensitivity(boot.res = res.1a1, fit.m = fit.m1, fit.y = fit.y1,mediator="xses", 
                        covariates = c("lang"), treat = "racesex",sel.lev.treat = 5, max.rsq = 0.3)
names(sensRes)
sensRes
sensRes$RV_red       
sensRes$RV_red_alpha # computational estimate = 0.1212143
sensRes$RV_rem       # 0.08611574
sensRes$RV_rem_alpha # computational estimate = 0.0847163

# Create sensitivity contour plots
plot(sensRes2)
plot(sensRes3)
plot(sensRes4)
plot(sensRes5)

# Sensitivity analysis for otl
otl2 <- sensitivity(boot.res = res.1b1, fit.m = fit.m2, fit.y = fit.y2,mediator="otl", 
                        covariates = c("lang"), treat = "racesex",sel.lev.treat = 2, max.rsq = 0.3)
otl4 <- sensitivity(boot.res = res.1b1, fit.m = fit.m2, fit.y = fit.y2,mediator="otl", 
                        covariates = c("lang"), treat = "racesex",sel.lev.treat = 4, max.rsq = 0.3)
otl6 <- sensitivity(boot.res = res.1b1, fit.m = fit.m2, fit.y = fit.y2,mediator="otl", 
                        covariates = c("lang"), treat = "racesex",sel.lev.treat = 6, max.rsq = 0.3)
otl7 <- sensitivity(boot.res = res.1b1, fit.m = fit.m2, fit.y = fit.y2,mediator="otl", 
                        covariates = c("lang"), treat = "racesex",sel.lev.treat = 7, max.rsq = 0.3)
plot(otl2)
plot(otl4)
plot(otl6)
plot(otl7)
