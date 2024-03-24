# 数值方法 Homework4

## Problem 1

用以下代码读入矩阵
```matlab
A = readmatrix('data.csv', 'Range', [2 1 6 5]);
B = readmatrix('data.csv', 'Range', [8 1 12 5]);
```

(1) 计算代码为
```matlab
res1 = A(1, 3) + max(A(:)) * min(B(:));
```
结果为-43

(2) 计算代码为
```matlab
res2 = A(3, :) * B(:, 2) + sum(B(:));
```
结果为106

(3) 计算代码为
```matlab
res3 = diag(diag(A)) + ones(5);
```
结果为
```
     2     1     1     1     1
     1     8     1     1     1
     1     1     8     1     1
     1     1     1    -7     1
     1     1     1     1     6
```

(4) 计算代码为
```matlab
res4 = (A(4, :) + A(:, 2)') * B;
```
结果为
```
   -81   -27    18    34    63
```

(5) 计算代码为
```matlab
res5 = A * B + A .* B;
```
结果为
```
    15    10     0    37    45
    97   130    87   194    10
   139   -20    -8    69    15
   -14     5   -17    17    43
    54    25    11    43   107
```
并使用
```matlab
writematrix(res5, 'res5.xlsx');
```
把结果写到Excel文件中


## Problem 2

在`isprime.m`中实现如下判断素数的代码
```matlab
function res = isprime(n)
    if n <= 1
        res = false;
        return;
    end

    for i = 2 : sqrt(n)
        if mod(n, i) == 0
            res = false;
            return;
        end
    end

    res = true;
    return;
end
```
在主程序中调用该函数进行判断
```matlab
for i = 100:200
    if isprime(i)
        fprintf("%d ", i);
    end
end
```

得到结果
```
101 103 107 109 113 127 131 137 139 149 151 157 163 167 173 179 181 191 193 197 199 
```