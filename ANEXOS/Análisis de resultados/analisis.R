library(readxl)
library(quantmod)
Response_and_Wait_Cached <- read_excel("./Response and Wait Cached.xlsx",
                                       sheet = "Hoja2")
df <- data.frame(Response_and_Wait_Cached)
print(df)
boxplot(df$DB.Wait..ms., df$Cache.Wait..ms.,
        main = "Comparación de tiempo de espera BD y Caché",
        at = c(1,2),
        names = c("Base de Datos", "Caché"),
        las = 2,
        col = c("orange","yellow"),
        border = "brown",
        horizontal = TRUE,
        notch = TRUE
)
grid()
boxplot(df$DB.Wait..ms.,
        main = "Tiempo de espera (ms) para Base de Datos",
        xlab = "ms",
        ylab = "Tiempo de espera",
        col = "orange",
        border = "brown",
        horizontal = TRUE,
        notch = TRUE
)
grid()
boxplot(df$Cache.Wait..ms.,
        main = "Tiempo de espera (ms) para Caché",
        xlab = "ms",
        ylab = "Tiempo de espera",
        col = "yellow",
        border = "brown",
        horizontal = TRUE,
        notch = TRUE
)
grid()
quantile(df$DB.Wait..ms.,c(0.25,0.5,0.75),type=1)
quantile(df$Cache.Wait..ms.,c(0.25,0.5,0.75),type=1)
min(df$DB.Wait..ms.)
max(df$DB.Wait..ms.)
min(df$Cache.Wait..ms.)
max(df$Cache.Wait..ms.)
#Shapiro Wilk para normalidad 
shapiro.test(df$DB.Wait..ms.)#Verifico la normalidad de los datos de DB Wait
shapiro.test(df$Cache.Wait..ms.)#Verifico la normalidad de los datos de Caché Wait
#Si  p-value > 0.05 -> la distribución es normal
#p<0.05 -> no es una distribucion normal
#Se aplica test de wilcox para comparar medianas de distribuciones no normales. 
#Nivel de significancia alpha = 0.05
wilcox.test(df$DB.Wait..ms., df$Cache.Wait..ms.)
#p<0.05. La diferencia en las medianas es significativa
#porcentaje
mean(df$DB.Wait..ms.)/mean(df$Cache.Wait..ms.)
#DB Wait es 2.5 veces mas lento que Cache Wait.