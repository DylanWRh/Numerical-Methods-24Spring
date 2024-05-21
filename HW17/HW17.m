% 蒙特卡罗模拟M/M/1排队系统

% 参数设置
lambda = 0.1; % 到达率
mu = 0.2; % 服务率
rho = lambda / mu; % 交通强度
simTime = 30000; % 模拟时间长度

[f, c,b,time_leave]  = sim(simTime,lambda,mu);

served = f(2);

% 平均等待时间
averageWaitTime =f(3);

% 输出结果
fprintf(['平均等待时间为: %.4f', newline], averageWaitTime);

% 使用Little's Law计算理论平均等待时间
Lq_theory = rho^2 / (1 - rho); % 平均队列长度（不包括正在服务的顾客）
Wq_theory = Lq_theory / lambda; % 使用Little's Law计算平均等待时间

% 输出理论结果
fprintf(['使用Little''s Law计算的理论平均等待时间为: %.4f', newline], Wq_theory);



function [f, c,b,time_leave] = sim(n, lambda, mu)
    % 初始化变量
   
    customers = 0;  % 到达的顾客数
    served = 0;     % 已服务的顾客数
    total_wait_time = 0;    % 顾客的总等待时间
    waiting_queue = [];     % 等待队列

    % 初始化第一个顾客的数据
    x(1) = exprnd(1/lambda);    % 到达间隔时间
    c(1) = x(1);    % 顾客到达时间
    b(1) = x(1);    % 顾客开始服务时间
    y(1) = exprnd(1/mu);        % 服务时间，
   time_leave(1) = b(1) + y(1); % 顾客leave时间

    % 初始化模拟时钟和顾客计数器
    sto = b(1); % 当前模拟时间
    i = 2; % 顾客计数器


    % 模拟过程
    while (sto <= n)
        x(i) = exprnd(1/lambda);    % 下一个顾客的到达时间间隔
        c(i) = c(i-1) + x(i);       % 下一个顾客的到达时间
        b(i) = c(i);                % 下一个顾客的开始服务时间
                                    % 暂时设置为到达时间，还要根据
                                    % 上一个顾客的leave时间来调整
        y(i) = exprnd(1/mu);        % 下一个顾客的服务时间
        time_leave(i) = b(i) + y(i);    % 下一个顾客的leave时间
                                        % 一会儿有可能要调整，因为b(i)调整了
        customers = customers + 1;

        if (b(i) < time_leave(i-1))
        	waiting_queue = [waiting_queue, i];
        	b(i) = time_leave(i-1);         %调整为上一个顾客的leave时间
        	time_leave(i) = b(i) + y(i);    %根据新的开始服务时间调整leave时间
        	sto = b(i);
        elseif isempty(waiting_queue)
          	sto = b(i);
          	current_customer = i;
          	total_wait_time = total_wait_time + ...
                (b(current_customer) - c(current_customer));
          end

     % 查找当前应该服务的顾客
        while ~isempty(waiting_queue) && time_leave(waiting_queue(1)) <= sto
            current_customer = waiting_queue(1);
            waiting_queue(1) = []; % 移除队列中的第一个顾客

            % 更新服务完成时间和总等待时间
            total_wait_time = total_wait_time + ...
                (b(current_customer) - c(current_customer));

            served = served + 1; % 增加已服务顾客数
        end

        i = i+1;  % 增加顾客计数器
    end

  % 在模拟循环结束后，计算已服务的顾客数
    if b(current_customer ) <= n
        served = current_customer ; % 如果最后一位顾客已经开始服务，则算入已服务的顾客数
    else
        served = current_customer  - 1; % 否则，最后一位顾客未开始服务，不算入已服务的顾客数
    end

    % 计算平均等待时间
    if served > 0
        average_wait_time = total_wait_time / served; % 平均等待时间
    else
        average_wait_time = 0; % 如果没有服务的顾客，则平均等待时间为0
    end

    % 输出结果
    fprintf(['在%.4f分钟内，共有 %d 位顾客到来。', newline], n, customers);
    fprintf(['已经服务了 %d 位顾客。', newline], served);
    fprintf(['顾客的平均等待时间为 %.4f 分钟。', newline], average_wait_time);

    % 返回结果（可根据需要调整）
    f = [customers, served,  average_wait_time];
end