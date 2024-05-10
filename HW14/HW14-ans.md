# 数值方法 Homework 14

(1) EM算法是一种用于求解含有隐变量的概率模型参数的**迭代**优化算法，每次迭代由两步组成
- E步：根据当前参数估计，计算隐变量的后验概率
- M步：在M步中，利用E步计算得到的后验概率重新估计模型参数

通过交替进行E步和M步，最终可以得到模型参数的极大似然估计值。

(2) 例子: 假设有两枚硬币$A,B$，投掷时正面向上的概率分别为$\theta_A, \theta_B$，这两个参数即为需要估计的参数。我们设计$N$次实验，第$i$次实验等概率选取某一个硬币连续投掷$k$次，投掷结果为$x^{(i)}=\left(x_1^{(i)}, \cdots, x_k^{(n)}\right)$，但我们并不知道$x^{(i)}$是由哪一枚硬币产生的

使用以下代码生成初始数据
```matlab
% 初始参数真实值
theta_A = 0.7;
theta_B = 0.2;

% 观测数据
num_experiments = 50;
num_flips = 50;
observed_data = zeros(num_experiments, num_flips); 
for i = 1:num_experiments
    coin_choice = rand() > 0.5; 
    if coin_choice % 使用硬币A生成
        observed_data(i, :) = rand(1, num_flips) < theta_A;
    else % 使用硬币B生成
        observed_data(i, :) = rand(1, num_flips) < theta_B; 
    end
end
```

在E步中，估计隐变量的后验概率，即
$$\begin{aligned}
p(A|x^{(i)}) = \dfrac{p(x^{(i)}|A)p(A)}{p(x^{(i)})} =C \prod_j \theta_A^{x^{(i)}_j} (1-\theta_A)^{1-x^{(i)}_j}\\
p(B|x^{(i)}) = \dfrac{p(x^{(i)}|B)p(B)}{p(x^{(i)})} =C \prod_j \theta_B^{x^{(i)}_j} (1-\theta_B)^{1-x^{(i)}_j}
\end{aligned}
$$
估计后验概率的代码如下
```matlab
% E步：计算每次实验使用硬币A和硬币B的概率
q_A = zeros(num_experiments, num_flips);
q_B = zeros(num_experiments, num_flips);
for i = 1:num_experiments
    q_A(i, :) = prod(theta_A.^observed_data(i, :) .* (1-theta_A).^(1-observed_data(i, :)));
    q_B(i, :) = prod(theta_B.^observed_data(i, :) .* (1-theta_B).^(1-observed_data(i, :)));
end
q_sum = q_A + q_B;
q_A = q_A ./ q_sum;
q_B = q_B ./ q_sum;
```

在M步中重新估计硬币A和硬币B的参数，即
```matlab
theta_A_new = sum(sum(q_A .* observed_data)) / sum(sum(q_A));
theta_B_new = sum(sum(q_B .* observed_data)) / sum(sum(q_B));
```

重复迭代E和M步直到收敛
```matlab
maxIter = 100;
tolerance = 1e-6; % 迭代停止条件

for iter = 1:maxIter
    % E步 ...
    % M步 ...

    % 判断迭代是否收敛
    if abs(theta_A_new - theta_A) < tolerance && abs(theta_B_new - theta_B) < tolerance
        break;
    end
    
    % 更新参数估计
    theta_A = theta_A_new;
    theta_B = theta_B_new;
end
```

最终得到结果
```
估计得到的硬币A正面朝上的概率为: 0.702608
估计得到的硬币B正面朝上的概率为: 0.205926
```
符合初始时设置的真实值