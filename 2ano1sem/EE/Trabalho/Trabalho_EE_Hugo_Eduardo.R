library(spData)
library(spatstat)
library(ggplot2)
library(sp)


###dataset dados geoestatísticos
?meuse
data(meuse)
summary(meuse)
hist(meuse$cadmium)
?apply
apply(meuse, 2, sd, na.rm = TRUE)
apply(meuse, 2, var, na.rm = TRUE)
sapply(meuse, class)
cor(meuse[, sapply(meuse, is.numeric)], use = "complete.obs")
plot(meuse[, c("copper", "cadmium","lead","zinc","elev")])

#cadmium
dados.ppp <- ppp(x=meuse$x, y=meuse$y, marks=meuse$cadmium, 
                 owin(xrange=range(meuse$x), yrange=range(meuse$y)))
plot(density.ppp(dados.ppp), main="aleatorio")
points(dados.ppp, cex=0.6)


bw <- bw.smoothppp(dados.ppp)

plot(Smooth(dados.ppp, sigma=bw)) #este gráfico está nos a causar um pouco de confusão pelo facto de marcar a vermelho zonas sem observações
points(meuse, add=T)

plot(dados.ppp)


###dataset dados agregados

?world

class(world)
summary(world)
hist(world$lifeExp)
apply(world[, sapply(world, is.numeric)], 2, sd, na.rm = TRUE)
apply(world[, sapply(world, is.numeric)], 2, var, na.rm = TRUE)
sapply(world, class)
cor(world[, sapply(world, is.numeric)], use = "complete.obs")
world$gdpPercapCategory <- cut(
  world$gdpPercap,
  breaks = quantile(world$gdpPercap, probs = seq(0, 1, by = 0.25), na.rm = TRUE),
  include.lowest = TRUE,
  labels = c("Low GDP", "Lower-Middle GDP", "Upper-Middle GDP", "High GDP")
)


boxplot(
  lifeExp ~ gdpPercapCategory,
  data = world,
  main = "Life Expectancy by GDP per Capita",
  xlab = "GDP per Capita Category",
  ylab = "Life Expectancy",
  col = c("skyblue", "lightgreen", "orange", "pink")
)


??st_crs
st_crs(world)


ggplot(data = world) +
  geom_sf(aes(fill = lifeExp)) +         # Map life expectancy to fill color
  scale_fill_viridis_c(option = "plasma",  # Use a colorblind-friendly scale
                       name = "Life Expectancy") + 
  theme_minimal() +                     # Minimalistic theme
  labs(title = "World Map: Life Expectancy",
       subtitle = "Highlighting life expectancy by country") +
  theme(
    axis.text = element_blank(),         # Remove axis labels
    axis.ticks = element_blank(),
    panel.grid = element_blank()         # Remove grid lines
  )

ggplot(world, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(aes(color = continent), alpha = 0.7, size = 3) +
  geom_smooth(method = "lm", color = "black", linetype = "dashed") +
  scale_x_log10() +
  labs(
    title = "Relationship Between GDP per Capita and Life Expectancy",
    x = "GDP per Capita (log scale)",
    y = "Life Expectancy"
  ) +
  theme_minimal()

ggplot(world, aes(x = lifeExp, fill = continent)) +
  geom_density(alpha = 0.6) +
  labs(
    title = "Density of Life Expectancy by Continent",
    x = "Life Expectancy",
    y = "Density"
  ) +
  theme_minimal()

