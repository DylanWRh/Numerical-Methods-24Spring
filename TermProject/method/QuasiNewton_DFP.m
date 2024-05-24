function [fs, x_opt, f_opt] = QuasiNewton_DFP(x0, f, grad_f, maxiter, tol)
    % Set default params
    if nargin < 5
        tol = 1e-8;
    end
    if nargin < 4
        maxiter = 10000;
    end

    % Initialize
    x = x0;
    fs = [f(x0)];
    i = 0;
    gnorm = inf;
    g = grad_f(x);
    n = length(x);
    H = eye(n);
    d = -H * g;

    % Start iteration
    while i < maxiter && gnorm > tol
        % Update x and grad
        x_new = x + d;
        g_new = grad_f(x_new);

        % Update H
        s = d;
        y = g_new - g;
        H = H + (s * s') / (s' * y) - (H * y * y' * H) / (y' * H * y); 

        % Update direction
        d = -H * g_new;

        % Update for next iteration
        x = x_new;
        g = g_new;
        gnorm = norm(g);
        fs = [fs; f(x)];
        i = i + 1;
    end

    % Set outputs
    x_opt = x;
    f_opt = f(x_opt);
end

