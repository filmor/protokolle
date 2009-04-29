set terminal pdf
set output 'a.pdf'

set autoscale

set title 'Malussches Gesetz'

set xlabel 'phi/°'
set ylabel 'I_norm'

set mxtics 5
set mytics 5
set grid xtics ytics mxtics mytics
set key bottom right

set angles degrees

I_max = 691
I_min = 118

I_norm(x) = (x - I_min) / (I_max - I_min)
dI_norm(x) = 0.5 * sqrt((I_max - I_min)**2 + (I_max - x)**2 + (I_min - x)**2)/(I_max - I_min)**2

f(x) = I0 * cos(x - phi0)**2

dphi(x,y) = (x < 24) ? y - 90 : y + 90
ddphi(x,y) = sqrt(2) * 0.5

fit f(x) 'a.txt' using (dphi($0,$1)):(I_norm($2)):(1/dI_norm($2)**2) via phi0, I0

plot 'a.txt' using (dphi($0,$1)):(I_norm($2)):(ddphi($0,$1)):(dI_norm($2)) with xyerrorbars notitle, f(x) notitle

