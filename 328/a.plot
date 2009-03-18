set terminal pdf
set output 'a.pdf'

set xtics 30
set ytics 0.1

set title "Ansprechzeit" 

set xlabel "Zeit t/s" 
set xlabel  offset character 0, 0, 0 font "" textcolor lt -1 norotate

plot "a.txt" u 1:($2/81.13):(0.01) with yerrorbars notitle, 0.9 notitle
