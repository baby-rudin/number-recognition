% y and t are Column vector
function ret = cross_entropy_error(y, t)
    dta = 1e-7;
    ret = -1.0 * sum(t .* log(y + dta), 'all');
end