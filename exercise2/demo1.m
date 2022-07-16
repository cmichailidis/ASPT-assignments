clear; clc;
pkg load signal;

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
r = xcorr(X,128,'biased');
% power spectrum of X[k]
C = abs(fftshift(fft(r)));
% frequency axis for power-spectrum
f = linspace(-0.5,+0.5,257);

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

% number of levels in contour plots
n = 32;

% Power Spectrum Plot
figure(1);
plot(f,C); grid on;
title('Power spectrum, L=128');
xlabel('frequency in Hz');
ylabel('Power Spectral Density');
set(gcf,'Name', 'PSD');

% Bispectrum Plot for direct estimator
figure(2);
contourf(w1,w1,abs(B1),n,'LineColor','none'); grid on; colorbar;
title('Bispectrum, direct method, K=32, M=256, J=0');
xlabel('f_1(Hz)'); ylabel('f_2(Hz)');
set(gcf,'Name','Hosa BISPECD');

% Bispectrum Plot for indirect estimator and Parzen Window
figure(3);
contourf(w2,w2,abs(B2),n,'LineColor','none'); grid on; colorbar;
title('Bispectrum, indirect method, K=32, M=256, L=64, Parzen Window');
xlabel('f_1(Hz)'); ylabel('f_2(Hz)');
set(gcf,'Name','Hosa BISPECI');

% Bispectrum Plot for indirect estimator and Parzen Window
figure(4);
contourf(w3,w3,abs(B3),n,'LineColor','none'); grid on; colorbar;
title('Bispectrum, indirect method, K=32, M=256, L=64, Rectangular Window');
xlabel('f_1(Hz)'); ylabel('f_2(Hz)');
set(gcf,'Name','Hosa BISPECI');

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

% number of levels on contour plots
n = 32;

% Bispectrum Plot for direct estimator
figure(5);
contourf(w4,w4,abs(B4),n,'LineColor','none'); grid on; colorbar;
title('Bispectrum, direct method, K=16, M=512, J=0');
xlabel('f_1(Hz)'); ylabel('f_2(Hz)');
set(gcf,'Name','Hosa BISPECD');

% Bispectrum Plot for indirect estimator and Parzen Window
figure(6);
contourf(w5,w5,abs(B5),n,'LineColor','none'); grid on; colorbar;
title('Bispectrum, indirect method, K=16, M=512, L=64, Parzen Window');
xlabel('f_1(Hz)'); ylabel('f_2(Hz)');
set(gcf,'Name','Hosa BISPECI');

% Bispectrum Plot for indirect estimator and Rectangular Window
figure(7);
contourf(w6,w6,abs(B6),n,'LineColor','none'); grid on; colorbar;
title('Bispectrum, indirect method, K=16, M=512, L=64, Rectangular Window');
xlabel('f_1(Hz)'); ylabel('f_2(Hz)');
set(gcf,'Name','Hosa BISPECI');

% Bispectrum Plot for direct estimator
figure(8);
contourf(w7,w7,abs(B7),n,'LineColor','none'); grid on; colorbar;
title('Bispectrum, direct method, K=64, M=128, J=0');
xlabel('f_1(Hz)'); ylabel('f_2(Hz)');
set(gcf,'Name','Hosa BISPECD');

% Bispectrum Plot for indirect estimator and Parzen Window
figure(9);
contourf(w8,w8,abs(B8),n,'LineColor','none'); grid on; colorbar;
title('Bispectrum, indirect method, K=64, M=128, L=64, Parzen Window');
xlabel('f_1(Hz)'); ylabel('f_2(Hz)');
set(gcf,'Name','Hosa BISPECI');

% Bispectrum Plot for indirect estimator and Rectangular Window
figure(10);
contourf(w9,w9,abs(B9),n,'LineColor','none'); grid on; colorbar;
title('Bispectrum, indirect method, K=64, M=128, L=64, Rectangular Window');
xlabel('f_1(Hz)'); ylabel('f_2(Hz)');
set(gcf,'Name','Hosa BISPECI');
