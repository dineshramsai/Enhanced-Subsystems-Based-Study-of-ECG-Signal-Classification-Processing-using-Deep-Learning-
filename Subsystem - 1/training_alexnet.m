
%18BEC0042 - T.DINESH RAM SAI

%Training and Validation using Alexnet
DatasetPath = 'C:\Users\DINESH RAM SAI\Desktop\Subsystem-1\ecgdataset'; %Folder in which images are stored which will be using as Input for training
images = imageDatastore(DatasetPath,'IncludeSubfolders',true,'LabelSource','foldernames'); %Reading Images from Image Database Folder
%Distributing Images in the set of Training and Testing
numTrainFiles = 250; %Taking 250/300 images for training. For 3 subfolders, it is 750 images. Remaining 150(50/300 in each folder) images will be used for Testing
[TrainImages,TestImages] = splitEachLabel(images,numTrainFiles,'randomize'); %Splitting images into training images and test images
net = alexnet; %Importing pretrained Alexnet
layersTransfer = net.Layers(1:end-3); %Preserving all layers except last three. It is from the definition of Transfaer Learning. All layers of CNN are pretrained and last 3 layers
                                      % can be modified and can be used for customised training and learning.                                         

numClasses =3; %Number of output classes: ARR, CHF, NSR

%Defining layers of Alexnet
layers=[layersTransfer                                                                   %These are untouched layers
    fullyConnectedLayer(numClasses,'WeightLearnRateFactor',20,'BiasLearnRateFactor',20) %These are the last 3 laers, which we are changing. In orginal alexnet, numClasses=1000.
    softmaxLayer                                                                        % Here it is 3 classes. We are defining some learning factors here which are helpful in training process
    classificationLayer];

%Defining the Training options 
options = trainingOptions('sgdm',...   %Using SGDM(Stochastic Gradient Descent with Momentum). It is SOLVER and helps in Training Process
    'MiniBatchSize',20,...
    'MaxEpochs',8,...
    'InitialLearnRate',1e-4,...         %Defining the other Required Parameters for Training
    'Shuffle','every-epoch',...
    'ValidationData',TestImages,...     %Give Variable which is carrying all the 150/900 test images 
    'ValidationFrequency',10,...
    'Verbose',false,...
    'Plots','training-progress');

%Training the AlexNet
netTransfer = trainNetwork(TrainImages,layers,options); %TrainImages are the training images(750/900). Layers are being trained with images using according to training options 

%Classifying Images
YPred = classify(netTransfer,TestImages); %Predicting by Classifying the images. here netTransfer is the same variable but different neural network after training with Test Images
YValidation = TestImages.Labels; %Validation of Test Images. All Labels are stored in Y Validation. It is the count of how many ECGs are classifies correctly 
accuracy = sum(YPred == YValidation)/numel(YValidation); %Ratio of how many ECGs classified correctly as predicted and Predcted value of how many ECG's are classified correctly
disp(accuracy)

%Plotting Confusion Matrix
plotconfusion(YValidation,YPred); %Plot to show how many ECGs are classified and misclassified


