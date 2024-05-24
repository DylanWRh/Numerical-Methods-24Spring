function [fs, x_opt, f_opt] = GradientDescent(x0, f, grad_f, maxiter, tol, alpha)
    % Set default parameters
    if nargin < 4
        maxiter = 10000;
    end
    if nargin < 5
        tol = 1e-8;
    end
    if nargin < 6
        alpha = 0.001; % Default learning rate
    end

    % Initialize
    x = x0;
    fs = [f(x0)];
    i = 0;
    gnorm = inf;

    % Start iteration
    while i < maxiter && gnorm > tol
        % Evaluate gradient
        g = grad_f(x);

        % Gradient descent step
        x = x - alpha * g;

        i = i + 1;

        % Compute function value and gradient norm
        fs = [fs; f(x)];
        gnorm = norm(g);
    end

    % Set outputs
    x_opt = x;
    f_opt = f(x_opt);
end
