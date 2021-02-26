clear;
clc;

TestImage = loadMNISTImages('t10k-images.idx3-ubyte');
TestLabel = loadMNISTLabels('t10k-labels.idx1-ubyte')';

accuracy_rate = sum(TestLabel == num_classify(TestImage)) ...
                / length(TestLabel);
fprintf('Accuracy Rate on test set: %.2f %%\n',accuracy_rate * 100);

% my last id
last_student_ID = 0;

idx = find(TestLabel == last_student_ID);
IdImage = TestImage(:,idx);
ID_rate = sum(last_student_ID == num_classify(IdImage))...
          / length(idx);
fprintf('My last ID number is %d\n',last_student_ID);
fprintf('My last ID Accuracy Rate: %.2f %%\n',accuracy_rate * 100);