set terminal jpeg size 1024,768
set output "248b3.jpg"
set title 'Dritte Messungen'
set xlabel 'Magnetfeld B'
set ylabel 'Magnetische Erregung H'
set grid
plot '248ba3.dat' u 1:3:2:4 w xyerrorbars t 'Fehlerbalken des Hysteresezyklus', '248ba3.dat' u 1:3 w lp t 'Hysteresezyklus', '248bb3.dat' u 1:3:2:4 w xyerrorbars t 'Fehler der Neukurve', '248bb3.dat' u 1:3 w lp t 'Neukurve'
