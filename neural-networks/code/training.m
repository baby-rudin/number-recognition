clear; clc;

HidSize = 50;
OutSize = 10;

TrainImage = loadMNISTImages('train-images.idx3-ubyte')';
TrainLabel = loadMNISTLabels('train-labels.idx1-ubyte')' + 1;
TestImage = loadMNISTImages('t10k-images.idx3-ubyte')';
TestLabel = loadMNISTLabels('t10k-labels.idx1-ubyte')' + 1;

[TestSize,  ~        ] = size(TestImage);
[TrainSize, ImageSize] = size(TrainImage);

% transform Label from number to vector
ind = sub2ind([TrainSize, OutSize], 1:TrainSize, TrainLabel);
TrainLabel = zeros(TrainSize, OutSize);
TrainLabel(ind) = 1;

ind = sub2ind([TestSize, OutSize], 1:TestSize, TestLabel);
TestLabel = zeros(TestSize, OutSize);
TestLabel(ind) = 1;

% create two layer network
network = TwoLayerNet(ImageSize, HidSize, OutSize);

% learning....
LearnCir = 1000;
learn_rate = 1;
train_size = ImageSize;
batch_size = 100;
train_loss_list  = zeros(1,LearnCir);
train_accur_list = zeros(1,LearnCir);
test_accur_list  = zeros(1,LearnCir);

for i = 1:LearnCir

    batch_mask = randsample(train_size, batch_size);
    x_batch = TrainImage(batch_mask,:);
    t_batch = TrainLabel(batch_mask,:);
    
    grad = network.gradient(x_batch, t_batch);
    
    for j = 1:4
        network.params{j} = network.params{j} - learn_rate * grad{j};
    end
    
    network.upgrade_params();
    
    train_loss_list(i) = network.loss(TrainImage, TrainLabel)';
    train_accur_list(i) = network.accuracy(TrainImage, TrainLabel);
    test_accur_list(i)  = network.accuracy(TestImage, TestLabel);

    fprintf('TrainTurn = %4d / %4d\t\t',i, LearnCir);
    fprintf('Accuracy = %5.2f  \n', test_accur_list(i) * 100);
end

% 
plot(test_accur_list);

InpSize__ = 784;
HidSize__ = 50;
OutSize__ = 10;
Params__ = network.params;

save('network_param__.mat', 'Params__', 'InpSize__',...
     'HidSize__', 'OutSize__');

