clear;clc
img_path = 't4.bmp';
img_orig = imread(img_path);

% img_gray = double(rgb2gray(img_orig)/255);
% feat = get_feature(img_orig);

f = extract_feature(rgb2gray(img_orig),9);

imshow(f)