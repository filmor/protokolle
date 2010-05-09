{
    if (!last_time == 0)
    {
        delta = $1 - last_time;
        energy_1 += $4 * delta;
        energy += $11 * delta;
        energy_2 += $7 * delta;
    };
    last_time = $1
}
END {
    print energy, energy_1, energy_1/energy, energy_2, energy_2/energy;
}
