##################################################################
##
## Aufgabe 5 --- Loesung mit R
##
## Viel Erfolg! Angi & Harald, 2022
##################################################################

cat('\nAufgabe 5 --- Loesung mit R\n\n')

cat('\nEin Excel-Datenblatt kann mit Hilfe des R Package "readxl" eingelesen werden:\n 
Hadley Wickham und Jennifer Bryan, 2019. readxl: Read Excel Files.\n
Zuvor muss es geladen (und vorher ggfs. noch installiert) werden!\n\n')

library('readxl')

my.data = read_excel('insurance_data_clean.xls', sheet = 'data', range = cell_cols('A:F'))
damage = my.data$`number of damages in 2008`
amount = my.data$`amount of damage in 2008`

cat('\nb) Personen mit (mindestens) einem Schaden:\n')

cat('\nDie Antwort könnte man aus der Häufigkeitsverteilung der Ergebnisse bei der logischen Abfrage nach (mindestens) einem Schaden ablesen:\n')
print( table(damage>0) )

cat('\nNoch eleganter: wir summieren über TRUE (=1) und FALSE (=0) und bekommen direkt...\n')
print( sum(damage>0) )
cat('... die Antwort auf die Frage aller Fragen :)\n\n')

cat('\nc) Durchschnittliche Schadenssumme pro Person mit Schaden:\n\n')

cat('Der folgende Mittelwert ist nicht der richtige? Warum?\n')
print( mean(amount) )
cat('Nach diesem Mittelwert wird hier gefragt:\n')
print( mean(amount[damage>0]) )

