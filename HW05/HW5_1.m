M = [  0    0   1/6  1/3  1/4  1/4;
     1/3    0   1/6  1/3    0  1/6;
     1/3  1/6     0  1/6  1/3    0;
     1/6  1/6   1/3    0  1/6  1/6;
       0  1/3   1/3    0    0  1/3;
     1/6  1/6   1/4  1/4  1/6    0];
MT = M';

n = size(M, 1);

PageRank = ones(n, 1) / n;
old_PageRank = zeros(n, 1); 

tolerance = 1e-8;

while norm(PageRank - old_PageRank, 1) > tolerance
    old_PageRank = PageRank;
    PageRank = MT * PageRank;
end

disp('PageRank 结果:');
disp(PageRank');

[~, index] = max(PageRank);
candidates = ['A', 'B', 'C', 'D', 'E', 'F'];
fprintf('最优秀班干部是: %s\n', candidates(index));
