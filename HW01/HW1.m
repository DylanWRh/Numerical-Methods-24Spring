v = [3 5];        % 选取的向量

M1 = [1 1; 1 -1]; % 第一组基下的
M2 = [1 1; -1 1];

result1 = v * M1; % 在第一组基下的坐标
result2 = v * M2; % 在第二组基下的坐标

disp(result1); % [8 -2]
disp(result2); % [-2 8]

