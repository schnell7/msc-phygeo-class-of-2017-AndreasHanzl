#installieren des VEGAN Pakets

install.packages("vegan")

#Laden von vegan

library(vegan)

#vektoren festlegen - jeweils die Anzahl der Punkte pro Klasse von 10 bis 1

Anzahl<-c(1, 2, 3, 10, 1, 7, 4, 1, 4, 2)

#Festlegung von S(S Anzahl der gesamten Klassen)

S <- c(10)

# Shannon Diversitätsindex berechnen

Shannon <- diversity(Anzahl, index = "shannon",MARGIN =, base =)

#Eveness des Shannon berechnen

Evenness_Shannon <- diversity(Anzahl, index="shannon")/log(S)


#Ergebnisse

Shannon

Evenness_Shannon
