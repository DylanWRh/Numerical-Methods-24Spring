function [fs, x_opt, f_opt] = SteepestDescent(x0, f, grad_f, maxiter, tol, alpha_init)
    % Set default parameters
    if nargin < 4
        maxiter = 10000;
    end
    if nargin < 5
        tol = 1e-8;
    end
    if nargin < 6
        alpha_init = 0.1; % Initial step size
    end

    % Initialize
    x = x0;
    fs = [f(x0)];
    i = 0;
    gnorm = inf;
    alpha = alpha_init;

    % Start iteration
    while i < maxiter && gnorm > tol
        % Evaluate gradient
        g = grad_f(x);

        % Line search to find optimal alpha
        phi = @(a) f(x - a * g);
        [alpha_k, ~] = fminbnd(phi, 0, alpha);

        % Steepest descent step
        x = x - alpha_k * g;

        % Update iteration number
        i = i + 1;

        % Compute function value and gradient norm
        fs = [fs; f(x)];
        gnorm = norm(g);
    end

    % Set outputs
    x_opt = x;
    f_opt = f(x_opt);
end
