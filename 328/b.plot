set terminal pdf size 16cm, 10cm
set output 'b.pdf'

set title ''

set autoscale

set xlabel 'Temperaturdifferenz^4 dT^4/K^4 * 10^-12'
set ylabel 'Intensität phi/F / W/m^2'

# set logscale x
# set logscale y

set mxtics 5
set mytics 5
set grid xtics ytics mxtics mytics
set key bottom right

# Sensitivität
S = 29e-6
# Verstärkungsfaktor
V = 100 * 1000 # da mV
# Detektorfläche
F = 113e-6

sigma = 5.6704e-8

T(x) = (x/1000 - 0.021 + 0.27315)**4 / 10
# phi / F
phi(x) = (x + -0.3) / (V * S)
dT(x) = 4.24 * 1e-6
dphi(x) = 1.7e-2

weiss_m = 0.6
weiss_b = 30
schwarz_m = weiss_m
schwarz_b = weiss_b
matt_m = weiss_m
matt_b = weiss_b
poliert_m = weiss_m
poliert_b = weiss_b

weiss(x) = x * weiss_m + weiss_b
schwarz(x) = x * schwarz_m + schwarz_b
matt(x) = x * matt_m + matt_b
poliert(x) = x * poliert_m + poliert_b

schwarzer_koerper(x) = x * sigma * 1e12

fit weiss(x) 'b.txt' using (T($1)):(phi($2)):(1/dT($1)**2) via weiss_m, weiss_b
fit schwarz(x) 'b.txt' using (T($1)):(phi($3)):(1/dT($1)**2) via schwarz_m, schwarz_b
fit matt(x) 'b.txt' using (T($1)):(phi($4)):(1/dT($1)**2) via matt_m, matt_b
fit poliert(x) 'b.txt' using (T($1)):(phi($5)):(1/dT($1)**2) via poliert_m, poliert_b

plot  'b.txt' using (T($1)):(phi($2)):(dT($1)):(dphi($2)) lt 1 with xyerrorbars title 'weiß', \
	'b.txt' using (T($1)):(phi($3)):(dT($1)):(dphi($3)) lt 2 with xyerrorbars title 'schwarz', \
	'b.txt' using (T($1)):(phi($4)):(dT($1)):(dphi($4)) lt 3 with xyerrorbars title 'matt', \
	'b.txt' using (T($1)):(phi($5)):(dT($1)):(dphi($5)) lt 4 with xyerrorbars title 'poliert', \
	weiss(x) lt 1 notitle, \
	schwarz(x) lt 2 notitle, \
	matt(x) lt 3 notitle, \
	poliert(x) lt 4 notitle, \
	schwarzer_koerper(x) title 'Schwarzer Körper'

print "eps_weiss:\t", weiss_m / sigma * 1e-12
print "eps_schwarz:\t", schwarz_m / sigma * 1e-12
print "eps_matt:\t", matt_m / sigma * 1e-12
print "eps_poliert:\t", poliert_m / sigma * 1e-12
