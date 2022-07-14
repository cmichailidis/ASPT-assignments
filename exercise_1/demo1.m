clear; cls; clf;

% =====================================================
% 1) Construct X[k]
% =====================================================

% frequency components
f1 = 0.12 ; f2 = 0.30 ; f3 = f1+f2;
f4 = 0.19 ; f5 = 0.17 ; f6 = f4+f5;

% phase shift for every frequency
a1 = 2*pi*rand(); a2 = 2*pi*rand(); a3 = a1+a2;
a4 = 2*pi*rand(); a5 = 2*pi*rand(); a6 = a4+a5;

% number of samples
N = 8192;
% time axis
k = 0:1:(N-1);

% cosine waves
x1 = cos(2*pi*f1*k+a1); x2 = cos(2*pi*f2*k+a2);
x3 = cos(2*pi*f3*k+a3); x4 = cos(2*pi*f4*k+a4);
x5 = cos(2*pi*f5*k+a5); x6 = cos(2*pi*f6*k+a6);

% stochastic process
X = x1+x2+x3+x4+x5+x6;

% =====================================================
% 2) Estimate the power-spectrum
% =====================================================

% autocorrelation of X[k] for L=128 time lags
r = autocorr(X,128);
% power spectrum of X[k]
C = abs(fft(r));
% frequency axis for power-spectrum
f = frequency axis

% ===================================================== 
% 3) Estimate the bispectrum:
% i)   direct method K=32, M=256, J=0
% ii)  indirect method K=32, M=256, L=64 parzen window
% iii) indirect method K=32, M=256, L=64 rectangular window
% =====================================================

% bispectrum estimation with direct method
[B1,w1] = bispecd(X,256,0,256,0.0);
% bispectrum estimation with indirect method and Parzen window
[B2,w2] = bispeci(X,64,256,0.0,'biased',256,0);
% bispectrum estimation with indirect method and no window
[B3,w3] = bispeci(X,64,256,0.0,'biased',256,1);

% =====================================================
% 4) Plot the results
% =====================================================

% =====================================================
% 5) Repeat everything with different parameters
% i)  K=16, M=512, L=64
% ii) K=64, M=128, L=64
% =====================================================

% bispectrum estimation with direct method
[B4,w4] = bispecd(X,512,0,512,0.0); 
% bispectrum estimation with indirect method and Parzen window
[B5,w5] = bispeci(X,64,512,0.0,'biased',512,0); 
% bispectrum estimation with indirect method and no window
[B6,w6] = bispeci(X,64,512,0.0,'biased',512,1);

% bispectrum estimation with direct method
[B7,w7] = bispecd(X,128,0,128,0.0); 
% bispectrum estimation with indirect method and Parzen window
[B8,w8] = bispeci(X,64,128,0.0,'biased',128,0); 
% bispectrum estimation with indirect method and no window
[B9,w9] = bispeci(X,64,128,0.0,'biased',128,1);

% =====================================================
% 6) Plot the new results
% =====================================================
