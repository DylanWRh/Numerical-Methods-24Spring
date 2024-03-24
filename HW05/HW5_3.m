% Initialize states
x_data = [         2000           3; 
                 2019.4       3.186; 
          2038.95061916 3.385386252];
p = x_data(:, 1);
q = x_data(:, 2);

% Build linear equations 

% solve A1[r;f]' = b1
A1 = [p(1), -p(1) * q(1);
      p(2), -p(2) * q(2)];
b1 = [p(2) - p(1); p(3) - p(2)];
params = linsolve(A1, b1);
r = params(1);
f = params(2);

% solve A2[w;g]' = b2
A2 = [q(1), p(1) * q(1);
      q(2), p(2) * q(2)];
b2 = [q(2) - q(1); q(3) - q(2)];
params = linsolve(A2, b2);
w = params(1);
g = params(2);

% display params 
fprintf('[r, f, w, g]: [%.8f, %.8f, %.8f, %.8f]\n', r, f, w, g);

% evolution simulation
Ts = [50, 100, 200];
figure;
for j = 1:length(Ts)
    subplot(length(Ts), 1, j);
    
    t = Ts(j);
    p0 = 2000;
    q0 = 3;
    x = zeros(2, t);
    for i = 1:t
        x(1, i) = (1 + r) * p0 - f * p0 * q0;
        x(2, i) = (1 + w) * q0 + g * p0 * q0;
        p0 = x(1, i);
        q0 = x(2, i);
    end
    plot(1:t, x(1, :), '-b', 'LineWidth', 2);
    hold on;
    plot(1:t, x(2, :), '-r', 'LineWidth', 2);
    xlabel('时间');
    ylabel('数量');
    title(['T = ', num2str(Ts(j))]);
    legend('兔子', '狼');
    grid on;
end
