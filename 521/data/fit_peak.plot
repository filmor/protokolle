k = sqrt(2*log(2))
sigma = $3 * k
mu = $2
intervall = sigma * 3
datei = $0
spalte = $1
hoehe = $4
e(x) = $5 * x + $6

set fit errorvariables

f(x) = hoehe*exp(-((x-mu)/sigma)**2) + C

fit f(x) datei using ($$0<mu+intervall&&$$0>mu-intervall?$$0:1/0):spalte via \
hoehe,mu,sigma,C

print sprintf("%f   %f   %f  %f  %f", e(mu), abs(sigma), sigma_err, abs(sigma)/k, \
        sigma_err/k)

