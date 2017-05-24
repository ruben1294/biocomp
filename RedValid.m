function [tr,performance,testPerformance,net,r,testTargets] = RedValid(NEU,p,norm_data,HOV,FCN)
x = p;
t = norm_data;
% Create a Fitting Network
% Para más de una capa cambiar NEU con valor de Matriz [C1 C2 C3]
net = fitnet(NEU);
% Choose Input and Output Pre/Post-Processing Functions
% For a list of all processing functions type: help nnprocess
net.input.processFcns = {'removeconstantrows','mapminmax'};
net.output.processFcns = {'removeconstantrows','mapminmax'};
% Setup Division of Data for Training, Validation, Testing
% For a list of all data division functions type: help nndivide
net.divideFcn = 'dividerand';  % Divide data randomly
net.divideMode = 'sample';  % Divide up every sample
if HOV == 1
    net.divideParam.trainRatio = 75/100;
    net.divideParam.valRatio = 25/100;
    net.divideParam.testRatio = 25/100;
else
    net.divideParam.trainRatio = 50/100;
    net.divideParam.valRatio = 0/100;
    net.divideParam.testRatio = 25/100;
end
% For help on training function 'trainlm' type: help trainlm
% For a list of all training functions type: help nntrain
net.trainFcn = FCN;  % Levenberg-Marquardt
% Choose a Performance Function
% For a list of all performance functions type: help nnperformance
net.performFcn = 'mse';  % Mean squared error
% Choose Plot Functions
% For a list of all plot functions type: help nnplot
net.plotFcns = {'plotperform','plottrainstate','ploterrhist', ...
  'plotregression', 'plotfit'};
if HOV == 1
    net.trainParam.epochs = 1000;
else
    net.trainParam.epochs = 100;
end
% Train the Network
[net,tr] = train(net,x,t);

% Test the Network
y = net(x);
e = gsubtract(t,y);
performance = perform(net,t,y);
[r,b,m]=regression(t,y);

% Recalculate Training, Validation and Test Performance
trainTargets = t .* tr.trainMask{1};
valTargets = t  .* tr.valMask{1};
testTargets = t  .* tr.testMask{1};
trainPerformance = perform(net,trainTargets,y);
valPerformance = perform(net,valTargets,y);
testPerformance = perform(net,testTargets,y);