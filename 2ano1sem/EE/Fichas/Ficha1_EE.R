#############
# EXERCICIO 1
# Gera 100 pontos no quadrado unitário debaixo dos 3 seguintes cenários:
# a) aleatoriedade espacial completa
# b) padrão regular  
# c) padrão correspondente a eventos fortemente agregados

par(mfrow=c(2,2))
# a) aleatorio
x1 <- runif(100,0,1)
y1 <- runif(100,0,1)
plot(x1,y1,cex=0.6)
#library(spatstat)
#pp <- runifpoint(100)
#plot(pp)

# b) regular
x2 <- seq(0.05,0.95,by=0.1)
y2 <- seq(0.05,0.95,by=0.1)
xy2 <- expand.grid(x2,y2)
plot(xy2, xlab="x", ylab="y",cex=0.6)

# c)  agregado
a1 <- runif(25,0.4,0.6)
b1 <- runif(25,0.1,0.3)
a2 <- runif(50,0.1,0.3)
b2 <- runif(50,0.2,0.6)
a3 <- runif(25,0.6,0.9)
b3 <- runif(25,0.6,0.9)
x3 <- c(a1,a2,a3)
y3 <- c(b1,b2,b3)
plot(x3,y3,cex=0.6)
#########################################


#############
# EXERCICIO 2
# b) Faça uma estimação não-paramétrica para a densidade de pontos dos 3 cenários simulados no Exercicio 1
library(spatstat)
?density.ppp

par(mfrow=c(1,3))
# padrao aleatorio
dados.ppp <- ppp(x=x1, y=y1)
plot(density.ppp(dados.ppp), main="aleatorio")
points(dados.ppp, cex=0.6)

# padrao regular
dim(xy2)
dados.ppp <- ppp(x=xy2[,1], y=xy2[,2])
plot(density.ppp(dados.ppp, sigma=0.03), main="regular")
points(dados.ppp, cex=0.6)

# padrao agregado
dados.ppp <- ppp(x=x3, y=y3)
plot(density.ppp(dados.ppp), main="agregado")
points(dados.ppp, cex=0.6)


#############
# EXERCICIO 3
# a) Analise dos dados s100 da package geoR
library(geoR)
points(s100)
plot(s100)

# c) Faça uma estimação não-paramétrica da variável de interesse, experimentando diferentes larguras de banda
library(spatstat)
?Smooth.ppp

par(mfrow=c(1,3))
dados.ppp <- ppp(x=s100$coords[,1], y=s100$coords[,2], marks=s100$data)
aux <- Smooth(dados.ppp); names(aux); plot(aux)
# by default the bandwidth is selected by least squares cross-validation, 
# using bw.smoothppp
bw.smoothppp(dados.ppp)

points(s100, add=T)
plot(Smooth(dados.ppp, sigma=0.2))
points(s100, add=T)
plot(Smooth(dados.ppp, sigma=0.5))
points(s100, add=T)

dados.ppp <- ppp(x=s100$coords[,1], y=s100$coords[,2])
plot(density.ppp(dados.ppp, sigma=1))
points(dados.ppp, cex=0.6)



#############
# EXERCICIO 4
# Analise dos dados de precipitação do Parana
library(geoR)
?parana
class(parana)

# a)
summary(parana)
names(parana)
boxplot(parana$data)
sd(parana$data)

# b)
points(parana)
plot(parana)

library(spatstat)

# Preparar os dados
dados.ppp <- ppp(x=parana$coords[,1], y=parana$coords[,2], marks=parana$data, 
                 owin(xrange=range(parana$coords[,1]), yrange=range(parana$coords[,2])))

# Estimar densidade dos pontos amostrados
?density.ppp
plot(density.ppp(dados.ppp))
points(dados.ppp, cex=0.5)

# Estimar mapa da intensidade dos valores amostrados
?Smooth.ppp
# Usar bw.smoothppp para escolher um valor adequado para sigma
?bw.smoothppp
bw <- bw.smoothppp(dados.ppp)

plot(Smooth(dados.ppp, sigma=bw))
points(parana, add=T)


# dados.ppp <- ppp(x=parana$coords[,1], y=parana$coords[,2], marks=parana$data)#, 
#             window=as.owin(poly=parana$borders))


############
# EXERCICO 5
library(geoR)
?cov.spatial

par(mfrow=c(2,2))
u <- seq(0, 1.4, by=0.05) #distancias no quadrado unitário [0, 1km]x[0, 1km]
# raio de influência (range) igual a 0.5 km
sigma2 <- 2; phi <- 0.5
Cov_u <- cov.spatial(u, cov.model= "spherical", cov.pars=c(sigma2,phi))
plot(u, Cov_u, type="l", xlab="distancias (km)", ylab="covariância")
plot(u, sigma2-Cov_u, type="l", xlab="distancias (km)", ylab="variograma")

# raio de influência (range) igual a 1 km
sigma2 <- 2; phi <- 1
Cov_u <- cov.spatial(u, cov.model= "spherical", cov.pars=c(sigma2,phi))
plot(u, Cov_u, type="l", xlab="distancias (km)", ylab="covariância")
plot(u, sigma2-Cov_u, type="l", xlab="distancias (km)", ylab="variograma")



############
# EXERCICO 6
# s100
# variogram - Matheron, Cressie and cloud
data(s100)
summary(s100)
plot(s100)

# Nota: caso se ignore que tendencia nao é constante
cloud1 <- variog(s100, option="cloud", max.dist=1)
bin1 <- variog(s100, uvec=seq(0,1,l=11))
par(mfrow=c(1,2))
plot(cloud1, main="classical estimator")
plot(bin1, main="classical estimator")


# Nota: caso se assuma uma tendencia não constante
# b) tendência linear + MMQ
par(mfrow=c(1,1))
# NOTA: o argumento trend="1st" indica a existência de uma tendência linear nos dados, 
# que será removida antes de se prosseguir  com a estimação do variograma empírico
bin1 <- variog(s100, trend="1st", max.dist=1)
plot(bin1, ylim=c(0,0.6))

?variofit
# O ajuste por MMQ é iterativo, pelo que os argumentos "ini.cov.pars=(sigma2, phi)" e 
# "nugget" permitem definir valores iniciais, devendo o método convergir para as 
# estimativas finais
aux<- variofit(bin1, cov.model="exponential", ini.cov.pars=c(0.3, 0.5), nugget=0.15)
aux
lines(aux) 
aux1<- variofit(bin1, cov.model="spherical", ini.cov.pars=c(0.3, 0.5), nugget=0.15)
aux1
lines(aux1, col="red") 

# c) tendência linear + MV
?likfit
aux2<- likfit(s100, trend="1st", cov.model="exponential", ini.cov.pars=c(0.3, 0.5), nugget=0.15)
aux2
lines(aux2, col="blue")
aux3<- likfit(s100, trend="1st", cov.model="spherical", ini.cov.pars=c(0.3, 0.5), nugget=0.15)
aux3
lines(aux3, col="green")

legend(list(x=0.4,y=0.25), lty=c(1,1,1), col=c("black","red","blue","green"), 
       c("exponencial MMQ","esferico MMQ","exponencial MV","esferico MV"), cex=0.8, bty="n")


############
# EXERCICO 7
# Dados do Parana da library geoR
# a) tendência linear + MMQ
par(mfrow=c(1,1))
bin1 <- variog(parana, trend="1st", max.dist=400)
plot(bin1)

?variofit
# O ajuste por MMQ é iterativo, pelo que os argumentos "ini.cov.pars=(sigma2, phi)" e 
# "nugget" permitem definir valores iniciais, devendo o método convergir para as 
# estimativas finais
aux<- variofit(bin1, cov.model="exponential", ini.cov.pars=c(600, 250), nugget=300)
aux
lines(aux) 

?likfit
aux1<- likfit(parana, trend="1st", cov.model="exponential", ini.cov.pars=c(600, 250), nugget=300)
aux1
lines(aux1, col="blue")

legend(list(x=100,y=300), lty=c(1,1), col=c("black","blue"), 
       c("exponencial MMQ","exponencial MV"), cex=0.8, bty="n")


?xvalid
