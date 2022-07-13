clear; clc; clf; 

f1 = 0.12; f2 = 0.30; f3 = f1+f2;
f4 = 0.19; f5 = 0.17; f6 = f4+f5;

N = 8192;
k = 0:1:(N-1);

B1 = zeros(256,256);
B2 = zeros(64,64);
B3 = zeros(64,64);

for i=1:1:50
  a1=2*pi*rand(); a2=2*pi*rand(); a3=a1+a2;
  a4=2*pi*rand(); a5=2*pi*rand(); a6=a4+a5;
  
  x1 = cos(2*pi*f1*k+a1); x2 = cos(2*pi*f2*k+a2);
  x3 = cos(2*pi*f3*k+a3); x4 = cos(2*pi*f4*k+a4);
  x5 = cos(2*pi*f5*k+a5); x6 = cos(2*pi*f6*k+a6);
  
  X = x1+x2+x3+x4+x5+x6;
  
  r = autocorr(X,128));
  C  = C + abs(fft(r)) / 50;
  
  B1 = B1 + bispecd(X,256,0,256,0.0) / 50;
  B2 = B2 + bispeci(X,64,256,0.0,'biased',256,0) / 50;
  B3 = B3 + bispeci(X,64,256,0.0,'biased',256,1) / 50;  
end

