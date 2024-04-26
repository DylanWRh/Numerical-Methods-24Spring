# 数值方法 Homework 13

原始代码如下
```matlab
r = [0.30; 0.12; 0.15; 0.13]; % 预期收益率向量
Q = [0.0014, 0.0000, 0.0001, 0.0001;
     0.0002, 0.0213, 0.00015, 0.0001;
     0.0001, 0.00015, 0.01125, 0.00017;
     0.0001, 0.0001, 0.00017, 0.01023]; % 协方差矩阵
Rt = 0.14; % 目标收益率

% 将问题转化为quadprog的标准形式
H = Q; % 转换后的对称矩阵    objective function is   0.5*x'*H*x + f'*x;
f = zeros(4,1) ;  % 线性项系数向量，
A = -r'; % 不等式约束矩阵
b = [-Rt]; % 不等式约束向量   Ax <= b
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
```
运行结果为
```
Optimal Portfolio Weights:
    0.7688
    0.0435
    0.0892
    0.0985

Expected Return of the Portfolio:
    0.2620

Risk (Variance) of the Portfolio:
    0.0011
```

$r,Q,Rt$第一种修改如下
```matlab
r = [0.10; 0.10; 0.10; 0.10]; % 预期收益率向量
Q = [0.1114, 0.0000, 0.0000, 0.00000;
     0.0000, 0.0213, 0.0000, 0.0000;
     0.0000, 0.0000, 0.01125, 0.0000;
     0.0000, 0.0000, 0.0000, 0.01023]; % 协方差矩阵
Rt = 0.05; % 目标收益率
```
输出结果如下
```
Optimal Portfolio Weights:
    0.0370
    0.1935
    0.3665
    0.4030

Expected Return of the Portfolio:
    0.1000

Risk (Variance) of the Portfolio:
    0.0041
```
解释：
- 预期收益率均一致，因此期望的收益率与预期收益率也一致
- 协方差矩阵为对角阵，则可以推得最小化$w^\top\Sigma w$的$w$与$Q$的对角元的对应乘积为定值，使用`disp(w .* diag(Q))`打印得到
  ```
  0.0041
  0.0041
  0.0041
  0.0041
  ```
  符合预期

$r,Q,Rt$第二种修改如下
```matlab
r = [0.15; 0.10; 0.10; 0.10]; % 预期收益率向量
Q = [0.1114, 0.0000, 0.0000, 0.00000;
     0.0000, 0.0213, 0.0000, 0.0000;
     0.0000, 0.0000, 0.01125, 0.0000;
     0.0000, 0.0000, 0.0000, 0.01023]; % 协方差矩阵
Rt = 0.15; % 目标收益率
```
输出结果如下
```
Optimal Portfolio Weights:
    1.0000
    0.0000
    0.0000
    0.0000

Expected Return of the Portfolio:
    0.1500

Risk (Variance) of the Portfolio:
    0.1114
```
解释
- 由于只有$r_1=Rt$, $r_2,r_3,r_4<Rt$，因此要使得预期收益率不小于目标收益率，只能全部投资到$r_1$上