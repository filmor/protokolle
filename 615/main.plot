set term lua solid

FIT_LIMIT=1e-7

set angles degrees

eta(I, J) = I / (I + J)
dn(I, J) = asin(sqrt(eta(I,J))) * cos(8.631) * 633e-6 / pi
dI = 0.5e3
d_eta(I, J) = sqrt((J**2 + 1))/((J**2 + I**2)**2) * dI

set xlabel '$t/\unit{min}$'
set ylabel '$\Delta n$'

set output 'grafiken/schreibkurve.tikz'
s(t) = A * (1 - exp(-t/tau)) - B
fit s(x) 'data/schreiben2.txt' u ($1>5?$1:1/0):(dn($2,$3)) via tau, A, B
plot 'data/schreiben2.txt' u 1:(dn($2,$3)):(0.1):(d_eta($2,$3)) w xyerrorbars \
    notitle, s(x) notitle

set output 'grafiken/loeschkurve.tikz'
l(t) = A * exp(-t/tau) - B
fit l(x) 'data/loeschen.txt' u 1:(dn($2,$3*10)) via A, B, tau
plot 'data/loeschen.txt' u 1:(dn($2,$3*10)):(0.1):(d_eta($2,$3)) w xyerrorbars notitle, l(x) notitle

set xlabel 'Winkel/$\unit{^\circ}$'
set ylabel '$\eta$'
set output 'grafiken/rockingkurve.tikz'
th_bragg = -8
K = 0

r(w) = 800 * sin(B/cos(w-T))**2
fit r(x) 'data/winkel2.txt' via B, T
plot 'data/winkel2.txt' u 1:2 notitle, r(x) notitle
