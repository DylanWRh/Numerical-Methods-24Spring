x_data = [1.1, 2.3, 3, 4.4, 5, 6.1, 7.2, 8, 9.7, 10];
y_data = [313, 411, 473, 621, 721, 827, 951, 940, 1032, 1225];

weights = rand();
bias = rand();

learning_rate = 0.001;
iterations = 5000;

for i = 1:iterations
    Z = weights * x_data + bias; 
    A = Z; 

    loss = 0.5 * sum((A - y_data).^2);

    dZ = A - y_data;
    dweights = sum(dZ .* x_data); 
    dbias = sum(dZ); 

    weights = weights - learning_rate * dweights;
    bias = bias - learning_rate * dbias;

    if mod(i, 1000) == 0
        fprintf('Iteration %d, Loss: %f\n', i, loss);
    end
end

disp('Trained weights:');
disp(weights);
disp('Trained bias:');
disp(bias);

scatter(x_data, y_data, 'blue', 'filled');
hold on;

x_fit = linspace(min(x_data)-1, max(x_data)+1, 100);
y_fit = weights * x_fit + bias;
plot(x_fit, y_fit, 'red', 'LineWidth', 2);
xlabel('X');
ylabel('Y');
hold on;

X_new = [-0.4, 5.5, 12.3]';
Z_new = weights * X_new + bias; 
A_new = Z_new;
disp('Predicted outputs for new inputs:');
disp(A_new);

scatter(X_new, Z_new, 'green', 'filled');
hold on;