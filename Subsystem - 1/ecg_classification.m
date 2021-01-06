%18BEC0042 - TELAPROLU DINESH RAM SAI

clc; clear all; close all;
% create CWT Image Database from ECG Signals
% Loading ECG Data
%load(fullfile('C:','Users','DINESH RAM SAI','Documents','VIT', '5th Semester - Fall Sem 2020 - 2021','Digital Signal Processing (ECE2006)','Project','Project Files','1 - ECG Signal Classification','ECGData.mat'));
load('ECGData.mat'); % Loading the ECG Data
data=ECGData.Data;         %Getting Database from the loaded Data. It is a 162x65536 matrix which means it consists of 162 ECG Signals each with sample size of 65536
labels=ECGData.Labels;     %Getting Labels from the loaded Data. Name of the Signals Can be get from Labels

ARR=data(1:30,:);     %Taken first 30 Recordings of each ECG type
CHF=data(97:126,:);
NSR=data(127:156,:);
signallength=500; %Limiting the Sample Size of Signal to 500 instead of 65536

%Defining filterbanks for CWT with amor wavelet and 12 filters per octave
fb=cwtfilterbank('SignalLength',signallength,'Wavelet','amor','VoicesPerOctave',12); %used to define cwt coefficients.

%Making Folders

mkdir('ecgdataset'); %MainFolder
mkdir('ecgdataset\arr'); %SubFolder
mkdir('ecgdataset\chf');
mkdir('ecgdataset\nsr');



ecgtype={'ARR','CHF','NSR'};

%Function to convert ECG to Image
ecg2cwtscg(ARR,fb,ecgtype(1)); %User Defined function to convert ecg signal into scalogram image using cwt
ecg2cwtscg(CHF,fb,ecgtype(2));
ecg2cwtscg(NSR,fb,ecgtype(3));


