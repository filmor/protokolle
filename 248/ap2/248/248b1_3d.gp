set terminal jpeg size 1024,768
set output "248b1_3d.jpg"
set title 'Erste Messungen'
set xlabel 'Magnetfeld B'
set ylabel 'Magnetische Erregung H'
set zlabel 'Fehler H'
set grid
splot '248ba1.dat' u 1:3:4 w p t 'Hysteresezyklus', '248bb1.dat' u 1:3:4 w p t 'Neukurve'
