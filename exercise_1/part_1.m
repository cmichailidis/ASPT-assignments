clear; cls; clf;

% =====================================================
% 1) Construct X[k]
% =====================================================
f1 = 0. ; f2 = 0. ; f3 = f1 + f2;
f4 = 0. ; f5 = 0. ; f6 = f4 + f5;

a1 = 2*pi*rand(); a2 = 2*pi*rand(); a3 = a1 + a2;
a4 = 2*pi*rand(); a5 = 2*pi*rand(); a6 = a4 + a5;

N = 8192;
k = 0:1:(N-1);

x1 = cos(2*pi*f1*k+a1); x2 = cos(2*pi*f2*k+a2);
x3 = cos(2*pi*f3*k+a3); x4 = cos(2*pi*f4*k+a4);
x5 = cos(2*pi*f5*k+a5); x6 = cos(2*pi*f6*k+a6);

X = x1+x2+x3+x4+x5+x6;

% =====================================================
% 2) Estimate the powerspectrum
% =====================================================
r = autocorr(X,128);
C = abs(fft(r));
f = frequency axis

% ===================================================== 
% 3) Estimate the bispectrum:
% i)   direct method K=32, M=256, J=0
% ii)  indirect method K=32, M=256, parzen window
% iii) indirect method K=32, M=256, rectangular window
% =====================================================
B1 = bispecd(X,);
B2 = bispeci(X,);
B3 = bispeci(X,);

% =====================================================
% 4) Plot the results
% =====================================================

% =====================================================
% 5) Repeat everything with different parameters
% i)  K=16, M = 512
% ii) K=64, M = 128
% =====================================================
B4 = bispecd(X); B5 = bispeci(X); B6 = bispeci(X);

B7 = bispecd(X); B8 = bispeci(X); B9 = bispeci(X);

% =====================================================
% 6) Plot the new results
% =====================================================