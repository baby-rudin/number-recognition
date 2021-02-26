function ret = mySoftMax(a)
    a = a - max(a,[], 2);
    exp_a = exp(a);
    ret = exp_a ./ sum(exp_a, 2);
end