function [fs, x_opt, f_opt] = Newton(x0, f, grad_f, hessian_f, maxiter, tol)
    
    % Set default parameters
    if nargin < 5
        maxiter = 10000;
    end
    if nargin < 6
        tol = 1e-8;
    end

    % Initialize
    x = x0;
    fs = [f(x0)];
    i = 0;
    gnorm = inf;

    % Start iteration
    while i < maxiter && gnorm > tol
        % Evaluate gradient and Hessian
        g = grad_f(x);
        H = hessian_f(x);
        
        % Newton step given by -H^{-1} g
        delta_x = -H \ g;

        % Update new x and iter number
        x = x + delta_x;
        i = i + 1;

        % Compute function value and gradient norm
        fs = [fs; f(x)];
        gnorm = norm(g);
    end

    % Set outputs
    x_opt = x;
    f_opt = f(x_opt);
end
