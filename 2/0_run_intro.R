#########################################################################
##
## Erstes R-Tutorial anhand der gereinigten Daten zu Aufgabe 5
## (insurance_data_clean.xls)
## 
## Viel Erfolg! Angi & Harald, 2022
##
#########################################################################

## IMMER DER ERSTE SCHRITT (jedenfalls für Nicht-Linux-User): 
## ARBEITSVERZEICHNIS FESTLEGEN!

## Das Arbeitsverzeichnis sollte der Folder sein, wo auch die gereinigten Daten sind: 
## "insurance_data_clean.xls"
## In dieses Verzeichnis wird dann auch alles (Bilder, Rhistory, RData,...) abgespeichert (falls man das möchte).

## Das Arbeitsverzeichnis kann per R-Menü-Knopf oder manuell gewählt werden:
# setwd("~/...")

## Check des Arbeitsverzeichnisses:
getwd()

#########################################################################
## Einlesen der Datei, Definition des internen Objekts my.data (die Datenmatrix)
#########################################################################

## Ein Excel-Datenblatt kann mit Hilfe des R Package 'readxl' eingelesen werden:
## Hadley Wickham und Jennifer Bryan, 2019. readxl: Read Excel Files.
## Zuvor muss es geladen (und vorher ggfs. noch installiert) werden!
install.packages("readxl", repos = "http://cran.us.r-project.org")
library('readxl')

my.data = read_excel('./2/insurance_data_clean.xls', sheet = 'data', range = cell_cols('A:F'))

#########################################################################
## Struktur der Datenmatrix
#########################################################################

str(my.data)

## Ein erster Eindruck (nicht alles ist sinnvoll), Minimum/Maximum, Mittelwerte, Quantile, evtl. fehlende Werte:
summary(my.data)

## Einzelne Elemente, Zeilen, Spalten:
my.data[10,6]
my.data[10,]
my.data[1,]
my.data[1:10,]
my.data[1,4:5]
my.data[1,c(1,3,5)]
head(my.data)
tail(my.data)

## Command-Erklärungen bekommt man immer mit vorangestelltem "?" 
# ?head

#########################################################################
## Variablen definieren: damage, amount, gender
#########################################################################

## Definiere internes Objekt damage = Anzahl der Schäden
## ... als Spalte Nr. 5:
damage = my.data[,5]
## ... alternative Definition:
damage = my.data$`number of damages in 2008`
## Es ist ein Vektor von vornehmlich Nullen und Einsen:
damage

## Definiere internes Objekt amount = Schadenssumme:
amount = my.data$`amount of damage in 2008`

## Definiere internes Objekt gender = Geschlecht des Versicherungsnehmers:
gender = my.data$gender

#########################################################################
## Logische Abfragen/Verknüpfungen
#########################################################################

## Logische Vergleiche liefern entsprechend lange Vektoren aus TRUE und FALSE:
damage == 0
damage > 0
gender == 'f'

## Damit kann eine weitere Variable oder auch der gesamte Datensatz gefiltert werden!

## Datei der weiblichen Versicherungsnehmer:
my.data[gender == 'f',]

## Schadenssummen der Versicherungsnehmer mit (mindestens) einem Schaden:
amount[damage > 0] 

## Logische Verküpfungen mit & (und) bzw. | (oder):
## Schadenssummen der weiblichen Versicherungsnehmer mit (mindestens) einem Schaden:
amount[(gender == 'f') & (damage > 0)]
## Schadenssummen der weiblichen Versicherungsnehmer oder derjenigen Versicherungsnehmer mit (mindestens) einem Schaden:
amount[(gender == 'f') | (damage > 0)]
## (Hier nicht wirklich informativ...)

#########################################################################
## Diagramme der Häufigkeitsverteilungen
#########################################################################

##################################################
## gender ist eine qualtitative nominalskalierte Variable.
##################################################

## Geeignet: ein Kreisdiagramm, aber nicht von den Werten selbst --- da kommt eine Fehlermeldung:
# pie(gender)
## ... sondern von der Häufigkeitsverteilung:
table(gender)
pie(table(gender))

## In Farbe:
pie(table(gender), col = c(1,2))
pie(table(gender), col = c("mistyrose","cornflowerblue"), labels = c("weiblich","männlich"), clockwise = TRUE)

## Diese Farbnamen gibt es:
colours()
## ... das ist BE, AE colors() ist auch möglich.

## Hinzufügen der Häufigkeiten:
text(0.40,0.25, table(gender)[1])
text(-0.40,-0.25, table(gender)[2])

##################################################
## damage ist eine quantitative diskrete Variable.
##################################################

## Geeignet: ein Balkendiagramm
## ... aber nicht dieses! Warum? Was zeigt es?
barplot(damage)
## Man braucht erst wieder die Häufigkeitsverteilung:
table(damage)
## Dieses ist das gesuchte Diagramm:
barplot(table(damage))

## In Farbe:
barplot(table(damage), col = "springgreen")

## Hinzufügen der Häufigkeiten:
mybp = barplot(table(damage), col = "cornflowerblue")
## Koordinaten der Balken:
mybp
## Häufigkeiten:
mytab = table(damage)
mytab
## Hinzufügen auf Höhe 400:
text(mybp, 400, mytab)

##################################################
## amount ist eine quantitative stetige Variable.
##################################################

## Ein Balkendiagramm? --- nicht geeignet!
## Siehe:
table(amount)
barplot(table(amount))

## Geeignet: ein Histogramm!
hist(amount)

## Ein Histogramm der Verteilung der Schadenssumme eingeschränkt auf die Personen mit mindestens einem Schaden:
hist(amount[damage > 0])
## ... mit eigenen Klassengrenzen 
## (Beachte: Wegen der unterschiedlich breiten Intervalle wird jetzt aus der Frequency in der Vertikalen automatisch eine Density!):
hist(amount[damage > 0], breaks = c(0,500,1000,1500,3000))
## ... in Farbe und mit eigenem x-Achsen-Label und Titel:
hist(amount[damage > 0], breaks = c(0,500,1000,1500,3000), col = "tomato", xlab = "Schadenssumme (Personen mit mindestens einem Schadensfall)", main = "Histogramm der Verteilung der Schadenssummen")

## Auch geeignet: ein Boxplot!
boxplot(amount)
## ... eingeschränkt auf die Personen mit mindestens einem Schaden:
boxplot(amount[damage > 0])
## ... in Farbe und horizontal:
boxplot(amount[damage > 0], col="palegoldenrod", horizontal = TRUE)

## Zwei Boxplots im Vergleich: Schadenssumme nach Geschlecht:
boxplot(amount[damage > 0] ~ gender[damage > 0], col = "palegoldenrod", horizontal = TRUE)
## ... in verschieden Farben:
boxplot(amount[damage > 0] ~ gender[damage > 0], col = c("palegoldenrod","tomato4"), horizontal = TRUE)
## ... mit anderen Labels:
boxplot(amount[damage > 0] ~ gender[damage > 0], col = c("palegoldenrod","tomato4"), horizontal = TRUE, names = c("weiblich","männlich"))

## ... mit Whiskers vom Minimum zum Maximum (hier nicht empfehlenswert, warum?):
boxplot(amount[damage > 0] ~ gender[damage > 0], col = c("palegoldenrod","tomato4"), horizontal = TRUE, names = c("weiblich","männlich"), range = 0)


#########################################################################
## Speichern der Rhistory:
# savehistory("~/.../0_run_intro.R")
