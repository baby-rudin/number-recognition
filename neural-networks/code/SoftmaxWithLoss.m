classdef SoftmaxWithLoss < handle
    properties
        loss
        y
        t
    end
    
    methods
        function obj = SoftmaxWithLoss()
        end
        
        function loss_ = forward(obj, x_, t_)
            obj.t = t_;
            obj.y = mySoftMax(x_);
            obj.loss = cross_entropy_error(obj.y, obj.t);
            loss_ = obj.loss;
        end
        
        function dx = backward(obj, dout)
            if (nargin < 1)
                dout = 1;
            end
            
            batch_size = size(obj.t, 1);        % mark
            dx = (obj.y - obj.t) / batch_size;
        end
    end
end