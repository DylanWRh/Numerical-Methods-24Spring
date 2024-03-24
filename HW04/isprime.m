function res = isprime(n)
    if n <= 1
        res = false;
        return;
    end

    for i = 2 : sqrt(n)
        if mod(n, i) == 0
            res = false;
            return;
        end
    end

    res = true;
    return;
end
