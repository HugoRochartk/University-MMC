require(geoR)
data(ca20)
help(ca20)
summary(ca20)
names(ca20)



#############################################
### PARTE FINAL - usar altitude como preditor

# QUESTÃO 3 – Repita todo o processo de modelação dos dados do cálcio, mas agora 
# também considerando a covariável “altitude”. Para que tal seja possível terá que 
# previamente fazer predição desta covariável nas novas localizações. 
# Quais as principais conclusões?

#########
# PASSO I - Precisamos estimar correlação espacial presente nos residuos do cálcio
#           depois de removermos efeito da área, latitude e altitude.
names(ca20)
aux <- lm(ca20$data~altitude+area+ca20$coords, data=ca20)
summary(aux)
aux <- lm(ca20$data~altitude+area+ca20$coords[,2], data=ca20)
summary(aux)

v <- variog(ca20, trend=~altitude+area+ca20$coords[,2], max.dist=700)
plot(v, main="Variograma dos residuos (apos excluir tendencia)", cex.main=1.0, ylim=range(0,120))
var.exp1 <- variofit(v, ini=c(100, 200), nug=40, cov.model="exponential")
var.exp1
#var.exp1 = variograma teórico obtido retirando efeito da area, latitude e ALTITUDE
lines(var.exp1, col="blue",lty=2)

##########
# PASSO II - Precisamos estimar (recorrendo ao kriging) a altitude em todos os pontos da grelha de predição
#            (292 pontos), à custa dos 178 altitudes observadas.
length(ca20$coords[,2])

# criar grelha
# Predição espacial – kriging
gr0x <- seq(4900,6000, by=50)
gr0y <- seq(4800,5800,by=50)
gr0 <- expand.grid(gr0x, gr0y)
gr <- polygrid(gr0x, gr0y, bor=ca20$borders)
## criar covariavel "area" nas novas localizações
gr.area <- numeric(nrow(gr))
gr.area[.geoR_inout(gr, poly=ca20$reg1, bound=T)] <- 1
gr.area[.geoR_inout(gr, poly=ca20$reg2, bound=T)] <- 2
gr.area[.geoR_inout(gr, poly=ca20$reg3, bound=T)] <- 3
gr.area <- as.factor(gr.area)

# Considere-se agora o processo espacial Y(x)=altitude na localização x
dados_alt <- as.geodata(cbind(ca20$coords, ca20$covariate$altitude)) #matriz 178x3
plot(dados_alt)

# Qual a estrutura de correlação espacial presente nos dados da altitude (depois de removermos efito das coordenadas)?
v_alt <- variog(geodata=dados_alt, trend=~ca20$coords, max.dist=700)
# OU
#v_alt <- variog(coords=ca20$coords, data=ca20$covariate$altitude, trend=~ca20$coords, max.dist=700)

plot(v_alt, main="Variograma dos residuos ALTITUDE (apos excluir tendencia)", cex.main=1.0)
var_alt.exp <- variofit(v_alt, ini=c(0.15, 400), nug=0.03, cov.model="exponential")
var_alt.exp
lines(var_alt.exp, lty=2)

KC_alt <- krige.control(type.krige = "ok", trend.d=~dados_alt$coords[,1]+dados_alt$coords[,2], 
                     trend.l=~gr[,1]+gr[,2], obj=var_alt.exp)

kr_alt <- krige.conv(geodata=dados_alt, locations=gr0, krige=KC_alt, borders=ca20$borders)

contour(kr_alt, filled=TRUE, main="Estimativas de Kriging - ALTITUDE")
length(kr_alt$predict) #292 pontos da grelha


###########
# PASSO III - Estimar superficie de cálcio, assumindo altitude, area e latitude como covariáveis
# 
KC1 <- krige.control(type.krige = "ok", trend.d=~altitude+area+ca20$coords[,2], 
                    trend.l=~kr_alt$predict+gr.area+gr[,2], obj=var.exp1)
kr <- krige.conv(geodata=ca20, locations=gr0, krige=KC1, borders=ca20$borders)

# Mapas mais usuais a 2D 
contour(kr, filled=TRUE, main="Estimativas de Kriging (3 preditores)")
contour(kr, val=sqrt(kr$krige.var),
        filled=TRUE, coords.data=ca20$coords, main="Desvio Padrao de Kriging")

summary(kr$predict)

