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

maxIter = 100;
tolerance = 1e-6;

for iter = 1:maxIter
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
    
    % M步骤：重新估计硬币A和硬币B的参数
    theta_A_new = sum(sum(q_A .* observed_data)) / sum(sum(q_A));
    theta_B_new = sum(sum(q_B .* observed_data)) / sum(sum(q_B));
    
    % 判断迭代是否收敛
    if abs(theta_A_new - theta_A) < tolerance && abs(theta_B_new - theta_B) < tolerance
        break;
    end
    
    % 更新参数估计
    theta_A = theta_A_new;
    theta_B = theta_B_new;
end

fprintf('估计得到的硬币A正面朝上的概率为: %f\n', theta_A);
fprintf('估计得到的硬币B正面朝上的概率为: %f\n', theta_B);
