% 观测数据
X = linspace(0, 10, 1000)';
Y = exp(0.5*X) - sin(X) + 0.1*randn(size(X));

% 绘制观测数据
figure;
hold on;
plot(X, Y, 'b.', 'DisplayName', 'Observations');

% 优化选项
options = optimoptions('lsqnonlin', 'Algorithm', 'trust-region-reflective');

% 设定函数
func_poly_pred = @(theta) (polyval(fliplr(theta), X));
fun_target = @(theta) Y - func_poly_pred(theta);

% 对n=3~9进行优化
degrees = 3:9;
for i = 1:length(degrees)
    degree = degrees(i);
    theta0 = ones(1, degree + 1); % 初始参数估计
    % 使用 lsqnonlin 求解非线性最小二乘问题
    [theta_opt, resnorm, ~, ~, ~] = lsqnonlin(fun_target, theta0, [], [], options);
    
    % 显示优化结果
    fprintf('Degree %d - Optimized parameters: ', degree);
    disp(theta_opt);
    fprintf('Residual norm: %f\n', resnorm);
    
    % 绘制预测结果
    Y_predicted = func_poly_pred(theta_opt);
    plot(X, Y_predicted, 'LineWidth', 2, 'DisplayName', ['Degree ' num2str(degree)]);
end
hold off;
legend('Location', 'best');
xlabel('X');
ylabel('Y');
title('Observed Data and Predicted Functions');
