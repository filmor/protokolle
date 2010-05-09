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

plot_cmd = "plot datei u 2:1 title 'Strom' lc rgbcolor 'red', \
            datei u 2:($2 * $1) axes x1y2 title 'Leistung' lc rgbcolor 'blue', \
            i(x) lc rgbcolor 'dark-red' notitle, \
            p(x) axes x1y2 lc rgbcolor 'dark-blue' notitle;"

fit_cmd = "fit i(x) datei u 2:1 via A, B, C;".plot_cmd

zeile = "%s & $\\unit[%.3f]{mW}$ & $%.2f$ & $\\unit[%.2f]{\\\%}$ \\\\ "
tex_cmd1 = "print sprintf(zeile, typ.' innen', max_p(0), ff(0), eta(0)*100);"
tex_cmd2 = "print sprintf(zeile, typ.' außen', max_p(0), ff(0), eta(0)*100);"

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
# Fläche
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
plot_cmd = "datei u 2:1 title 'Strom' lc rgbcolor 'red', \
            datei u 2:($2 * $1) axes x1y2 title 'Leistung' lc rgbcolor 'dark-red',\
            datei2 u 2:1 title 'Strom (abgeschattet)' lc rgbcolor 'blue', \
            datei2 u 2:($2 * $1) axes x1y2 title 'Leistung (abgeschattet)' lc rgbcolor 'dark-blue';"
cmd = "set output 'grafiken/'.typ.'.tikz';\
       datei = 'data/05_'.typ.'.txt';\
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
plot datei u 2:1 title 'Strom (Zelle 2)' lc rgbcolor 'blue', \
     datei u 2:($2 * $1) axes x1y2 title 'Leistung (Zelle 2)' lc rgbcolor 'dark-blue',\
     datei2 u 2:1 title 'Strom (Zelle 3)' lc rgbcolor 'red', \
     datei2 u 2:($2 * $1) axes x1y2 title 'Leistung (Zelle 3)' lc rgbcolor 'dark-red'

reset

# =====================================================================================
set output 'grafiken/wellenlaenge.tikz'
set yrange [0:1.3]

set xlabel '$\lambda/\unit{nm}$'

f(x) = -0.7723 + 0.0077 * x - 1.11280e-5*x**2 + 5.3942e-9*x**3

plot 'data/03_indoor.txt' u 1:(f($1)*$2/1362):(2):(0.01*$2/1362) w xyerr title 'Indoorzelle', \
     'data/03_outdoor.txt' u 1:(f($1)*$2/456):(2):(0.01*$2/456) w xyerr title 'Outdoorzelle', \
     'data/03_poly.txt' u 1:(f($1)*$2/15):(2):(0.01*$2/15) w xyerr title 'Polykristalline Zelle'

reset
# =================================================
set output 'grafiken/bsz_kennlinie_solarzelle.tikz'
set xlabel '$I/\unit{A}$'
set ylabel '$U/\unit{V}$'
set y2label '$P/\unit{W}$'

datei = 'data/bsz/01_solarzelle.txt'
set yrange [0:0.6]
plot datei i 0 u 1:2 title 'Spannung (Solarzelle H)' lc rgbcolor 'red', \
     datei i 0 u 1:($2*$1) axes x1y2 title 'Leistung (Solarzelle H)' lc \
                            rgbcolor 'dark-red', \
     datei i 1 u 1:2 title 'Spannung (Solarzelle N)' lc rgbcolor 'blue',\
     datei i 1 u 1:($2*$1) axes x1y2 title 'Leistung (Solarzelle N)' lc rgbcolor \
                            'dark-blue', \
     'data/bsz/01_elektrolyseur.txt' u 2:1 title 'Spannung (Elektrolyseur)' lc \
        rgbcolor 'green', \
     'data/bsz/01_elektrolyseur.txt' u 2:($1*$2) axes x1y2 title 'Leistung (Elektrolyseur)' lc \
        rgbcolor 'dark-green'

reset
set output 'grafiken/kennlinie_brennstoffzelle.tikz'
set xlabel '$I/\unit{mA}$'
set ylabel '$U/\unit{V}$'
set y2label '$P/\unit{W}$'
datei = 'data/bsz/02_kennlinie_bsz.txt'
f(x) = m*x + b
fit f(x) datei i 0 u 3:($2>300?$2<700?$2/1e3:1/0:1/0) via m, b
plot datei i 0 u 3:($2/1e3) lc rgbcolor 'blue' tit 'Spannung',\
         datei i 1 u 3:($2/1e3) tit 'Spannung (Motor)' lc rgbcolor 'green',\
         datei i 0 u 3:($2*$3/1e3) axes x1y2 tit 'Leistung' lc rgbcolor 'dark-blue',\
         datei i 1 u 3:($2*$3/1e3) axes x1y2 tit 'Leistung (Motor)' lc rgbcolor 'dark-green',\
         f(x) notitle

# ====================================================
reset

set output 'grafiken/wirkungsgrad_elek.tikz'
set xlabel '$t/\unit{min}$'
set ylabel '$V/\unit{ml}$'
set xrange [0:]
set yrange [0:]

f(x) = m_1 * x + b_1
g(x) = m_2 * x + b_2

fit f(x) 'data/bsz/02_wirkungsgrad_elektrolyseur.txt' via m_1, b_1
fit g(x) 'data/bsz/02_wirkungsgrad_elektrolyseur_300mA.txt' via m_2, b_2

plot 'data/bsz/02_wirkungsgrad_elektrolyseur.txt' u 1:2:(0.5) w yerr tit \
     '$I=\unit[1]{A}$' lc rgbcolor 'red', f(x) notit lc rgbcolor 'dark-red', \
     'data/bsz/02_wirkungsgrad_elektrolyseur_300mA.txt' u 1:2:(0.5) w yerr tit \
     '$I=\unit[300]{mA}$' lc rgbcolor 'green', g(x) notit lc rgbcolor 'dark-green'

reset
# ===========================================================================
set xlabel 'Zeit/\unit{h}'
set ylabel 'Leistung/\unit{W}'

set style lines

plot_cmd = 'set output "grafiken/leistung_".tag.".tikz";\
            datei="data/tag_".tag.".txt";\
            plot datei u 1:11 title "Sonne" w lines,\
            datei u 1:4 w lines title "Solarzelle (geführt)",\
            datei u 1:7 w lines title "Solarzelle (fest)"'

tag = 'a'
@plot_cmd
tag = 'b'
@plot_cmd
tag = 'c'
@plot_cmd

