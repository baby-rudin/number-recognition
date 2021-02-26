function index = get_index(a, b)
    if a<0 || a>9 || b<0 || b>9 || a==b
        index = -1;
        return
    end
    
    if a > b
        t = a; a = b; b = t;
    end
    
    tab = [0, 9, 17, 24, 30, 35, 39, 42, 44, 45];
    
    index = tab(a+1) + b - a;
end