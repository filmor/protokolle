set terminal pdf
set output 'a.pdf'

dx = 0.1

dB = 0.05

G = 2.4
dG = 0.2

set fit errorvariables

g1(x) = f1*(1+1/x) + h1
g2(x) = f2*(1+x) + h2

Gamma(x) = x/G

set xlabel 'Abbildungsmaﬂstab Gamma'
set ylabel 'Entfernung x/cm'

fit g1(x) 'a.txt' u (Gamma($3)):($1) via f1,h1
fit g2(x) 'a.txt' u (Gamma($3)):($2) via f2,h2

plot 'a.txt' u (Gamma($3)):($1):(Gamma($3)*sqrt(dB**2 + (dG/G)**2)):(dx) \
    w xyerrorbars notitle, g1(x) notitle
set ylabel "Entfernung x'/cm"
plot 'a.txt' u (Gamma($3)):($2):(Gamma($3)*sqrt(dB**2 + (dG/G)**2)):(dx) \
    w xyerrorbars notitle, g2(x) notitle

