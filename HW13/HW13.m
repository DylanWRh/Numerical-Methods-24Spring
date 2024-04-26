r = [0.15; 0.10; 0.10; 0.10]; % 预期收益率向量
Q = [0.1114, 0.0000, 0.0000, 0.00000;
     0.0000, 0.0213, 0.0000, 0.0000;
     0.0000, 0.0000, 0.01125, 0.0000;
     0.0000, 0.0000, 0.0000, 0.01023]; % 协方差矩阵
Rt = 0.15; % 目标收益率

% 将问题转化为quadprog的标准形式
H = Q; % 转换后的对称矩阵    objective function is   0.5*x'*H*x + f'*x;
f = zeros(4,1) ;  % 线性项系数向量，
A = -r'; % 不等式约束矩阵
b = -Rt; % 不等式约束向量   Ax <= b
Aeq = ones(1, length(r)); % Equality constraints matrix (sum of weights = 1)
beq = 1; % Equality constraints vector
lb = zeros(length(r), 1); % 权重非负约束
ub = ones(length(r),1); % 没有上界约束

% 调用quadprog求解
options = optimoptions('quadprog', 'Display', 'off');
w = quadprog(H, f', A, b, Aeq, beq, lb, ub, [], options);

% 显示结果
disp('Optimal Portfolio Weights:');
disp(w);
disp('Expected Return of the Portfolio:');
disp(r' * w);
disp('Risk (Variance) of the Portfolio:');
disp(w' * Q * w);