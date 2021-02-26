function fisher_init()

N = 9;

% using 
T =loadMNISTImages('train-images.idx3-ubyte');
L =loadMNISTLabels('train-labels.idx1-ubyte');

F = zeros(N*N, size(T,2));

parfor i = 1:size(T,2)
    feat = extract_feature(reshape(T(:,i), [28 28]), N);
    F(:,i) = reshape(feat,[N*N 1]);
end

% counting training set
nNum = zeros(1,10);
for i = 1:length(L)
    if L(i) == 0
        nNum(10) = nNum(10) + 1;
    else
        nNum(L(i)) = nNum(L(i)) + 1;
    end
end

% allocate memory
pLen = size(F, 1);   % 28 * 28 = 784
T_cell = cell(1,10);
for i = 1:10
    T_cell{i} = zeros(pLen, nNum(i));
end

% number classification
cNum = zeros(1,10);
for i = 1:length(L)
    if L(i) == 0
        cNum(10) = cNum(10) + 1;
        T_cell{10}(:,cNum(10)) = F(:,i);
    else
        cNum(L(i)) = cNum(L(i)) + 1;
        T_cell{L(i)}(:,cNum(L(i))) = F(:,i);
    end
end

% calculate W0 and Y0
% which are used for predict
W0__ = cell(10,10);
Y0__ = zeros(10,10);
for i = 1:10
for j = 1:10
    if i == j
        continue
    end
    
    [W, Y] = linear_fisher(T_cell{i}, T_cell{j});
    W0__{i,j} = W;
    Y0__(i,j) = Y;
end
end

% save key variables for predict
save('fisher_params__.mat', 'W0__', 'Y0__');

end








