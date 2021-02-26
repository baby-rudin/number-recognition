N = 9;
NN = 81;
features = cell(1,10);
for i = 0:9
    pics = dir(['number\' num2str(i) '\*.jpg']);
    NumFeat = zeros(NN, length(pics));
    
    for j = 1: length(pics)
        pic = pics(j);
        img = imread([pic.folder '\' pic.name]);
        NumFeat(:,j) = reshape(get_feature(img), [NN, 1]);
    end
    
    features{i+1} = NumFeat;
end

cnt = 0;
W0__ = zeros(NN, 45);
Y0__ = zeros(1, 45);

for i = 0:8
    for j = i+1:9
        cnt = cnt + 1;
        X1 = features{i+1};
        X2 = features{j+1};
        [W, Y] = linear_fisher(X1, X2);
        W0__(:,cnt) = W;
        Y0__(cnt) = Y;
    end
end

save('fisher_params__.mat', 'W0__', 'Y0__');