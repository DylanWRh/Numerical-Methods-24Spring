cars_data = readtable('cars.csv', 'Range', 'B2');
cars_raw = table2array(cars_data);
cars_mean = mean(cars_raw);
cars_std = std(cars_raw);

cars = (cars_raw - cars_mean) ./ (cars_std + 1e-10);

cov_matrix = cov(cars);
[V, D] = sort_eig(cov_matrix);

k = 2;
V_k = V(:, 1:k);
projected_data = cars * V_k;

disp(projected_data);
scatter(projected_data(:,1), projected_data(:,2));
xlabel('Principal Component 1');
ylabel('Principal Component 2');
title('PCA of Cars Data');


function [VV,DD] = sort_eig(A)
    [V,D] = eig(A);
    d  = diag(D);
    [dd ,ii] = sort(d, 'descend');
    DD = diag(dd);
    VV = V(:, ii);
end    