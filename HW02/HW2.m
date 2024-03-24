A = [200 -1 0 0 0;
     -1 2 -1 0 0;
     0 -1 2 -1 0;
     0 0 -1 180 -1;
     0 0 0 -1 0.002;];

% (1) 求特征值和特征向量并排序
[V, D] = eig(A);
d = diag(D);
[dd, I] = sort(d, 'descend', 'ComparisonMethod', 'abs');
VV = V(:, I);
disp("特征值")
disp(dd);
disp("特征向量")
disp(VV);
% 特征向量矩阵的逆
disp("特征向量矩阵的逆")
WW = inv(VV);
disp(WW);

% (2) 求A^3和e^A
DD3 = diag(dd .^ 3);
AA3 = VV * DD3 * WW;
disp("A^3为");
disp(AA3);
eDD = diag(exp(dd));
eAA = VV * eDD * WW;
disp("e^A为");
disp(eAA);

% (3) 计算秩-1分解
r1mats = cell(5, 1);
for i = 1:5
    disp("第"+string(i)+"个秩-1分解矩阵")
    r1mats{i} = dd(i) * VV(:, i) * WW(i, :);
    disp(r1mats{i})
end

% (4) 计算低秩逼近
A1 = r1mats{1};
norm1 = norm(A-A1);
A2 = r1mats{1} + r1mats{2};
norm2 = norm(A-A2);
A3 = r1mats{1} + r1mats{2} + r1mats{3};
norm3 = norm(A-A3);
disp("rank-1逼近及其误差");
disp(A1);
disp(norm1);
disp("rank-2逼近及其误差");
disp(A2);
disp(norm2);
disp("rank-3逼近及其误差");
disp(A3);
disp(norm3);