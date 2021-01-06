%Program to get QRS Peaks and Heart Rate from ECG signal
[filename,pathname]=uigetfile('*.*','Select the ECG Signal'); %Command for selecting ECG Signal file in the current working directory
filewithpath=strcat(pathname,filename);%Variable to store the file name and path 
Fs=input('Enter Sampling Rate: '); %Inputting the Sampling Frequency. All signals from MIT-BIH database have 360 sampling frequency

ecg = load(filename); %Reading selected ECG signal
ecgsig=(ecg.val)./200; %Normalize gain by dividing with 200. Because all the signals in BIT-MIH are recorded with 200 Gain
t=1:length(ecgsig); %No. of samples
tx=t./Fs; %Getting Time vector 

wt = modwt(ecgsig,4,'sym4'); %4-level undecimated DWT using sym4 with the help of 'modwt'
wtrec = zeros(size(wt)); %Storing the zeros equal to size of wt
wtrec(3:4,:) = wt(3:4,:); %Extracting only d3 and d4 coefficients as only they carry required band frequency components. Others carry high or low frequency components.
y = imodwt(wtrec,'sym4'); %Inverse undecimated DWT with only d3 and d4.
y = abs(y).^2; %Magnitude square inorder make the output wave have only positive Rpeaks

avg=mean(y); %Getting average of y^2 as threshold
[Rpeaks,locs] = findpeaks(y,t,'MinPeakHeight',8*avg,'MinPeakDistance',50);  %Finding Peaks using inbuilt function. 8*avg is the threshold. If the peak is above threshold, it will be considered. or not 
                                                                            %MinPeakDistance is in the terms of samples. Only the peaks which are minimum 50 samples apart can be detected.
                                                                            %Magnitude of R peaks will go into Rpeaks and locations will go into locs.
nohb=length(locs); %No. of beats
timelimit=length(ecgsig)/Fs;
hbpermin=(nohb*60)/timelimit; %Getting Beats Per Minute. I.e changing the beats value per minute
disp(strcat('Heart Rate= ',num2str(hbpermin)))%Displaying the Beats per minute

%Displaying ECG signal and detected R-Peaks
figure('Name','18BEC0042','NumberTitle','off');
subplot (2,1,1)
plot(tx,ecgsig); %Plotting ECG Signal
xlim([0,timelimit]);
grid on;
xlabel('Seconds'); title ('ECG Signal'); 
subplot(2,1,2);
plot (t, y); %Plotting the squared output signal(y=y^2) after Inverse Undecimated wavelet transform
grid on;
xlim([0,length(ecgsig)]);
hold on
plot(locs,Rpeaks,'ro');% Along with y, we are plotting Rpeaks with red dots(ro) at their location
xlabel('Samples'); title(strcat('R Peaks found and Heart Rate: ',num2str(hbpermin))); 


