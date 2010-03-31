set term lua solid

set xlabel '$\theta/^\circ$'
set ylabel 'n'

set xtics 30

set output 'grafiken/cos2theta.tikz'

bin(x,width) = width*floor(x/width)
f(x,y) = (x<0?-pi/2:pi/2) + acos(cos(x)*sin(atan(y)))
bw = 5
set boxwidth 5 absolute
plot '< data/read_data.py data' u (bin(f($1,$2)/pi * 180,bw)):(1.0) smooth freq\
         w boxes title 'Daten', cos(x*pi/180)**2 * 70 notitle
