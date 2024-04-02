x = [1, 3, 5, 6, 4, 2, 2, 7];

% (1) 使用fft函数
X_fft = fft(x);
disp('使用fft函数计算的结果：');
disp(transpose(X_fft));


% (2) 离散傅里叶变换矩阵
N = length(x);
n = 0:N-1;
k = 0:N-1;
F = exp(-1i*2*pi/N * n' * k);

X_matrix = F * x';

disp('利用矩阵乘向量计算的结果：');
disp(X_matrix);

% 两者差值
disp('结果对比');
disp(transpose(X_fft) - X_matrix);
disp(norm(transpose(X_fft) - X_matrix))