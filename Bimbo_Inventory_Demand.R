setwd("C:/Users/BIJ/Dropbox/EPSON/RH/Programação/DSA/Big Data Analytics com R e Microsoft Azure Machine Learning/Análise Demanda de Estoque com base em Vendas")
getwd()

library(data.table)
library(tidyr)
library(dplyr)
library(ggplot2)
library(corrplot)
library(viridis) 

df <- fread("train.csv", stringsAsFactors = F, sep = ",", header =T)

# 1.4 Checking Dataset
dim(df)
head(df)
View(df)
str(df)
summary(df)

week <- unique(df$Semana)
str(week)

Ag_ID <- unique(df$Agencia_ID)
str(Ag_ID)

Ch_ID <- unique(df$Canal_ID)
str(Ch_ID)

Rt_SAK <- unique(df$Ruta_SAK)
str(Rt_SAK)

Cl_ID <- unique(df$Cliente_ID)
str(Cl_ID)

Prod_ID <- unique(df$Producto_ID)
str(Prod_ID)

Dem_un_eq <- unique(df$Demanda_uni_equil)
str(Dem_un_eq)


hist(df$Semana, col = viridis(10))
hist(df$Agencia_ID, col=viridis(10))
hist(df$Canal_ID, col=viridis(10))
hist(df$Ruta_SAK, col=viridis(10))
hist(df$Cliente_ID, col=viridis(10))
hist(df$Producto_ID, col=viridis(10))
hist(df$Venta_uni_hoy, col=viridis(10))
hist(df$Venta_hoy, col=viridis(10))
hist(df$Dev_uni_proxima, col=viridis(10))
hist(df$Dev_proxima, col=viridis(10))
hist(df$Demanda_uni_equil, col=viridis(10))



cor(df)
cor = cor(df)
corrplot(cor, is.corr = FALSE, method = "square", col = viridis(100))

indexes <- sample(1:nrow(df), size = 0.7 * nrow(df))
df_train <- df[indexes,]
df_test <- df[-indexes,]

#This code is too heavy
#ggplot(df, aes(df$Demanda_uni_equil, df$Venta_uni_hoy, colour = df$Semana)) +
#  geom_point()

dim(df_train)
dim(df_test)

?lm
model_v1 <- lm(df_train$Demanda_uni_equil ~ df_train$Venta_uni_hoy)
summary(model_v1)

str(model_v1)
