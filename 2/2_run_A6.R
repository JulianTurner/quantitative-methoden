##################################################################
##
## Aufgabe 6 --- Loesung mit R
##
## Viel Erfolg! Angi & Harald, 2022
##################################################################

cat('\nAufgabe 6 --- Loesung mit R\n\n')

cat('\nEin Excel-Datenblatt kann mit Hilfe des R Package "readxl" eingelesen werden:\n 
Hadley Wickham und Jennifer Bryan, 2019. readxl: Read Excel Files.\n
Zuvor muss es geladen (und vorher ggfs. noch installiert) werden!\n\n')

library('readxl')

my.data = read_excel('bank_customers.xls', sheet = 'data', range = cell_cols('A:H'))
deficit   = my.data$deficit
age       = my.data$age
cellphone = my.data$cellphone

cat('\nb) Prozentsatz der Kunden mit deficit = 1:\n')
print( mean(deficit)*100 )

cat('\nc) Durchschnittliches Alter der Kunden mit deficit = 0:\n')
print( mean(age[deficit == 0]) )

cat('\nd) Durchschnittliches Alter der Kunden mit deficit = 1:\n')
print( mean(age[deficit == 1]) )

cat('\ne) Prozentsatz der Kunden mit deficit = 1 unter den Kunden mit...\n\n')
cat('... cellphone = 0:\n')
print( 100*mean(deficit[cellphone == 0]) )
cat('... cellphone = 1:\n')
print( 100*mean(deficit[cellphone == 1]) )
cat('... cellphone = 2:\n')
print( 100*mean(deficit[cellphone == 2]) )
cat('\nAlternative Berechnung...\n')
print( 100*proportions( table(cellphone, deficit), margin = 'cellphone') )