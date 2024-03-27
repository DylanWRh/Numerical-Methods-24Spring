x = [-2, -1, 2, 3, 1];
y = [-51, -8, 13, 4, 6];

n = length(x);

syms t;
f = 0;
for i = 1:n
    Li = 1;
    for j = 1:n
        if j ~= i
            Li = Li * (t - x(j)) / (x(i) - x(j));
        end
    end
    f = f + y(i) * Li;
end


f_handle = matlabFunction(f);
x_interp = linspace(min(x), max(x), 1000);
y_interp = f_handle(x_interp);

figure;
plot(x_interp, y_interp, 'b-', x, y, 'ro');
title('Lagrange Interpolating Polynomial');
xlabel('x');
ylabel('y');
grid on;
