# Installiere ggplot2 falls noch nicht vorhanden
if(!require(ggplot2)) {
  install.packages("ggplot2")
}
if(!require(reshape2)) {
  install.packages("reshape2")
}

# Lade die notwendigen Pakete
library(ggplot2)
library(reshape2)

# Lade die CSV-Datei
data <- read.csv2("5_6_Abundanz_Wetter_530eac34aaf68c089c056c0cbf6a301b.csv")

# Konvertiere die Daten in ein langes Format
data_long <- melt(data, id.vars = c("Niederschlag", "Temperatur"), variable.name = "Tierart", value.name = "Anwesenheit")

# Filtere nur die anwesenden Tierarten
data_long <- subset(data_long, Anwesenheit == 1)

# Aggregiere die Daten nach Niederschlag und Temperatur
data_aggregated <- aggregate(Tierart ~ Niederschlag + Temperatur, data_long, function(x) paste(x, collapse = ", "))
data_aggregated$Anzahl_Tierarten <- sapply(strsplit(data_aggregated$Tierart, ", "), length)

# Plot: Temperatur und Niederschlag als horizontale Linien, Tierarten als vertikale Linien
ggplot() +
  geom_segment(data = data_aggregated, aes(x = Niederschlag, xend = Niederschlag, y = 0, yend = Anzahl_Tierarten), 
               color = "darkorange", size = 1) +
  geom_segment(data = data_aggregated, aes(x = 0, xend = max(Niederschlag), y = Temperatur, yend = Temperatur), 
               color = "blue", size = 1) +
  geom_segment(data = data_aggregated, aes(x = 0, xend = max(Niederschlag), y = Niederschlag, yend = Niederschlag), 
               color = "red", size = 1) +
  labs(title = "Zusammenhang zwischen Niederschlag, Temperatur und anwesenden Tierarten",
       x = "Niederschlag (mm)",
       y = "Wert",
       size = "Anzahl der Tierarten") +
  theme_minimal()


