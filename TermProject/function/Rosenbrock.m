function result = Rosenbrock(alpha, x)
    x_odd = x(1:2:end);
    x_even = x(2:2:end);
    result = sum(alpha * (x_even - x_odd .^ 2) .^ 2 + (1 - x_odd) .^ 2);
end
