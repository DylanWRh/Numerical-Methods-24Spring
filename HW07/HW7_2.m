x_data = [1.1, 2.3, 3, 4.4, 5, 6.1, 7.2, 8, 9.7, 10];
y_data = [313, 411, 473, 621, 721, 827, 951, 940, 1032, 1225];

coefficients = polyfit(x_data, y_data, 1);
a = coefficients(1);
b = coefficients(2);

disp(a);
disp(b);

scatter(x_data, y_data, 'blue', 'filled');
hold on;

x_fit = linspace(min(x_data)-1, max(x_data)+1, 100);
y_fit = a * x_fit + b;
plot(x_fit, y_fit, 'red', 'LineWidth', 2);

for i = 1:length(x_data)
    text(x_data(i), y_data(i), sprintf('(%.1f, %d)', x_data(i), y_data(i)));
end

title('Linear Fit');
xlabel('X');
ylabel('Y');
grid on;
