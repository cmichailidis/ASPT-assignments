clear all; close all; clc;
pkg load signal; pkg load image;

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
B1 = bispecd(X,256,0,256,0.0);
% bispectrum estimation with indirect method and Parzen window
B2 = bispeci(X,64,256,0.0,'biased',256,0);
% bispectrum estimation with indirect method and no window
B3 = bispeci(X,64,256,0.0,'biased',256,1);

% =====================================================
% 4) Plot the results
% =====================================================

% compression factor for logarithmic scale
r = 10;

% Power Spectrum Plot
figure(1);
plot(f,C); grid on;
title('Power spectrum, L=128');
xlabel('frequency in Hz');
ylabel('Power Spectral Density');
set(gcf,'Name', 'PSD');

% Bispectrum Plot for direct estimator
figure(2);
C1 = abs(B1) / max(abs(B1(:)));
C1 = log(1+r*C1);
C1 = imresize(C1,4,'bicubic');
[m,n] = size(C1);
f = linspace(-0.5,+0.5,n);
imagesc(f,f,C1); colorbar; grid on;
title('Bispectrum, direct method, K=32, M=256, J=0');
xlabel('f_1(Hz)'); ylabel('f_2(Hz)');
set(gcf,'Name','Hosa BISPECD');

% Bispectrum Plot for indirect estimator and Parzen Window
figure(3);
C2 = abs(B2) / max(abs(B2(:)));
C2 = log(1+r*C2);
C2 = imresize(C2,4,'bicubic');
[m,n] = size(C2);
f = linspace(-0.5,+0.5,n);
imagesc(f,f,C2); colorbar; grid on;
title('Bispectrum, indirect method, K=32, M=256, L=64, Parzen Window');
xlabel('f_1(Hz)'); ylabel('f_2(Hz)');
set(gcf,'Name','Hosa BISPECI');

% Bispectrum Plot for indirect estimator and Parzen Window
figure(4);
C3 = abs(B3) / max(abs(B3(:)));
C3 = log(1+r*C3);
C3 = imresize(C3,4,'bicubic');
[m,n] = size(C3);
f = linspace(-0.5,+0.5,n);
imagesc(f,f,C3); colorbar; grid on;
title('Bispectrum, indirect method, K=32, M=256, L=64, Rectangular Window');
xlabel('f_1(Hz)'); ylabel('f_2(Hz)');
set(gcf,'Name','Hosa BISPECI');

% =====================================================
% 5) Repeat everything with different parameters
% i)  K=16, M=512, L=64
% ii) K=64, M=128, L=64
% =====================================================

% bispectrum estimation with direct method
B4 = bispecd(X,512,0,512,0.0);
% bispectrum estimation with indirect method and Parzen window
B5 = bispeci(X,64,512,0.0,'biased',512,0);
% bispectrum estimation with indirect method and no window
B6 = bispeci(X,64,512,0.0,'biased',512,1);

% Bispectrum Plot for direct estimator
figure(5);
C4 = abs(B4) / max(abs(B4(:)));
C4 = log(1+r*C4);
C4 = imresize(C4,4,'bicubic');
[m,n] = size(C4);
f = linspace(-0.5,+0.5,n);
imagesc(f,f,C4); colorbar; grid on;
title('Bispectrum, direct method, K=16, M=512, J=0');
xlabel('f_1(Hz)'); ylabel('f_2(Hz)');
set(gcf,'Name','Hosa BISPECD');

% Bispectrum Plot for indirect estimator and Parzen Window
figure(6);
C5 = abs(B5) / max(abs(B5(:)));
C5 = log(1+r*C5);
C5 = imresize(C5,4,'bicubic');
[m,n] = size(C5);
f = linspace(-0.5,+0.5,n);
imagesc(f,f,C5); colorbar; grid on;
title('Bispectrum, indirect method, K=16, M=512, L=64, Parzen Window');
xlabel('f_1(Hz)'); ylabel('f_2(Hz)');
set(gcf,'Name','Hosa BISPECI');

% Bispectrum Plot for indirect estimator and Rectangular Window
figure(7);
C6 = abs(B6) / max(abs(B6(:)));
C6 = log(1+r*C6);
C6 = imresize(C6,4,'bicubic');
[m,n] = size(C6);
f = linspace(-0.5,+0.5,n);
imagesc(f,f,C6); colorbar; grid on;
title('Bispectrum, indirect method, K=16, M=512, L=64, Rectangular Window');
xlabel('f_1(Hz)'); ylabel('f_2(Hz)');
set(gcf,'Name','Hosa BISPECI');

% bispectrum estimation with direct method
B7 = bispecd(X,128,0,128,0.0);
% bispectrum estimation with indirect method and Parzen window
B8 = bispeci(X,64,128,0.0,'biased',128,0);
% bispectrum estimation with indirect method and no window
B9 = bispeci(X,64,128,0.0,'biased',128,1);

% Bispectrum Plot for direct estimator
figure(8);
C7 = abs(B7) / max(abs(B7(:)));
C7 = log(1+r*C7);
C7 = imresize(C7,4,'bicubic');
[m,n] = size(C7);
f = linspace(-0.5,+0.5,n);
imagesc(f,f,C7); colorbar; grid on;
title('Bispectrum, direct method, K=64, M=128, J=0');
xlabel('f_1(Hz)'); ylabel('f_2(Hz)');
set(gcf,'Name','Hosa BISPECD');

% Bispectrum Plot for indirect estimator and Parzen Window
figure(9);
C8 = abs(B8) / max(abs(B8(:)));
C8 = log(1+r*C8);
C8 = imresize(C8,4,'bicubic');
[m,n] = size(C8);
f = linspace(-0.5,+0.5,n);
imagesc(f,f,C8); colorbar; grid on;
title('Bispectrum, indirect method, K=64, M=128, L=64, Parzen Window');
xlabel('f_1(Hz)'); ylabel('f_2(Hz)');
set(gcf,'Name','Hosa BISPECI');

% Bispectrum Plot for indirect estimator and Rectangular Window
figure(10);
C9 = abs(B9) / max(abs(B9(:)));
C9 = log(1+r*C9);
C9 = imresize(C9,4,'bicubic');
[m,n] = size(C9);
f = linspace(-0.5,+0.5,n);
imagesc(f,f,C9); colorbar; grid on;
title('Bispectrum, indirect method, K=64, M=128, L=64, Rectangular Window');
xlabel('f_1(Hz)'); ylabel('f_2(Hz)');
set(gcf,'Name','Hosa BISPECI');
