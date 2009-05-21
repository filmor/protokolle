set terminal pdf

# Spektren
set xlabel 'Kanal'
set ylabel 'Ereignisse'
set style data impulses

datei = 'data/szinti_spektren.txt'

set output 'grafiken/coszinti.pdf'
set label 'Rückstreupeak' at 1360, 480
set label 'Comptonkante' at 5380, 300
set label 'Photopeak' at 7440, 650
plot datei u 0:2 notitle
unset label

set output 'grafiken/csszinti.pdf'
set label '?-Peak' at 233, 1020
set label 'Rückstreupeak' at 1280, 820
set label 'Comptonkante' at 2850, 360
set label 'Photopeak' at 4450, 1480
plot datei u 0:1 notitle
unset label

set output 'grafiken/euszinti.pdf'
set label '?-Peak' at 444, 3660
set label 'Rückstreupeak' at 855, 2050
set label 'Comptonkante' at 1670, 760
set label 'Peak 1' at 2350, 940
set label 'Peak 2' at 5090, 260
set label 'Peak 3' at 5850, 270
set label 'Peak 4' at 6500, 280
plot datei u 0:3 notitle
unset label

datei = 'data/halbleiter_spektren.txt'
set logscale y

set output 'grafiken/cohalb.pdf'
set label 'Rückstreupeak' at 960, 560
set label 'Comptonkante 1' at 4836, 540
set label 'Comptonkante 2' at 5650, 400
set label 'Peak 1' at 6230, 4530
set label 'Peak 2' at 7270, 4530
plot datei u 0:2 notitle
unset label

set output 'grafiken/cshalb.pdf'
set label 'Photopeak' at 3551, 30570
set label 'Comptonkante' at 2270, 970
set label 'Rückstreupeak' at 780, 990
plot datei u 0:1 notitle
unset label

set output 'grafiken/euhalb.pdf'
set label '121 keV' at 460, 34120
set label '244 keV' at 1120, 7330
set label '340 keV' at 1640, 15320
set label '778 keV' at 4000, 3220
set label '964 keV' at 4960, 2960
set label '1408 keV' at 7320, 2600
plot datei u 0:3 notitle
unset label

# Eichungen
set xlabel 'Kanal'
set ylabel 'Energie/keV'
set style data points
unset logscale y

s(x) = s_m * x + s_b
h(x) = h_m * x + h_b

datei = 'data/szinti_energien.txt'
fit s(x) datei u 1:2:(1/$3**2) via s_m, s_b
set output 'grafiken/eichung_szinti.pdf'
plot datei w xerrorbars notitle, s(x) notitle

datei = 'data/halbleiter_energien.txt'
fit h(x) datei via h_m, h_b
set output 'grafiken/eichung_halbleiter.pdf'
plot datei notitle, h(x) notitle

# geeichte Spektren
set xlabel 'Energie/keV'
set ylabel 'Ereignisse'
set style data lines

datei = 'data/szinti_spektren.txt'
set output 'grafiken/spektren_szinti.pdf'
plot datei u (s($0)):1 title 'Caesium', datei u (s($0)):2 title 'Kobalt',\
     datei u (s($0)):3 title 'Europium'

datei = 'data/halbleiter_spektren.txt'
set logscale y
set output 'grafiken/spektren_halbleiter.pdf'
plot datei u (h($0)):1 title 'Caesium', datei u (h($0)):2 title 'Kobalt',\
     datei u (h($0)):3 title 'Europium'

# Bodenprobe
set output 'grafiken/bodenprobe.pdf'
unset logscale y
set yrange [0:]
plot 'data/bodenprobe.txt' u (h($0)):($1-$2) notitle w impulses

set print 'data/szinti_halbwertsbreiten.txt'
print '# E sigma dsigma fwhm dfwhm'
d = 'data/fit_peak.plot'
f = "data/szinti_spektren.txt"
call d f 1 4319 400 1656 s_m s_b
call d f 2 7170 500 730 s_m s_b
call d f 3 2348 200 605 s_m s_b
call d f 3 289  200 3766 s_m s_b
call d f 3 4955 200 154 s_m s_b
call d f 3 6006 200 135 s_m s_b
call d f 3 6760 200 140 s_m s_b

set print 'data/halbleiter_halbwertsbreiten.txt'
print '# E sigma dsigma fwhm dfwhm'
f = "data/halbleiter_spektren.txt"
call d f 1 3500 8   21000 h_m h_b
call d f 2 6218 16  8800 h_m h_b
call d f 2 7065 15  7150 h_m h_b
print ''
print ''
call d f 3 632  8   25000 h_m h_b
call d f 3 1285 10  5400 h_m h_b
call d f 3 1814 10  12030 h_m h_b
call d f 3 4123 12  2295 h_m h_b
call d f 3 5108 12  1959 h_m h_b
call d f 3 7466 13  1753 h_m h_b

set print 'data/halbleiter_pulserbreiten.txt'
print '# mu sigma dsigma fwhm dfwhm'
f = "data/halbleiter_pulser.txt"
call d f 1 997  4   299 h_m h_b
call d f 2 1984 4   301 h_m h_b
call d f 3 2977 4   317 h_m h_b
call d f 4 3917 4   286 h_m h_b
call d f 5 4911 4   306 h_m h_b
call d f 6 5949 4   318 h_m h_b
call d f 7 6951 4   302 h_m h_b

# Intrinsische Halbwertsbreite
set xlabel 'sqrt(E)/sqrt(keV)'
set ylabel 'FWHM_i/keV'

E_e = 0.622448
dE_e = 0.006128

f(x) = sqrt(x**2 - E_e**2)
g(x) = C * x + B
set output 'grafiken/intrinsische_breite.pdf'
fit g(x) 'data/halbleiter_halbwertsbreiten.txt' u (sqrt($1)):(f($4)) via C, B
plot 'data/halbleiter_halbwertsbreiten.txt' u (sqrt($1)):(f($4)):(0) index 1 w yerrorbars notitle, g(x) notitle

