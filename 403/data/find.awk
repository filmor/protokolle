{
    eps = 0.1
    eps_d = 0.01
    n = n + 1
    prev_d = d
    d = $2 - prev
    if(and(prev_d > 0, d < 0))
        if(and(prev_d - d > eps_d, $2 > eps))
            print n, prev_d, d, $2
    prev = $2
}
