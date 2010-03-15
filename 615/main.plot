set term lua solid

FIT_LIMIT=1e-7

set angles rad

eta(I, J) = I / (I + J)
dn(I, J) = asin(sqrt(eta(I,J))) * cos(0.15) * 633e-6 / pi
dI = 0.5e1
d_eta(I, J) = sqrt((J**2 + 1))/((J**2 + I**2)**2) * dI

set xlabel '$t/\unit{min}$'
set ylabel '$\Delta n$'

set output 'grafiken/schreibkurve.tikz'
s(t) = A * (1 - exp(-t/tau)) - B
fit s(x) 'data/schreiben2.txt' u ($1>5?$1:1/0):(dn($2,$3)) via tau, A, B
plot 'data/schreiben2.txt' u 1:(dn($2,$3)):(0.1):(d_eta($2,$3)) w xyerrorbars \
    notitle, s(x) notitle

set output 'grafiken/loeschkurve.tikz'
l(t) = A * exp(-t/tau)
fit l(x) 'data/loeschen.txt' u 1:(dn($2,$3/10)) via A, tau
plot 'data/loeschen.txt' u 1:(dn($2,$3/10)):(0.1):(d_eta($2,$3)) w xyerrorbars notitle, l(x) notitle

set xlabel 'Winkel/$\unit{^\circ}$'
set ylabel '$\eta$'
set output 'grafiken/rockingkurve.tikz'

set angles rad
set samples 5e3
phi(x) = asin(sin(x * 0.228 * pi / 180)/2.33) + 0.011 + 0.15
eta_0 = 1.8e3
N = 0.01
# set xrange [-0.053:0]
nu(x) = pi * 1e-3 * N / (633e-9 * cos(x))
xi(x) = 6.822e6*1e-3/2 * (x - 0.15)
r(w) = 0*nu(w)**2 * sin(sqrt(nu(w)**2 + xi(w)**2))**2 / (nu(w)**2 + xi(w)**2)
# fit r(x) 'data/winkel2.txt' u (phi($1)):(eta($2,eta_0)) via N
plot 'data/winkel2.txt' u (phi($1)):(eta($2,eta_0)) smooth csplines notitle, \
     'data/winkel2.txt' u (phi($1)):(eta($2,eta_0)):(d_eta($2,eta_0)*10) w yerrorbars notitle#, r(x) notitle
