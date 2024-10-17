library(geoR)
?parana
summary(parana) #distancia máxima 619.4925 km

#a
nuvem <- variog(parana,trend = "1st",  option="cloud", max.dist=0.6*619.4925) #max dist é 60% da distância máxima
bin <- variog(parana, trend="1st", max.dist =0.6*619.4925 )
#par(mfrow=c(1,2))
plot(nuvem, main="classical estimator")
plot(bin, main="classical estimator")


MMQ<- variofit(bin, cov.model="exponential", ini.cov.pars=c(600, 200), nugget=400)
MMQ
lines(MMQ) 

summary(MMQ)


#b
MV<- likfit(parana, trend="1st", cov.model="exponential", ini.cov.pars=c(600, 200), nugget=400)
MV
lines(MV, col="blue")

summary(MV)

legend(list(x=200,y=400), lty=c(1,1), col=c("black","blue"), 
       c("MMQ","MV"), cex=1)
?legend



#CROSS-VALIDATION
?xvalid
cvMMQ <- xvalid(parana, model=MMQ)
names(cvMMQ)
head(cvMMQ$data)
head(cvMMQ$predicted)
head(cvMMQ$krige.var)
head(cvMMQ$error) #real - predicted
head(cvMMQ$std.error) #error/krige.var
mean(cvMMQ$error) #erro medio
mean(cvMMQ$std.error) #erro normalizado medio

#COMPARAR COM ESTE MODELO E VER
cvMV <- xvalid(parana, model=modeloMV)



#c
MMQparam <- c(MMQ$nugget, MMQ$cov.pars[2], sum(MMQ$cov.pars))  # Nugget, Range, Sill

MVparam <- c(MV$nugget, MV$cov.pars[2], sum(MV$cov.pars))  


parametros <- c("Tau", "Phi", "Tau+Sigma2")

tabela_2_métodos <- data.frame(
  Parâmetros = parametros,
  MMQ = MMQparam,
  MV = MVparam
)

print(tabela_2_métodos)

