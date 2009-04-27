set terminal pdf
set output 'c.pdf'

set title 'Halbschattenpolarimeter'

set autoscale

set xlabel 'Konzentration / (mol/l)'
set ylabel 'd_phi/°'

set xrange [0:6]

set mxtics 5
set mytics 5
set grid xtics ytics mxtics mytics
set key bottom right

phi_0 = 84
d_phi(y) = y - phi_0
dd_phi(y) = sqrt(2) * 0.5 # * d_phi(y)

f(x) = m * x + b

fit f(x) 'c.txt' using 1:(d_phi($2)) via m, b

plot 'c.txt' using 1:(d_phi($2)):(0.01):(dd_phi($2)) with xyerrorbars notitle,\
    f(x) notitle, d_phi(37.1) title 'A'

