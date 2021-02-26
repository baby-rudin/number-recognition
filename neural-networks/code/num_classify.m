function num = num_classify(img_data)
    load('network_param__.mat',...
         'InpSize__','HidSize__','OutSize__','Params__');
    network = TwoLayerNet(InpSize__, HidSize__, OutSize__);
    network.params = Params__;
    network.upgrade_params();
    img_data = img_data';
    out = network.predict(img_data);
    [~, y] = max(out,[],2);
    num = y'- 1;
end

