% Initialize params
r = 0.03;
K = 100;
N = 500;

% Initialize population vectors
x = zeros(1, N);
y = zeros(1, N);
x(1) = 0.1;
y(1) = 0.1;

% 马尔萨斯模型
for n = 1:N-1
    x(n+1) = x(n) + r * x(n);
end

% 逻辑斯蒂克模型
for n = 1:N-1
    y(n+1) = y(n) + r * (1 - y(n)/K) * y(n);
end

% Plot
figure;
subplot(2,1,1);
plot(1:N, x, 'b');
title('马尔萨斯模型');
xlabel('时间');
ylabel('人口');
grid on;

subplot(2,1,2);
plot(1:N, y, 'r');
title('逻辑斯蒂克模型');
xlabel('时间');
ylabel('人口');
grid on;
