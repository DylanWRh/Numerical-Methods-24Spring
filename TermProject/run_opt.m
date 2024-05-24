addpath(genpath('./method'));
addpath(genpath('./function'));

% Initialization
alpha = 100;
x0 = -1 * ones(100, 1);

% Function definition
f_x = @(x) Rosenbrock(alpha, x);
grad_f = @(x) Rosenbrock_grad(alpha, x);
hess_f = @(x) Rosenbrock_hessian(alpha, x);

% Figure settings
figure;
hold on;
set(gca, 'YScale', 'log');

% Experiment 1
% Gradient Descent w/ different learning rate 

[fs, ~, ~] = GradientDescent(x0, f_x, grad_f, 10000, 1e-8, 0.001);
semilogy(fs, 'DisplayName', 'Gradient Descent 0.001', 'LineWidth', 2);
[fs, ~, ~] = GradientDescent(x0, f_x, grad_f, 10000, 1e-8, 0.002);
semilogy(fs, 'DisplayName', 'Gradient Descent 0.002', 'LineWidth', 2);
[fs, ~, ~] = GradientDescent(x0, f_x, grad_f, 10000, 1e-8, 0.003);
semilogy(fs, 'DisplayName', 'Gradient Descent 0.003', 'LineWidth', 2);

% Experiment 2
% Gradient Descent vs Steepest Descent

% [fs, ~, ~] = GradientDescent(x0, f_x, grad_f, 10000, 1e-8, 0.001);
% semilogy(fs, 'DisplayName', 'Gradient Descent 0.001', 'LineWidth', 2);
% [fs, ~, ~] = GradientDescent(x0, f_x, grad_f, 10000, 1e-8, 0.002);
% semilogy(fs, 'DisplayName', 'Gradient Descent 0.002', 'LineWidth', 2);
% [fs, ~, ~] = SteepestDescent(x0, f_x, grad_f);
% semilogy(fs, 'DisplayName', 'Steepest Descent', 'LineWidth', 2);

% Experiment 3
% Convergence speed of different conjugate method

%title('alpha=100');
% Conjugate Method with Crowder-Wolfe Formula
%[fs, ~, ~] = Conjugate(x0, f_x, grad_f);
%semilogy(fs, 'DisplayName', 'Conjugate CW', 'LineWidth', 2);
% Conjugate Method with Polak-Ribiere Formula
%[fs, ~, ~] = Conjugate(x0, f_x, grad_f, [], [], 'PR');
%semilogy(fs, 'DisplayName', 'Conjugate PR', 'LineWidth', 2);
% Conjugate Method with Fletcher-Reeves Formula
%[fs, ~, ~] = Conjugate(x0, f_x, grad_f, [], [], 'FR');
%semilogy(fs, 'DisplayName', 'Conjugate FR', 'LineWidth', 2);

% Experiment 4
% Convergence of Newton's Method

% Newton's Method
% [fs, ~, ~] = Newton(x0, f_x, grad_f, hess_f);
% semilogy(fs, 'DisplayName', 'Newton alpha=100', 'LineWidth', 2);

% Experiment 5
% Quasi-Newton Method

% DFP Method (may not converge well for some alpha's and x0's)
% [fs, ~, ~] = QuasiNewton_DFP(x0, f_x, grad_f);
% semilogy(fs, 'DisplayName', 'DFP', 'LineWidth', 2);
% BFGS Method (may not converge well for some alpha's and x0's)
% [fs, ~, ~] = QuasiNewton_BFGS(x0, f_x, grad_f);
% semilogy(fs, 'DisplayName', 'BFGS', 'LineWidth', 2);

% Figure settings
ylabel('log(f(x)-p*)');
xlabel('iteration');
legend();
hold off;