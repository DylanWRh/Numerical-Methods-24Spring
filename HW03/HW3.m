% Problem 1
fprintf('Problem 1\n');
large_value = realmax('double');
count = 0;
while large_value < inf
    large_value = large_value * 2;
    count = count + 1;
end;
fprintf("经过%d次乘二操作发生上溢\n\n", count);

% Problem 2

fprintf('Problem 2\n');
n = 10000;

% (1) 单精度正序求和
sum1 = single(0);
for i = 1:n
    sum1 = sum1 + single(1 / i^2);
end
fprintf('(1) 单精度正序求和结果为%.6f\n', sum1);

% (2) 单精度逆序求和
sum2 = single(0);
for i = n:-1:1
    sum2 = sum2 + single(1 / i^2);
end
fprintf('(2) 单精度逆序求和结果为%.6f\n', sum2);

% (3) 双精度正序求和
sum3 = double(0);
for i = 1:n
    sum3 = sum3 + double(1 / i^2);
end
fprintf('(3) 双精度正序求和结果为%.6f\n', sum3);

% (3) 双精度逆序求和
sum4 = double(0);
for i = n:-1:1
    sum4 = sum4 + double(1 / i^2);
end
fprintf(['(3) 双精度逆序求和结果为%.6f\n\n'], sum4);

% Problem 3
x = linspace(-3.5, 4.5, 1000);
y = zeros(size(x));

for i = 1:length(x)
    if -3 <= x(i) && x(i) < 0
        y(i) = x(i) + 3;
    elseif 0 <= x(i) && x(i) < pi
        y(i) = sin(x(i));
    elseif pi <= x(i) && x(i) <= 4
        y(i) = exp(x(i) - 3);
    end
end

plot(x, y, 'LineWidth', 2);
xlabel('x');
ylabel('f(x)');
title('分段函数图像');




