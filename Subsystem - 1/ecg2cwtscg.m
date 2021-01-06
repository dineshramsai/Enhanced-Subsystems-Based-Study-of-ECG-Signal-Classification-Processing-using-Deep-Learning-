%18BEC0042 - TELAPROLU DINESH RAM SAI

function ecg2cwtscg(ecgdata,cwtfb,ecgtype)
nos=10; %number of signals pieces. I.e, there are 65536 samples. We cut them into 500 sample blocks, i.e each block contains 500 samples each. We take first 10 blocks
nol=500; %signal length
colormap=jet(128); %Defining the colormap for scalogram images
if strcmp(ecgtype, 'ARR') %equivalent to ecgtype=='ARR'
    folder=strcat('C:\Users\DINESH RAM SAI\Documents\VIT\5th Semester - Fall Sem 2020 - 2021\Digital Signal Processing (ECE2006)\Project\DSP Project - Dinesh Ram Sai\Subsystem-1\ecgdataset\arr\arr'); %Destination Folder for saving Images
    findx=0; %Required Variable Declaration for using in loops
    for i=1:30 
        indx=0; %Required Variable Declaration for using in loops
        for k=1:nos
            ecgsignal=ecgdata(i,indx+1:indx+nol); %Extracting the ECG Signal from the ecgdata matrix. It equivaletly extracts 500 sample blocks
            cfs = abs(cwtfb.wt(ecgsignal)); %Finding the wavelet coefficients using filter 'fb'. abs() is used because coefficients are complex.
            im = ind2rgb(im2uint8(rescale(cfs)),colormap); %by this command, we are converting the images into scalogram images. 
                                                           %First rescaling the coefficients from 0 to 1.Then converting them into unsigned interger 8 so that it becomes image
                                                           %and converting this index mode into rgb color mode 
            filenameindex=findx+k; %Required Variable Declaration for using in naming the images
            filename=strcat(folder,sprintf('%d.jpg',filenameindex)); %Naming the images. D is the loop execution number. Hence for first time execution, it produces 1.jpg
            imwrite(imresize(im,[227 227]),filename); %Stored in the current directory using imwrite. Before storing, it changes image dimensions to 227x227 px which is applicable to AlexNet
            indx=indx+nol; %Incrementing the value of appropriate variable for running the next iteration
        end
        findx=findx+nos; %Incrementing the value of appropriate variable for running the next iteration
    end
elseif strcmp(ecgtype, 'CHF') %Procedure is same, except the ECG Datatype is CHF
    folder=strcat('C:\Users\DINESH RAM SAI\Documents\VIT\5th Semester - Fall Sem 2020 - 2021\Digital Signal Processing (ECE2006)\Project\DSP Project - Dinesh Ram Sai\Subsystem-1\ecgdataset\chf\chf');
    findx=0;
    for i=1:30
        indx=0;
        for k=1:nos
            ecgsignal=ecgdata(i,indx+1:indx+nol);
            cfs = abs(cwtfb.wt(ecgsignal));
            im = ind2rgb(im2uint8(rescale(cfs)),colormap);
            filenameindex=findx+k;
            filename=strcat(folder,sprintf('%d.jpg',filenameindex));
            imwrite(imresize(im,[227 227]),filename);
            indx=indx+nol;
        end
        findx=findx+nos;
    end
elseif strcmp(ecgtype, 'NSR')%Procedure is same, except the ECG Datatype is NSR
    folder=strcat('C:\Users\DINESH RAM SAI\Documents\VIT\5th Semester - Fall Sem 2020 - 2021\Digital Signal Processing (ECE2006)\Project\DSP Project - Dinesh Ram Sai\Subsystem-1\ecgdataset\nsr\nsr');
    findx=0;
    for i=1:30
        indx=0;
        for k=1:nos
            ecgsignal=ecgdata(i,indx+1:indx+nol);
            cfs = abs(cwtfb.wt(ecgsignal));
            im = ind2rgb(im2uint8(rescale(cfs)),colormap);
            filenameindex=findx+k;
            filename=strcat(folder,sprintf('%d.jpg',filenameindex));
            imwrite(imresize(im,[227 227]),filename);
            indx=indx+nol;
        end
        findx=findx+nos;
    end
end






