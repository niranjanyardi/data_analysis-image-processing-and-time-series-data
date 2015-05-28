clear all;
clc;

[num,txt,raw] = xlsread('C:\Users\ndy102\Downloads\FTEsupervised_BxyzVsTsNp_TestSetResults_wPredAndActual-1.xlsx');  %read the excel file using matlab

data = num(1:end,3:16)'; %create separate matrix for data(more convenient). I excluded the first 2 columns of the data as they dont provide much information in classifying the time series(they are just numeric values). also, experimentally, they do not contribute much to the classification accuracy(excluding them doesn't make much difference to the classification accuracy)

classes=num(1:end,117)'; %create seperate matrix for classes of  each data point

for i=1:length(classes) %treat classes 1 and 2 as same class: class 1
   if(classes(i)==2)    
       classes(i)=1;
   end
end

%initialize a neural network with 8 neurons in the first layer,one neuron
%in output layer. After 8 neurons the training time increases a lot,prediction accuracy doesnt increase drastically and you
%might get overfitting. (at 20 neurons you get a classification accuracy of
%94.5 percent)
net=patternnet([8]);

%train the neural network using the back propogation algorithm
net.trainFcn = 'trainlm';  
net= train(net,data,classes);

%divide the data into 3 data sets: training test and validation: this is to
%make sure that classifier overfitting is avoided
%data is divided randomly into these 3 sets: training,test and validation
net.divideParam.trainRatio=0.7;
net.divideParam.valRatio=0.15 ;
net.divideParam.testRatio=0.15 ;


%test it on the whole data set
data1= num(1:end,3:16)';
test= net(data1);
test1=round(test); % for ambiguos values at the output of the neural network just classify them according to which classes they are closest to.(ex: 0.4- means class 0 not class 1)
diff = test1-(classes(1:end));

%print the number of correct detections
det=numel(find(diff==0));


%accuracy
accuracy=100*det/18245; %correct detections/total samples


disp(['accuracy is ',num2str(accuracy),'%']);
