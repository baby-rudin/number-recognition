classdef SigmoidFun < handle
    properties
        out
    end
    
    methods
        function obj = SigmoidFun()
        end
        
        function out_ = forward(obj, x)
            out_ = 1 ./ (1 + exp(-x));
            obj.out = out_;
        end
        
        function dx = backward(obj, dout)
            dx = dout .* (1.0 - obj.out) .* obj.out;
        end
    end
end