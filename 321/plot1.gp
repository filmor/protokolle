set terminal pdf
set output 'plot1.pdf'

FIT_LIMIT=1e-14

set angles degrees
set fit errorvariables

set xlabel "Wellenlänge Lambda/nm"

set ylabel "Brechungsindex n"

da = 0.001
delta = 59.9125
n(x) = sin((x+delta)/2.0)/sin(delta/2.0)

f(x) = k_0 + k_1/x**2

fit f(x) 'daten1.txt' u 1:(n($2)) via k_0, k_1

plot 'daten1.txt' u 1:(n($2)):(n($2)/2.0*tan(($2+delta)/2.0)*da) with yerrorbars notitle, f(x) notitle

print k_0, "+-", k_0_err, " ", k_1, "+-", k_1_err
