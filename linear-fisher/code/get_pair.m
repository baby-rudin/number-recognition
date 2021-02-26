function [a, b] = get_pair(index)
    if index < 1 || index > 45
        a = -1; b = -1;
    end
    
    aTab = [0 0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 3 3 3 3 3 3 4 4 4 4 4 5 5 5 5 6 6 6 7 7 8];
    bTab = [1 2 3 4 5 6 7 8 9 2 3 4 5 6 7 8 9 3 4 5 6 7 8 9 4 5 6 7 8 9 5 6 7 8 9 6 7 8 9 7 8 9 8 9 9];
    
    a = aTab(index);
    b = bTab(index);
end