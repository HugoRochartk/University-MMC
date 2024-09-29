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
plot.geodata(s100)
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



