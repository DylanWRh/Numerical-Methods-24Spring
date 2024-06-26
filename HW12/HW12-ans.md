# 数值方法 Homework 12

设各个时间段开始工作的司机和乘务人员数目为$x_1,x_2,x_3,x_4,x_5,x_6$，则可写出线性规划问题
$$
\begin{aligned}
\min & & x_1+x_2+x_3+x_4+x_5+x_6 \\
\mathrm{s.t.} & & x_1+x_6\geq 60 \\
& & x_1 + x_2 \geq 70 \\
& & x_2 + x_3 \geq 60 \\
& & x_3 + x_4 \geq 50 \\
& & x_4 + x_5 \geq 20 \\
& & x_5 + x_6 \geq 30 \\
& & x_1,x_2,x_3,x_4,x_5,x_6\geq 0\\
& & x_1,x_2,x_3,x_4,x_5,x_6\in \mathbb{Z}
\end{aligned}
$$
写成MATLAB求解线性规划的矩阵形式为
$$
\left[\begin{matrix}
    -1 & 0 & 0 & 0 & 0 & -1 \\
    -1 & -1 & 0 & 0 & 0 & 0 \\
    0 & -1 & -1 & 0 & 0 & 0 \\
    0 & 0 & -1 & -1 & 0 & 0 \\
    0 & 0 & 0 & -1 & -1 & 0 \\
    0 & 0 & 0 & 0 & -1 & -1
\end{matrix}\right]\left[
    \begin{matrix}
        x_1 \\
        x_2 \\
        x_3 \\
        x_4 \\
        x_5 \\
        x_6
    \end{matrix}
\right]\leq \left[
    \begin{matrix}
        -60 \\
        -70 \\
        -60 \\
        -50 \\
        -20 \\
        -30 
    \end{matrix}
    \right]
$$

求解该问题的代码如下
```matlab
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
```

输出结果为
```
 60
 10
 50
  0
 30
  0
  
150
```
也即在班次1安排60人，班次2安排10人，班次3安排50人，班次5安排30人，班次4和6无需增加人员，最少需要150人。