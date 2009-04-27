set terminal pdf
set output 'b.pdf'

set autoscale

set title 'Rotation einer Quarzplatte'

set xlabel '(1/lambda^2) / (1/µm^2)'
set ylabel 'I'

set mxtics 5
set mytics 5
set grid xtics ytics mxtics mytics
set key bottom right

set angles degrees

phi_0 = -90

phi(x) = (x - phi_0 < 90) ? (x - phi_0 + 180) : (x - phi_0)

dphi(x) = sqrt(10)

X(x) = (1.0/(x*1e-3))**2

f(x) = B * x + A

fit f(x) 'b.txt' using (X($1)):(phi($2)) via A, B

plot 'b.txt' using (X($1)):(phi($2)):(dphi($2)) with yerrorbars notitle, f(x) notitle

