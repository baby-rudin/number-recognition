function [W_star, y0]= linear_fisher(X1, X2)
    nFeature = size(X1,1);
    m1 = sum(X1,2) / size(X1,2);
    m2 = sum(X2,2) / size(X2,2);
    
    S1 = zeros(nFeature, nFeature);
    S2 = zeros(nFeature, nFeature);
    
    for i = 1:size(X1,2)
        Xi = X1(:,i);
        S1 = S1 + (Xi - m1) * (Xi - m1)';
    end
    for i = 1:size(X2,2)
        Xi = X2(:,i);
        S2 = S2 + (Xi - m2) * (Xi - m2)';
    end
    
    Sc = S1 + S2;
%     Sb = (m1 - m2) * (m1 - m2)';
    
    W_star = Sc \ (m1 - m2);
    
    y1 = W_star' * X1;
    y2 = W_star' * X2;
    
    m1_bar = sum(y1) / length(y1);
    m2_bar = sum(y2) / length(y2);
    
%     S1_bar = (y1 - m1_bar) * (y1 - m1_bar)';
%     S2_bar = (y2 - m2_bar) * (y2 - m2_bar)';
%     Sc_bar = S1_bar + S2_bar;
    
    y0 = (length(y1)*m1_bar + length(y2)*m2_bar)...
        / (length(y1)+length(y2));
end