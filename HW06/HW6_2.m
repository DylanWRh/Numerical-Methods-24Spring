% 专业对口、工作稳定、薪水
A = [ 1   4   2;
    1/4   1 1/5;
    1/2   5   1];

consistency_check(A);
eigA = get_max_eig(A);

% 专业对口
B1 = [1 1/4;
      4   1];
eig1 = get_max_eig(B1);
% 工作稳定
B2 = [ 1  2;
     1/2  1];
eig2 = get_max_eig(B2);
% 薪水
B3 = [1 1/2;
      2   1];
eig3 = get_max_eig(B3);

eigB = [eig1 eig2 eig3];
result = eigB * eigA;

fprintf('公司甲得分: %.4f\n', result(1));
fprintf('公司乙得分: %.4f\n', result(2));

if result(1) > result(2)
    fprintf('建议选择公司甲\n');
else
    fprintf('建议选择公司乙\n');
end



function consistency_check(A)
    [~, n] = size(A);
    [~, d] = eig(A);
    % 求最大特征值
    max_v = max(max(d));
    % 计算一致性指标CI
    CI = (max_v - n) / (n - 1);
    RI = [0 0 0.52 0.89 1.12 1.26 1.36 1.41 1.46 1.49 1.52 1.54 1.56 1.58 1.59];
    % 计算一致性比例CR
    CR = CI / RI(n);
    disp("一致性比例为");
    disp(CR);
    if CR < 0.10
        disp("通过一致性检验");
    else
        disp("不通过一致性检验");
    end
end

function max_eig = get_max_eig(A)
    [V, D] = eig(A);
    % 找出最大特征值和对应的特征向量
    max_eigenvalue = max(diag(D));
    [~, max_eigenvalue_index] = find(diag(D) == max_eigenvalue, 1);
    max_eig = V(:, max_eigenvalue_index);
end