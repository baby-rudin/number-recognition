function nums = predict_all(img_orig)
    img_gray = rgb2gray(img_orig);
    img_gaus = imgaussfilt(img_gray, 2);
    img_binw = imbinarize(img_gaus,0.65);
%     imshow(img_binw)
    
    flag = 0;
    pos = 0;
    pics = {};
    nPic = 0;
    for i = 1:size(img_binw,2)
        if sum(img_binw(:,i)) ~= size(img_binw,1) && flag == 0
            pos = i;
            flag = 1;
        elseif sum(img_binw(:,i)) == size(img_binw,1) && flag == 1
            nPic = nPic + 1;
            pics{nPic} = img_binw(:,pos:i);
            flag = 0;
        end
    end
    
    nums = [];
    
    for i = 1:nPic
        nums = [nums num2str(fisher_predict(pics{i}))];
    end
    
end