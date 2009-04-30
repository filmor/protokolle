set terminal pdf
set output 'fe.pdf'
set dgrid3d 15,15, 1
set pm3d interpolate 2,2 flush begin noftriangles nohidden3d corners2color mean
splot 'f.txt' u 1:2:($3-1.44) w pm3d title 'Plot zu f', 'e.txt' u 1:2:($3-3.88) w pm3d title 'Plot zu e'

set xlabel 'x'
set ylabel 'y'
set zlabel 'Helligkeit ohne Hintergrund in Lux'

set output 'ga.pdf'
set title 'Plane Seite zur Wand'
splot 'ga.txt' u 1:2:($3-1.2) w pm3d notitle
set output 'gb.pdf'
set title 'Gewölbte Seite zur Wand'
splot 'gb.txt' u 1:2:($3-1.2) w pm3d notitle

