classdef ReluFun < handle
    properties
        mask
    end
    
    methods
        function obj = ReluFun()
        end
        
        function out = forward(obj, x)
            obj.mask = zeros(size(x));
            obj.mask(x<=0) = 1;
            out = x;
            out(x<=0) = 0;
        end
        
        function dx = backward(obj, dout)
            dout(obj.mask == 1) = 0;
            dx = dout;
        end
    end
end