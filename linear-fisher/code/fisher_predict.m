function ret = fisher_predict(img)
    load('fisher_params__.mat', 'W0__', 'Y0__');
    
    N = 9;
    if size(img,3) == 1
        img_gray = img;
    else
        img_gray = rgb2gray(img);
    end
    
    x = extract_feature(img_gray, N);
    cnt = zeros(1,10);
    
    for i = 1:10
    for j = 1:10
        if i == j; continue; end
        y = W0__{i,j}' * reshape(x,[N*N, 1]);
        
        if y > Y0__(i,j)
            cnt(i) = cnt(i) + 1;
        else
            cnt(j) = cnt(j) + 1;
        end
    end
    end
    
    % get predict number
    [~, m] = max(cnt);
    ret = mod(m(1),10);
end