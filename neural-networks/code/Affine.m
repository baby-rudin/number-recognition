classdef Affine < handle
    properties
        W
        b
        x
        dW
        db
    end
    
    methods
        function obj = Affine(W_, b_)
            obj.W = W_;
            obj.b = b_;
        end
        
        function out = forward(obj, x_)
            obj.x = x_;
            out = obj.x * obj.W + obj.b;
        end
        
        function dx = backward(obj, dout)
            dx = dout * obj.W';
            obj.dW = obj.x' * dout;
            obj.db = sum(dout, 1);                 % mark
        end
    end
end