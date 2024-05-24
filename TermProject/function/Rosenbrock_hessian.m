function hessian = Rosenbrock_hessian(alpha, x)

    n = length(x);
    hessian = zeros(n, n);

    x_odd_idx = 1:2:n;
    x_even_idx = 2:2:n;
    
    x_odd = x(x_odd_idx);
    x_even = x(x_even_idx);
    
    hessian(sub2ind([n,n], x_odd_idx, x_odd_idx)) = 12 * alpha * x_odd .^ 2 - 4 * alpha * x_even + 2;
    hessian(sub2ind([n,n],x_even_idx, x_even_idx)) = 2 * alpha;
    hessian(sub2ind([n,n],x_odd_idx, x_even_idx)) = -4 * alpha * x_odd;
    hessian(sub2ind([n,n],x_even_idx, x_odd_idx)) = -4 * alpha * x_odd;
end
