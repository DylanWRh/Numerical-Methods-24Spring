% 定义参数
sigma = 10;
% rho = 28;
rho = 10;
beta = 8/3;

% 定义ODE函数
lorenz = @(t, xyz) [sigma * (xyz(2) - xyz(1)); ...
                    rho * xyz(1) - xyz(2) - xyz(1) * xyz(3); ...
                    xyz(1) * xyz(2) - beta * xyz(3)];

% 设置初始条件
initial_conditions = [1e-3 0 0; ...
                      1e3 0 0; ...
                      0 1e-3 0; ...
                      0 1e3 0; ...
                      1e3 1e3 0];

% 设置时间范围
tspan = [0 50];

% 计算并绘制结果
figure;
for i = 1:size(initial_conditions, 1)
    [t, xyz] = ode45(lorenz, tspan, initial_conditions(i,:));
    subplot(3,2,i);
    plot3(xyz(:,1), xyz(:,2), xyz(:,3));
    title(['Initial Condition: (', ...
        num2str(initial_conditions(i,1)), ', ', ...
        num2str(initial_conditions(i,2)), ', ', ...
        num2str(initial_conditions(i,3)), ')']);
    xlabel('x');
    ylabel('y');
    zlabel('z');
    grid on;
end
