###################
# AULA 21 NOVEMBRO

#####################################################################################
# Exercício: 
# a) Ajuste um modelo linear espacial aos dados "ca20" recorrendo ao package "spmodel"
library(geoR)
?ca20
library(spmodel)
library(sf)
ca20
class(ca20)
ca20_df <- data.frame(
  data = ca20$data,
  east = ca20$coords[, 1],       # Coordenadas X
  north = ca20$coords[, 2],      # Coordenadas Y
  altitude = ca20$covariate[,1],  # Altitude
  area = ca20$covariate[,2]    # Área
)
class(ca20_df)
dados.sf<- st_as_sf(ca20_df,coords = c("east", "north"))
class(dados.sf)
dados.sf

modelo <- splm(data ~ factor(area)+ st_coordinates(dados.sf),
               data = dados.sf,
               spcov_type = "exponential")
summary(modelo)

modelo <- splm(data ~ factor(area) + st_coordinates(dados.sf)[,2],
                data = dados.sf,
                spcov_type = "exponential")
summary(modelo)

modelo <- splm(data ~ factor(area),
               data = dados.sf,
               spcov_type = "exponential")
summary(modelo)


###################################################
# b) Faça predição de ca20 sobre uma grelha regular
###################################################
# Predição espacial – preparar grelha
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
# Reordenar os níveis de `gr.area` para garantir a mesma ordem
gr.area <- factor(gr.area, levels = levels(dados.sf$area))


# Criando um data.frame com as variáveis necessárias
novoslocais.df <- data.frame(
  area = gr.area,
  east = gr[,1], 
  north = gr[,2] 
)
novoslocais.sf <- st_as_sf(novoslocais.df, coords = c("east", "north"))
novoslocais.sf

previsoes <- augment(modelo, newdata=novoslocais.sf)
previsoes
summary(previsoes$.fitted)

# predictions + dados observados
ggplot(data = dados.sf, aes(colour = data)) +
  geom_sf(alpha = 0.4) +
  geom_sf(data = previsoes, aes(colour = .fitted)) +
  scale_colour_viridis_c(limits = c(23, 71)) +
  theme_minimal()

# apenas predictions
ggplot(data = previsoes, aes(colour = .fitted)) +
  geom_sf(alpha = 0.8) +
  scale_colour_viridis_c(limits = c(23, 71)) +
  theme_minimal()

# intervalos de prediçao
augment(modelo, newdata = novoslocais.sf, interval = "prediction", level = 0.95)



