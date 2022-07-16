clear; clc;
pkg load signal;

% frequency components
f1 = 0.12; f2 = 0.30; f3 = f1+f2;
f4 = 0.19; f5 = 0.17; f6 = f4+f5;

% number of samples
N = 8192;

% time axis
k = 0:1:(N-1);

% initialize empty matrices for average bispectra and power spectrum
C  = zeros(1,257);
B1 = zeros(256,256);
B2 = zeros(256,256);
B3 = zeros(256,256);

f  = linspace(-0.5, +0.5, 257);
w1 = linspace(-0.5, +0.5, 256);
w2 = linspace(-0.5, +0.5, 256);
w3 = linspace(-0.5, +0.5, 256);

% estimate bispectra by averaging 50 realizations of X[k]
for i=1:1:50
  % progress bar
  printf('iteration %d out of 50\n', i);

  % random phase shifts for every frequency
  a1=2*pi*rand(); a2=2*pi*rand(); a3=a1+a2;
  a4=2*pi*rand(); a5=2*pi*rand(); a6=a4+a5;

  % cosine waves
  x1 = cos(2*pi*f1*k+a1); x2 = cos(2*pi*f2*k+a2);
  x3 = cos(2*pi*f3*k+a3); x4 = cos(2*pi*f4*k+a4);
  x5 = cos(2*pi*f5*k+a5); x6 = cos(2*pi*f6*k+a6);

  % generate a new realization for X[k]
  X = x1+x2+x3+x4+x5+x6;

  % estimate the autocorrelation of this realization
  r = xcorr(X,128,'biased');

  % update the average power-spectrum estimation
  C  = C + abs(fftshift(fft(r))) / 50;

  % update the average bispectra estimations
  B1 = B1 + bispecd(X,256,0,256,0.0) / 50;
  B2 = B2 + bispeci(X,64,256,0.0,'biased',256,0) / 50;
  B3 = B3 + bispeci(X,64,256,0.0,'biased',256,1) / 50;
end

% Power spectrum plot
figure(11);
plot(f,C); grid on;
title('Power spectrum, average of 50, L=128');
xlabel('frequency in Hz');
ylabel('Power Spectral Density');
set(gcf,'Name', 'PSD');

% number of levels in contour plots
n = 16;

% Bispectrum Plot for direct estimator
figure(12);
contour(w1,w1,abs(B1),n); grid on;
title('Bispectrum, average of 50, direct method, K=32, M=256, J=0');
xlabel('f_1(Hz)'); ylabel('f_2(Hz)');
set(gcf,'Name','Hosa BISPECD');

% Bispectrum Plot for indirect estimator and Parzen Window
figure(13);
contour(w2,w2,abs(B2),n); grid on;
title('Bispectrum, average of 50, indirect method, K=32, M=256, L=64, Parzen Window');
xlabel('f_1(Hz)'); ylabel('f_2(Hz)');
set(gcf,'Name','Hosa BISPECI');

% Bispectrum Plot for indirect estimator and Rectangular Window
figure(14);
contour(w3,w3,abs(B3),n); grid on;
title('Bispectrum, average of 50, indirect method, K=32, M=256, L=64, Rectangular Window');
xlabel('f_1(Hz)'); ylabel('f_2(Hz)');
set(gcf,'Name','Hosa BISPECI');

