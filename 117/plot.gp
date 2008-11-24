set terminal pdf
set output '$0.pdf'

set title '$0'

set xlabel 't / s'
set ylabel 'T / °C'

set xtics 60
set mxtics 30

unset key

set autoscale

v(x) = a * x + b
n(x) = c * x + d

fit v(x) '$0' using (column(0) * 30):(column(1) < 20 ? column(1) : 1/0) via a, b
fit n(x) '$0' using (column(0) * 30):(column(0) > $1 ? column(1) : 1/0) via c, d

plot '$0' using (column(0) * 30):1, v(x), n(x)
