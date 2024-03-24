% Problem 1

A = readmatrix('data.csv', 'Range', [2 1 6 5]);
B = readmatrix('data.csv', 'Range', [8 1 12 5]);

res1 = A(1, 3) + max(A(:)) * min(B(:));
fprintf("Result of 1. (1): %d\n", res1);

res2 = A(3, :) * B(:, 2) + sum(B(:));
fprintf("Result of 1. (2): %d\n", res2);

res3 = diag(diag(A)) + ones(5);
fprintf("Result of 1. (3)\n");
disp(res3);

res4 = (A(4, :) + A(:, 2)') * B;
fprintf("Result of 1. (4)\n");
disp(res4);

res5 = A * B + A .* B;
fprintf("Result of 1. (5)\n");
disp(res5);
writematrix(res5, 'res5.xlsx');

% Problem 2

fprintf("Primes between 100 and 200:\n")
for i = 100:200
    if isprime(i)
        fprintf("%d ", i);
    end
end
fprintf("\n");
