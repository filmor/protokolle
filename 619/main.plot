#!/usr/bin/env gnuplot
set terminal lua solid
set print 'data/daten_solarzelle.tex'

set macros
set xlabel '$U/\unit{V}$'
set ylabel '$I/\unit{mA}$'
set y2label '$P/\unit{mW}$'
set y2tics
set ytics nomirror
set yrange [0:]
set y2range [0:]
set xrange [0:]

plot_cmd = "plot datei u 2:1 title 'Strom' lc 1, \
            datei u 2:($2 * $1) axes x1y2 title 'Leistung' lc 2, \
            i(x) lc 1 notitle, \
            p(x) axes x1y2 lc 2 notitle;"

fit_cmd = "fit i(x) datei u 2:1 via A, B, C;".plot_cmd

zeile = "%s & $\\unit[%.3f]{mW}$ & $%.2f$ & $\\unit[%.2f]{\\\%}$ \\\\ "
tex_cmd1 = "print sprintf(zeile, typ.' innen', max_p(0), ff(0), eta(0)*100);"
tex_cmd2 = "print sprintf(zeile, typ.' auﬂen', max_p(0), ff(0), eta(0)*100);"

cmd = "set output 'grafiken/kennlinie_'.typ.'_innen.tikz'; \
       datei = 'data/01_'.typ.'.txt';Int=24;".fit_cmd.tex_cmd1
cmd2 = "set output 'grafiken/kennlinie_'.typ.'_aussen.tikz'; \
        datei = 'data/02_'.typ.'.txt';Int=250;".fit_cmd.tex_cmd2
i(x) = A + B * exp(C * x)
p(x) = i(x) * x
mpp(x) = (lambertw(-exp(1)*A/B) - 1)/C
max_p(x) = p(mpp(0))
ff(x) = max_p(0) / (i(0) * log(-A/B)/C)
eta(x) = max_p(0) * 1e-3 / (Int * Fl)
FIT_LIMIT=1e-20
# Fl‰che
Fl = 0.01
typ='amorph'
A = 0.7; B = -0.008; C = 0.64;
@cmd
A = 17; B = -0.05; C = 0.65;
@cmd2
Fl = 0.01
typ='poly'
A = 0.7; B = -2.5e-5; C = 1.4;
@cmd
A = 38; B = -0.07; C = 0.7;
@cmd2
Fl = 0.01
typ='mono'
A = 32; B = -6; C = 5;
@cmd
A = 822; B = -119; C = 4;
@cmd2

# =====================================================================================
plot_cmd = "datei u 2:1 title 'Strom', \
            datei u 2:($2 * $1) axes x1y2 title 'Leistung',\
            datei2 u 2:1 title 'Strom (abgeschattet)', \
            datei2 u 2:($2 * $1) axes x1y2 title 'Leistung (abgeschattet)';"
cmd = "set output 'grafiken/'.typ.'.tikz';\
       datei = 'data/05_'.typ.'.txt';coffset=0;\
       datei2 = 'data/05_'.typ.'_abgeschattet.txt';\
       plot ".plot_cmd.";"

set xlabel '$U/\unit{mV}$'
set y2label '$P/\unit{\mu W}$'
typ = 'reihe'; @cmd
set xlabel '$U/\unit{V}$'
set y2label '$P/\unit{mW}$'
typ = 'parallel'; @cmd

set output 'grafiken/zellen.tikz'
datei = 'data/05_zelle2.txt'
datei2 = 'data/05_zelle3.txt'
set yrange [0:8]
plot datei u 2:1 title 'Strom (Zelle 2)', \
     datei u 2:($2 * $1) axes x1y2 title 'Leistung (Zelle 2)',\
     datei2 u 2:1 title 'Strom (Zelle 3)', \
     datei2 u 2:($2 * $1) axes x1y2 title 'Leistung (Zelle 3)'

reset

# =====================================================================================
set output 'grafiken/wellenlaenge.tikz'
set yrange [0:1.3]

set xlabel '$\lambda/\unit{nm}$'

f(x) = -0.7723 + 0.0077 * x - 1.11280e-5*x**2 + 5.3942e-9*x**3

plot 'data/03_indoor.txt' u 1:(f($1)*$2/1362):(2):(0.01*$2/1362) w xyerr title '\small Indoorzelle', \
     'data/03_outdoor.txt' u 1:(f($1)*$2/456):(2):(0.01*$2/456) w xyerr title '\small Outdoorzelle', \
     'data/03_poly.txt' u 1:(f($1)*$2/15):(2):(0.01*$2/15) w xyerr title '\small Polykristalline Zelle'


