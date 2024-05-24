function grad = Rosenbrock_grad(alpha, x)
    n = length(x);
    x_odd = x(1:2:end);
    x_even = x(2:2:end);

    grad = zeros(n, 1);

    grad(1:2:end) = 4 * alpha .* x_odd .* (x_odd .^ 2 - x_even) + 2 * (x_odd - 1);
    grad(2:2:end) = 2 * alpha .* (x_even - x_odd .^ 2);
end