classdef TwoLayerNet < handle
    properties
        params
        layers
        lastLayer
    end
    
    methods
        function obj = TwoLayerNet(input_size, hidden_size, output_size,...
                                   weight_init_std )
            if (nargin < 4)
                weight_init_std = 0.01;
            end
            W1 = weight_init_std * randn(input_size, hidden_size);
            b1 = zeros(1, hidden_size);
            W2 = weight_init_std * randn(hidden_size, output_size);
            b2 = zeros(1, output_size);
            
            obj.params = {W1,b1,W2,b2};
%             obj.params = struct("W1",W1, "b1",b1, "W2",W2, "b2",b2);
            
            Affine1 = Affine(obj.params{1}, obj.params{2});
            Relu1   = ReluFun();
            Affine2 = Affine(obj.params{3}, obj.params{4});
            
            
            obj.layers = {Affine1, Relu1, Affine2};
%             obj.layers = struct("Affine1",Affine1, "Relu1", Relu1,"Affine2", Affine2);
            
            obj.lastLayer = SoftmaxWithLoss();
        end
        
        function x_ = predict(obj, x)
            x_ = x;
            for i = 1:3
                x_ = obj.layers{i}.forward(x_);
            end
        end
        
        function loss_ = loss(obj, x, t)
            y = obj.predict(x);
            loss_ = obj.lastLayer.forward(y, t);
        end
        
        function acy = accuracy(obj, x, t)
            y = obj.predict(x);
            [~,index1] = max(y,[],2);
            [~,index2] = max(t,[],2);
            acy = sum(index1 == index2) / size(t,1);
        end
        
        function grads = gradient(obj, x, t)
            % forward
            obj.loss(x,t);
            
            % backward
            dout = 1;
            dout = obj.lastLayer.backward(dout);
            
%             r_lKeys = fliplr(obj.lKeys);
            for i = 3:-1:1
%                 key
                dout = obj.layers{i}.backward(dout);
            end
            
            d_A1_dW = obj.layers{1}.dW;
            d_A1_db = obj.layers{1}.db;
            d_A2_dW = obj.layers{3}.dW;
            d_A2_db = obj.layers{3}.db;
            
%             grads = struct("W1", d_A1_dW, "b1", d_A1_db, ...
%                            "W2", d_A2_dW, "b2", d_A2_db );
            
            grads = {d_A1_dW, d_A1_db, d_A2_dW, d_A2_db};
        end
        
        function upgrade_params(obj)
            obj.layers{1}.W = obj.params{1};
            obj.layers{1}.b = obj.params{2};
            obj.layers{3}.W = obj.params{3};
            obj.layers{3}.b = obj.params{4};
        end
    end
end