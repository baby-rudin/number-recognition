function ret = get_feature(img_orig)
    N = 9;

    img_gray = rgb2gray(img_orig);
    img_gaus = imgaussfilt(img_gray,2);
    img_binw = imbinarize(img_gaus, 0.5);
    img_segm = extract_img(img_binw);
    
    img_split = imresize(img_segm, [N*10, N*10]);
    per = zeros(N, N);
    for i = 1:N
    for j = 1:N
        i_a = (i-1) * 10 + 1;
        i_b = i * 10;
        j_a = (j-1) * 10 + 1;
        j_b = j * 10;
        per(i,j) = sum(img_split(i_a:i_b, j_a:j_b), 'all');
    end
    end
    
    ret = (100 - per)/max(per,[],'all');
    
    function seg = extract_img(img)
        [h, w] = size(img);
        h1 = -1;
        h2 = -1;
        w1 = -1;
        w2 = -1;
    
        for ii = 1:h
        for jj = 1:w
            if img(ii,jj) == 0
                if (h1 == -1); h1=ii; end
                if (h2 == -1); h2=ii; end
                if (w1 == -1); w1=jj; end
                if (w2 == -1); w2=jj; end
            
                if (ii < h1); h1 = ii; end
                if (ii > h2); h2 = ii; end
                if (jj < w1); w1 = jj; end
                if (jj > w2); w2 = jj; end
            end
        end
        end
    
        if h1 == -1 && h2 == -1 && w1 == -1 && w2 == -1
            seg = [];
        else
            seg = img(h1:h2, w1:w2);
        end
    end
end