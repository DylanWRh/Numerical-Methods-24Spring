f = ones(6, 1);  % 目标函数的系数向量
intcon = [1 2 3 4 5 6];
A = [
    -1 0 0 0 0 -1;
    -1 -1 0 0 0 0;
    0 -1 -1 0 0 0;
    0 0 -1 -1 0 0;
    0 0 0 -1 -1 0;
    0 0 0 0 -1 -1;
];  % 不等式约束条件的系数矩阵
b = [-60; -70; -60; -50; -20; -30];  % 不等式约束条件的右侧向量
Aeq = [];  % 无等式约束条件
beq = [];  % 无等式约束条件
lb = zeros(6, 1);  % 变量的下界
ub = [];  % 变量无上界

% 调用 intlinprog 函数求解整数线性规划问题
[x, fval] = intlinprog(f, intcon, A, b, Aeq, beq, lb, ub);

% 打印结果
disp(x);
disp(fval);