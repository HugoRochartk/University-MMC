library(spData)
library(spatstat)
library(ggplot2)
library(sp)
library(geoR)
library(car)
library(sf)
library(dplyr)
library(spdep) 
library(spatialreg)
library(corrplot)
library(GGally)


###dataset dados geoestatísticos
?meuse
data(meuse)
sapply(meuse, class)
summary(meuse)
ggplot(meuse, aes(x = zinc)) +
  geom_histogram(binwidth = 50, fill = "skyblue", color = "black", alpha = 0.7) +
  labs(title = "Histograma da variável zinco",
       x = "Concentração de zinco mg kg-1 soil (ppm)",
       y = "Frequência") +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 14, face = "bold"),
    axis.title = element_text(size = 12),
    axis.text = element_text(size = 10),
    panel.grid.major = element_line(color = "grey", linetype = "dashed", size = 0.5),
    panel.grid.minor = element_blank()
  ) 
?apply
apply(meuse, 2, sd, na.rm = TRUE)
apply(meuse, 2, var, na.rm = TRUE)

cor_matrix=cor(meuse[, sapply(meuse, is.numeric)], use = "complete.obs")
corrplot(cor_matrix, 
         method = "circle",       
         type = "upper",            
         tl.col = "black",          
         tl.srt = 45,            
         title = "Matriz de correlação",  
         mar = c(0, 0, 1, 0),       
         addCoef.col = "black",      
         number.cex = 0.8)  


data = meuse[, c("copper", "cadmium", "lead", "zinc", "elev")]

ggpairs(data, 
        aes(color = "blue", alpha = 0.6),  
        lower = list(continuous = wrap("points", alpha = 0.6)),  
        diag = list(continuous = "barDiag"),  
        upper = list(continuous = "blank"),  
        title = "Relação entre a concentração de metais pesados e a elevação") +
  theme_minimal() +  
  theme(
    axis.text = element_text(size = 12),  
    axis.title = element_text(size = 14),  
    plot.title = element_text(hjust = 0.5, size = 16)  
  )



#copper
#estimação não parametrica para a densidade dos pontos
dados.ppp = ppp(x=meuse$x, y=meuse$y, marks=meuse$zinc, 
                 owin(xrange=range(meuse$x), yrange=range(meuse$y)))
plot(density.ppp(dados.ppp), main="aleatorio")
points(dados.ppp, cex=0.6)

#estimação não-paramétrica da variável de interesse
par(mfrow = c(1, 2))
bw = bw.smoothppp(dados.ppp)
border = convexhull.xy(dados.ppp)

# Restrict the smoothing to the region within the border
smooth_within_border = Smooth(dados.ppp, sigma = bw, edge = TRUE)
smooth_within_border = smooth_within_border[border, drop = FALSE]

# Plot the restricted smoothing result
plot(smooth_within_border)
#points(dados.ppp, add = TRUE) só para verificação

plot(dados.ppp)
par(mfrow = c(1, 1))

#estimação da tendencia espacial
meuse_geo = as.geodata(meuse, coords.col = c("x", "y"), data.col = "zinc")
plot(meuse_geo) #não é estacionário na média, tem tendência não constante

#definir dados de treino e teste
set.seed(42)  
n = nrow(meuse);n

test_indices = sample(1:n, size = 4, replace = FALSE)
test = meuse[test_indices, ]

train_indices = setdiff(1:n, test_indices)
train = meuse[train_indices, ]

cat("Conjunto de treino:\n")
print(train)
nrow(train)
cat("\nConjunto de teste:\n")
print(test)
nrow(test)

#não utilizaremos os outros metais pesados pois estes são extremamente correlacinados, queremos evitar multicolinearidade
aux.lm=lm(train$zinc~x+y+elev+dist+om+ffreq+soil+lime+landuse+dist.m, data=train)
summary(aux.lm)
#removemos y
aux.lm=lm(train$zinc~x+elev+dist+om+ffreq+soil+lime+landuse+dist.m, data=train)
summary(aux.lm)
#removemos landuse
aux.lm=lm(train$zinc~x+elev+dist+om+ffreq+soil+lime+dist.m, data=train)
summary(aux.lm)
#removemos dist
aux.lm=lm(train$zinc~x+elev+om+ffreq+soil+lime+dist.m, data=train)
summary(aux.lm)
#removemos soil
aux.lm=lm(train$zinc~x+elev+om+ffreq+lime+dist.m, data=train)
summary(aux.lm) #todos os betas são estatísticamente significativos usando um intervalo de cofiança de 90%
#vamos assumir tendencia linear 

vif(aux.lm) #inferior a 10 logo não há colinearidade entre preditores


#criar dataset geodata com as nossaas covariáveis
meuse_geo_train = as.geodata(
  train, 
  coords.col = c("x", "y"),          
  data.col = "zinc",               
  covar.col = c("elev", "om", "ffreq", "lime", "dist.m") 
)

meuse_geo_test = as.geodata(
  test, 
  coords.col = c("x", "y"),          
  data.col = "zinc",               
  covar.col = c("elev", "om", "ffreq", "lime", "dist.m") 
)


summary(meuse_geo_train)
#estimar variograma empirico
v=variog(meuse_geo_train,trend=~x+elev+om+ffreq+lime+dist.m, max.dist =0.6*4440.76435)
plot(v, main="Variograma dos resíduos")

v$n 
#nenhum deles usou menos de 30 pontos

?variofit
#variograma teorico
#modelo exponencial metodo min quadrados
MQexp.v=variofit(v, ini.cov.pars=c(25000,700), cov.model="exp", nugget=20000)
lines(MQexp.v)
#modelo esferico ...
MQsph.v=variofit(v, ini.cov.pars=c(25000,700), cov.model="spherical", nugget=20000)
lines(MQsph.v, col="red")

MQgau.v=variofit(v, ini.cov.pars=c(25000,700), cov.model="gaussian", nugget=20000)
lines(MQgau.v, col="green")

MQmat.v=variofit(v, ini.cov.pars=c(25000,700), cov.model="matern", nugget=20000, kappa=2)
lines(MQmat.v, col="magenta")


MVexp.v= likfit(meuse_geo_train, trend=~x+elev+om+ffreq+lime+dist.m, cov.model="exponential", ini.cov.pars=c(25000,700), nugget=20000)
lines(MVexp.v, col="blue")

MVsph.v= likfit(meuse_geo_train, trend=~x+elev+om+ffreq+lime+dist.m, cov.model="spherical", ini.cov.pars=c(25000,700), nugget=20000)
lines(MVsph.v, col="gray")

MVgau.v=likfit(meuse_geo_train, trend=~x+elev+om+ffreq+lime+dist.m, cov.model="gaussian", ini.cov.pars=c(25000,700),nugget=20000)
lines(MQgau.v, col="purple")

MVmat.v=likfit(meuse_geo_train, trend=~x+elev+om+ffreq+lime+dist.m, ini.cov.pars=c(25000,700), cov.model="matern", nugget=20000, kappa=2)
lines(MQmat.v, col="cyan")

?likfit
legend(list(x=1100,y=25000), lty=c(1,1), col=c("black","red","green","magenta","blue","gray","purple","cyan"), 
       c("exponencial MMQ","spherical MMQ","gaussian MMQ","matern MMQ","exponencial MMV","spherical MMV","gaussian MMV","matern MMV"), cex=0.8, bty="n")


#validação cruzada
MQexp.xv=xvalid(meuse_geo_train, model=MQexp.v)
mean(MQexp.xv$error)
mean(MQexp.xv$std.error)
sd(MQexp.xv$std.error)
mean(MQexp.xv$std.error^2)

MQsph.xv=xvalid(meuse_geo_train, model=MQsph.v)
mean(MQsph.xv$error)
mean(MQsph.xv$std.error)
sd(MQsph.xv$std.error)
mean(MQsph.xv$std.error^2)

MQgau.xv=xvalid(meuse_geo_train, model=MQgau.v)
mean(MQgau.xv$error)
mean(MQgau.xv$std.error)
sd(MQgau.xv$std.error)
mean(MQgau.xv$std.error^2)

MQmat.xv=xvalid(meuse_geo_train, model=MQmat.v)
mean(MQmat.xv$error)
mean(MQmat.xv$std.error)
sd(MQmat.xv$std.error)
mean(MQmat.xv$std.error^2)



MVexp.xv=xvalid(meuse_geo_train, model=MVexp.v)
mean(MVexp.xv$error)
mean(MVexp.xv$std.error)
sd(MVexp.xv$std.error)
mean(MVexp.xv$std.error^2)

MVsph.xv=xvalid(meuse_geo_train, model=MVsph.v)
mean(MVsph.xv$error)
mean(MVsph.xv$std.error)
sd(MVsph.xv$std.error)
mean(MVsph.xv$std.error^2)

MVgau.xv=xvalid(meuse_geo_train, model=MVgau.v)
mean(MVgau.xv$error)
mean(MVgau.xv$std.error)
sd(MVgau.xv$std.error)
mean(MVgau.xv$std.error^2)

MVmat.xv=xvalid(meuse_geo_train, model=MVmat.v)
mean(MVmat.xv$error)
mean(MVmat.xv$std.error)
sd(MVmat.xv$std.error)
mean(MVmat.xv$std.error^2)



###krigging
?krige.control
KC = krige.control(type.krige = "ok", trend.d=~meuse_geo_train$coords[,1]+meuse_geo_train$covar[,1]+meuse_geo_train$covar[,2]+meuse_geo_train$covar[,3]+meuse_geo_train$covar[,4]+meuse_geo_train$covar[,5],
                    trend.l=~meuse_geo_test$coords[,1]+meuse_geo_test$covar[,1]+meuse_geo_test$covar[,2]+meuse_geo_test$covar[,3]+meuse_geo_test$covar[,4]+meuse_geo_test$covar[,5], obj=MQsph.v)
?krige.conv
kr = krige.conv(geodata=meuse_geo_train, locations=meuse_geo_test$coords, krige=KC)
kr$predict
meuse_geo_test$data
sqrt(kr$krige.var) #variancia daspredições
?points
points(meuse_geo_train)
krig.ests = as.geodata(cbind(meuse_geo_test$coords, kr$predict))
points(krig.ests, col=2, add=T)

###dataset dados agregados

?world

class(world)
sapply(world, class)
summary(world)
ggplot(world, aes(x = lifeExp)) +
  geom_histogram(binwidth = 1, fill = "#69b3a2", color = "black", alpha = 0.7) +  
  labs(title = "Distribuição da esperança média de vida no mundo",
       x = "Esperança média de vida",
       y = "Frequência") +
  theme_minimal() +  
  theme(
    axis.text = element_text(size = 12),  
    axis.title = element_text(size = 14), 
    plot.title = element_text(hjust = 0.5, size = 16, face = "bold"),  
    panel.grid.major = element_line(color = "gray", size = 0.5),
    panel.grid.minor = element_blank()  
  )

world.df = as.data.frame(st_drop_geometry(world))
apply(world.df[, sapply(world.df, is.numeric)], 2, sd, na.rm = TRUE)
apply(world.df[, sapply(world.df, is.numeric)], 2, var, na.rm = TRUE)

corr_matrix=cor(world.df[, sapply(world.df, is.numeric)], use = "complete.obs")
corrplot(corr_matrix, 
         method = "circle",          
         type = "upper",             
         col = colorRampPalette(c("blue", "white", "red"))(200),  
         tl.col = "black",           
         tl.srt = 45,               
         number.cex = 0.8,           
         addCoef.col = "black",     
         diag = FALSE,               
         title = "Matriz de correlação",  
         mar = c(0, 0, 1, 0))   

world$gdpPercapCategory = cut(
  world$gdpPercap,
  breaks = quantile(world$gdpPercap, probs = seq(0, 1, by = 0.25), na.rm = TRUE),
  include.lowest = TRUE,
  labels = c("GDP Baixo", "GDP Médio-Baixo", "GDP Médio-Alto", "GDP Alto")
)


boxplot(
  lifeExp ~ gdpPercapCategory,
  data = world,
  main = "Esperança média de vida em função do GDP per capita",
  xlab = "GDP per Capita",
  ylab = "Esperança média de vida",
  col = c("skyblue", "lightgreen", "orange", "pink")
)


??st_crs
st_crs(world)



ggplot(world, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(aes(color = continent), alpha = 0.7, size = 3) +
  geom_smooth(method = "lm", color = "black", linetype = "dashed") +
  scale_x_log10() +
  labs(
    title = "Relação entre o GDP per capita e a esperança média de vida",
    x = "GDP per Capita (escala logarítmica)",
    y = "Esperança média de vida"
  ) +
  theme_minimal()

ggplot(world, aes(x = lifeExp, fill = continent)) +
  geom_density(alpha = 0.6) +
  labs(
    title = "Densidade da esperança média de vida por continente",
    x = "Esperança média de vida",
    y = "Densidade"
  ) +
  theme_minimal()

asia = world %>%filter(continent == "Asia")
summary(asia)

ggplot(data = asia) +
  geom_sf(aes(fill = lifeExp)) +       
  scale_fill_viridis_c(option = "plasma",  
                       name = "Esperança média de vida") + 
  theme_minimal() +                    
  labs(title = "Esperança média de vida na Ásia",
       ) +
  theme(
    axis.text = element_blank(),         
    axis.ticks = element_blank(),
    panel.grid = element_blank()        
  )


asia_no_na = asia %>% filter(!is.na(lifeExp) & !is.na(gdpPercap)) #tirar nas
# matrix w baseada no poligno
?tri2nb
nb = poly2nb(asia_no_na)                     
lw = nb2listw(nb, style = "W", zero.policy = TRUE)       



moran_result = moran.test(asia_no_na$lifeExp, lw, alternative = "two.sided")
print(moran_result)
# não ha evidencia estatistica para rejeitar H0 e logo não há correlação espacial entre as esperanças de vida dos países

#geary c
geary_result = geary.test(asia_no_na$lifeExp, lw)
print(geary_result)
#a geary c statistic é inferior a 1 indicando correlaçao espacial positiva ou seja valores semlhantes estão agrupados/ são vizinhos
#e pelo p value há evidencia estatistica para rejeitar h0 e logo há correlação espacial significativa

#matriz de vizinhança baseada nos centroides
centroids = st_centroid(st_geometry(asia_no_na))  #extrair os centroides
coords = st_coordinates(centroids)

nb_centroids = tri2nb(as.matrix(coords));nb
lw_centroids = nb2listw(nb_centroids, style = "W", zero.policy = TRUE)


moran_result = moran.test(asia_no_na$lifeExp, lw_centroids, alternative = "two.sided")
print(moran_result)
# não ha evidencia estatistica para rejeitar H0 e logo não há correlação espacial entre as esperanças de vida dos países


#geary c
geary_result = geary.test(asia_no_na$lifeExp, lw_centroids)
print(geary_result)
#o geary c statistic aponta para uma correlação espacial positiva mas olhando parao p value vemos que
#nao ha evidencia estatistica para rejeitar h0 logo não há correlação espacial entre as esperanças de vida dos países



###modelo linear
summary(asia_no_na)
model_LM = lm(lifeExp ~ subregion +type + area_km2 + pop + gdpPercap, data = asia_no_na)
summary(model_LM)
AIC(model_LM)
#tirar pop
model_LM = lm(lifeExp ~ subregion +type + area_km2 + gdpPercap, data = asia_no_na)
summary(model_LM)
AIC(model_LM)
#tirar type
model_LM = lm(lifeExp ~ subregion + area_km2 + gdpPercap, data = asia_no_na)
summary(model_LM)
AIC(model_LM)
#tirar area
model_LM = lm(lifeExp ~ subregion + gdpPercap, data = asia_no_na)
summary(model_LM)
AIC(model_LM)


model_LM.moran = lm.morantest(model_LM, lw_centroids, alternative = "greater", 
                               resfun = weighted.residuals)
model_LM.moran
#como o p value é superior a 0.05 n podemos rejeitar H0 e logo podemos assumir residuos independentes



###modelo SAR
?lagsarlm
model_SAR = lagsarlm(lifeExp ~ subregion + gdpPercap, data = asia_no_na, lw_centroids, 
                      method = "eigen", quiet = TRUE)
summary(model_SAR)

moran.test(model_SAR$residuals, lw_centroids, alternative = "two.sided")


###modelo SMA
model_SAR = errorsarlm(lifeExp ~ subregion + gdpPercap, data = asia_no_na, lw_centroids, 
                      method = "eigen", quiet = TRUE)
summary(model_SAR)

moran.test(model_SAR$residuals, lw_centroids, alternative = "two.sided")


##modelo CAR
model_CAR = spautolm(lifeExp ~ subregion + gdpPercap, data = asia_no_na, lw_centroids,method = "eigen", family="CAR")
summary(model_CAR)

moran.test(model_CAR$fit$residuals, lw_centroids, alternative = "two.sided")

str(model_CAR)
