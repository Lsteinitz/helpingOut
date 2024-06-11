#einlesen cvs-Datei
abu <- read.csv2("5_6_Abundanz_Wetter_530eac34aaf68c089c056c0cbf6a301b.csv")
abu

#einlesen excel-Datei
kadaver <- read.csv2("5_6_Kadaverdaten_881a69df2606fb9e7a772a99779e2a56.CSV")
kadaver



#Sortieren des Datensatzes nach Temperatur & Niederschlag
abu <- abu[order(abu$Temperatur, abu$Niederschlag),]

#artentabelle erstellen
arten<- data.frame(abu$Buteo_buteo, abu$Corvus_spec., abu$Corvus_corax)

#Temperatur& Niederschlagsdaten stimmen in Datensatz nicht mehr mit Ausgangswert überein
# werden aber noch ordentlich angezeigt
abu

plot(arten, abu$Temperatur, type= "l", xlim= c(0,10),ylim= c(0,70), col= "red")
lines(arten, abu$Niederschlag/2, type="l",col="blue")
axis(4, at=seq(0,70,10), seq(0,140,20))

