set terminal pdf
set output 'c.pdf'

# Sensitivität
S = 29e-6
# Verstärkungsfaktor
V = 100 * 1000 # da mV

phi(x) = (x + -0.3) / (V * S)
dphi(x) = 1.7e-2

d(x) = x
dd(x) = 0.005

dI(x) = 0.01 * x

alpha = 4.82e-3
beta = 6.76e-7
R_0 = 0.2
T_0 = (21 + 273.15)

R(x,y) = x / y

FIT_LIMIT=1e-16
T_I(x,y) = (T_0 + (sqrt(4 * beta * (R(x,y) - R_0) + alpha**2) - alpha)/(2*beta))

dT_I(x) = 0.00001

d = 4

f1(x) = a + b/x**2
f2(x) = c * x ** d


fit f1(x) 'c.1.txt' using (d($1)):(phi($2)):(dd($1)) via a, b
fit f2(x) 'c.2.txt' using (T_I($2,$1)):(phi($2)):(dT_I($1)) via c, d

set title 'Abstandsabhängigkeit'

set xlabel "Abstand d/cm"
set ylabel "Intensität phi/F / W/m²"

plot 'c.1.txt' using (d($1)):(phi($2)):(dd($1)):(dphi($2)) with xyerrorbars notitle, f1(x) notitle
 
set title 'Stefan-Boltzmann-Gesetz und Emissionsgrad der Halogenlampe'

set logscale x
set logscale y

set xlabel "Temperatur des Strahlers T/kK"

set xrange [500:1000]

plot 'c.2.txt' using (T_I($2,$1)):(phi($2)):(dT_I($1)):(dphi($2)) with xyerrorbars notitle, f2(x) notitle
