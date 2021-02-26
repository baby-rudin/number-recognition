% extract M * N features from a image
% each feature is a float number between 0 and 1.
function features = extract_feature(img_gray, scale)
    nSplit = 10;
    
    % determine feature size
    if length(scale) == 1
        M = scale;
        N = scale;
    else
        M = scale(1);
        N = scale(2);
    end
    
    % if the image is a colorful picture
    if size(img_gray, 3) ~= 1
        img_gray = rgb2gray(img_gray);
    end
    
    % use float to represent grayscale images
    if isa(img_gray, 'integer')
        img_gray = double(img_gray / 255);
    end
    
    % use black as background
    num_black = sum(img_gray==0, 'all');
    num_white = length(img_gray(:)) - num_black;
    if num_white > num_black
        img_gray = 1 - img_gray;
    end
    
    % positioning numbers in the figure
    img_gray = extract_img(img_gray);
    
    img_gray = imresize(img_gray, [M*nSplit N*nSplit]);
    features = zeros(M, N);
    for i = 1:M
        for j = 1:N
            features(i,j) = ...
                sum(img_gray((i-1)*nSplit+1:i*nSplit, ...
                             (j-1)*nSplit+1:j*nSplit), 'all');
        end
    end
    features = features / nSplit^2;
    
    % function for extracting numbers
    function seg = extract_img(img)
        [h, w] = size(img);
        h1 = -1; h2 = -1;
        w1 = -1; w2 = -1;
        for ii = 1:h
        for jj = 1:w
            if img(ii,jj) ~= 0
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