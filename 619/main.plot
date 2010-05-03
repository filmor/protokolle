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

