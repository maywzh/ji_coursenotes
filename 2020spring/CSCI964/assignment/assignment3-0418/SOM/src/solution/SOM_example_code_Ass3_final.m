% CSCI464/964 Computational Intelligence (Autumn 2017)
% This is an example code for training a self-organising map (SOM) 
% based on a subset of MNIST data (http://yann.lecun.com/exdb/mnist/)
% This code is implemented based on Section 9.3 (pp. 428-437) of book
% "Neural Networks and Learning Machines" (Third Edition), Simon Haykin.
% Lei Wang (06-May-2017)

clear all;
close all;

% Set the size of the MNIST image for visualisation;
imageSize = [28 28]; 

% Set the number of rows and columns of the 2D lattice in SOM;
rowNum = 10; 
colNum = 10;

% Set the number of neurons (equal rowNum * colNum); 
neuronNum = rowNum * colNum; 

% Load the MNIST dataset in; 
data = dlmread('./SOM_MNIST_data.txt');
[dim, num] = size(data); 
disp('MNIST data are successfully loaded.'); 

% Define the weight vector of each neuron and randomly initialise them;
neuronWeight = rand(dim, neuronNum);
oldneuronWeight = neuronWeight; % for checking the convergence;

% SOM training process consists of two phrases (ordering and convergence);
% Define the epoch numbers for the two phrases, respectively;
epochNumOrd = 100; 
epochNumCov = 100; % (Ideal value is at least 500 * neuronNum); 

% Initialise the learning rate and define the rate in each epoch t;
eta_0 = 0.1; 
eta_t = eta_0; 
% Define the attenuation speed of the learning rate with epoches; 
tau_2 = 1000;
  
% Initialise the sigma value of the neighbourhood function h();
% sigma_0 is initialised as the "radius" of the lattice;
sigma_0 = sqrt((0.5*rowNum).^2 + (0.5*colNum).^2);  
% Define the sigma value in each epoch t;
sigma_t = sigma_0;
% Define the attenuation speed of sigma with epoches; 
tau_1 = 1000/log(sigma_0);

% Generate row and column indexes for each neuron;
% They will be used to identify the winning neuron; 
[rowIndex,colIndex] = ind2sub([rowNum, colNum], 1:neuronNum);
% Reshape them to a column vector;
rowIndex = reshape(rowIndex,length(rowIndex),1); 
colIndex = reshape(colIndex,length(colIndex),1); 
 
% Plot the initial weight vector of each neuron (for visualisation); 
figure; 
for i = 1:neuronNum
  subplot(rowNum,colNum,i);
  imshow(reshape(neuronWeight(:,i),imageSize));
end
drawnow; 

% Define weightDiff to store the difference of neuroWeights in two
% consecutive epochs;
weightDiff = zeros(epochNumOrd + epochNumCov,1);

% Start training the SOM neural network, where t indexes the epoch; 
disp(['Training SOM starts. Total number of epochs is ',num2str(epochNumOrd + epochNumCov),'...']); 

for t=1:epochNumOrd + epochNumCov
  disp(['Now in epoch ',num2str(t),'...']); 
    
  % At each epoch, randomly shuffle data first;
  data = data(:,randperm(num)); 
    
  % Present each sample to the SOM neural network; 
  for i=1:num
    x = data(:,i);
        
    % Calculate the (squared) Euclidean distance of x from each neuron;
    sqEucDist = sum((neuronWeight-repmat(x,1,neuronNum)).^2,1);
 
    % Identify the winning neuron by finding the minimum one in sqEucDist;
    [minDist, minInd] = min(sqEucDist);
    % Obtain the coordinates of the winning neuron in the 2D lattice;
    winCoor = [rowIndex(minInd) colIndex(minInd)];
 
    % Calculate the (squared) Euclidean distance of this winnung neuron from all neurons;
    % This is to obtain the neighborhood of the winning neuron;
    sqEucDist = sum(([rowIndex colIndex] - repmat(winCoor,neuronNum,1)).^2,2);
    % Compute the value of the neighborhood function h();
    h_winNeuron = exp(-sqEucDist/(2 * sigma_t * sigma_t));
 
    % Updating the weight vectors of all neurons; 
    for j = 1:neuronNum
      neuronWeight(:,j) = neuronWeight(:,j) + eta_t * h_winNeuron(j) * (x-neuronWeight(:,j));
    end
  end
 
  % Compute weight difference;
  weightDiff(t) = sum(sum((neuronWeight - oldneuronWeight).^2));
  weightDiff(t) = sqrt(weightDiff(t) / (dim * neuronNum));
  oldneuronWeight = neuronWeight; 
  
  % Attenuate the learning rate for the next epoch;
  % Note that the learning rate shall remain above 0.01; 
  eta_t = max(eta_0 * exp(-t/tau_2), 0.01);
  
  % Attenuate the sigma value of h() for the next epoch;
  sigma_t = sigma_0 * exp(-t/tau_1);
 
  % Plot the updated weight vector of each neuron (for visualisation); 
  % Plot one figure per 100 epochs;
  if (mod(t,100) == 1) 
    figure; 
    for i = 1:neuronNum
      subplot(rowNum,colNum,i);
      imshow(reshape(neuronWeight(:,i),imageSize));
    end
    drawnow; 
  end
end

% Plot the evolution of weightDiff to check convergence;
figure; 
plot(weightDiff); 
xlabel('The number of epochs');
ylabel('The difference of weight vectors');
title('The evolution of weight difference with epochs'); 

disp('Training SOM is done!'); 