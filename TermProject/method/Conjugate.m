function [fs, x_opt, f_opt] = Conjugate(x0, f, grad_f, maxiter, tol, method)
    
    % Set default parameters
    if nargin < 6 || isempty(method)
        method = 'CW';
    end
    if nargin < 5 || isempty(tol)
        tol = 1e-8;
    end
    if nargin < 4 || isempty(maxiter)
        maxiter = 10000;
    end

    % Initialize
    x = x0;
    fs = [f(x0)];
    i = 0;
    gnorm = inf;
    g = grad_f(x);
    d = -g;

    % Start iteration
    while i < maxiter && gnorm > tol
        % Line search 
        phi = @(t) f(x + t * d);
        alpha = fminbnd(phi, 0, 0.05);

        % Update x and grad
        x_new = x + alpha * d;
        g_new = grad_f(x_new);

        % Crowder-Wolfe formula
        if strcmp(method, 'CW')
            beta = (g_new' * (g_new - g)) / (d' * (g_new - g));
        % Polak-Ribiere formula
        elseif strcmp(method, 'PR')
            beta = (g_new' * (g_new - g)) / (g' * g);
        % Fletcher-Reeves formula
        elseif strcmp(method, 'FR')
            beta = (g_new' * g_new) / (g' * g);
        else
            disp('Invalid Method!');
            return;
        end

        % Update direction
        d = -g_new + beta * d;

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



