#############
# 
require(geoR)
data(ca20)
help(ca20)
summary(ca20)
names(ca20)


points(ca20, borders=ca20$borders, xlab="X",ylab="Y",main="Dados de calcio observados", cex.main=1.0)
polygon(ca20$reg1) #north west
polygon(ca20$reg2) #north east
polygon(ca20$reg3) # south
text(x=5310.6, y=5567.2, "1", col="red")
text(x=5861.4, y=5649.6, "2", col="red")
text(x=5848.4, y=5064.1, "3", col="red")

## Como modelar a esperança/tendência do processo espacial? 
aux.lm=lm(ca20$data~area+ca20$coords[,2], data=ca20)
summary(aux.lm)

###########
# QUESTÃO 1 – Que conclui sobre a esperança/tendência deste processo espacial?
###########
# O processo espacial Y(x) não é estacionário na média. Um possivel modelo para
# E[Y(x)] = mu(x) = 163.69 + 5.96*Se(area=2) + 7.19*Se(area=3) -0.0228*Latitude(x)
# - A concentração média do cálcio da área 2 é cerca de 5.96 unidades superior ao valor 
#   médio da área 1, fixando os valores das restantes covariáveis
# - A concentração média do cálcio da área 3 é cerca de 7.19 unidades superior ao valor  
#   médio da área 1, fixando os valores das restantes covariáveis
# - Por cada aumento unitário da latitude, espera-se que a concentração do cálcio diminua 
#   cerca de 0.0228 unidades, fixando os valores das restantes covariáveis  



## Como modelar a dependência/correlação espacial? 
v <- variog(ca20, trend=~area+ca20$coords[,2], max.dist=700)
plot(v, main="Variograma dos residuos (apos excluir tendencia)", cex.main=1.0, ylim=range(0,120))


# MÉTODO 1: estimação por máxima verosimilhança (MV)
ml.sph <- likfit(ca20, trend=~area+ca20$coords[,2], ini=c(100, 250), nug=40, cov.model="spherical")
ml.sph
lines(ml.sph, col="blue", lty=1)
ml.exp <- likfit(ca20, trend=~area+ca20$coords[,2], ini=c(100, 250), nug=40, cov.model="exponential")
ml.exp
lines(ml.exp,col="blue",lty=2)

# MÉTODO 2: estimação por minimos quadrados (MQ)
var.sph <- variofit(v, ini=c(100, 200), nug=40, cov.model="spherical")
var.sph
lines(var.sph, col="red", lty=1)
var.exp <- variofit(v, ini=c(100, 200), nug=40, cov.model="exponential")
var.exp
lines(var.exp, col="red",lty=2)
#xy=locator(1)
legend(list(x=369.0257,y=49.51473), pch=c(1,-1,-1,-1,-1), lty=c(0,1,2,1,2),
       col=c("black","blue","blue","red","red"), 
       c("variograma experimental","modelo esferico (MV)", "modelo exponencial (MV)",
         "modelo esferico (MQ)", "modelo exponencial (MQ)"), cex=0.8, bty="n")

###########
# QUESTÃO 2 - Construa uma Tabela comparando as estimativas dos vários parâmetros da estrutura
#             de covariância espacial ($\sigma^2$, $\tau^2$ e $\phi$), obtidos pelos dois métodos: 
#             máxima verosimilhança e minimos quadrados (considerando os modelos esférico e exponencial)
###########



# Predição espacial – kriging
gr0x <- seq(4900,6000, by=50)
gr0y <- seq(4800,5800,by=50)
gr0 <- expand.grid(gr0x, gr0y)
points(ca20)
points(gr0, pch=".",cex=2)
## selecionar pontos da grelha dentro da área estudada
gr <- polygrid(gr0x, gr0y, bor=ca20$borders)
points(gr, pch=".", col=2, cex=2)

## criar covariavel "area" nas novas localizações
gr.area <- numeric(nrow(gr))
gr.area[.geoR_inout(gr, poly=ca20$reg1, bound=T)] <- 1
gr.area[.geoR_inout(gr, poly=ca20$reg2, bound=T)] <- 2
gr.area[.geoR_inout(gr, poly=ca20$reg3, bound=T)] <- 3
gr.area <- as.factor(gr.area)

KC <- krige.control(type.krige = "ok", trend.d=~area+ca20$coords[,2], 
                    trend.l=~gr.area+gr[,2], obj=var.exp)
kr <- krige.conv(geodata=ca20, locations=gr0, krige=KC, borders=ca20$borders)

# Mapas mais usuais a 2D 
contour(kr, filled=TRUE, main="Estimativas de Kriging")
contour(kr, val=sqrt(kr$krige.var),
        filled=TRUE, coords.data=ca20$coords, main="Desvio Padrao de Kriging")


