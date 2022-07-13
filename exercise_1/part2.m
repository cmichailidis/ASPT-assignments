clear; clc; clf; 

f1 = 0. ; f2 = 0. ; f3 = f1+f2;
f4 = 0. ; f5 = 0. ; f6 = f4+f5;

N = 8192;
k = 0:1:(N-1);

for i=1:1:50
  a1 = 2*pi*rand(); a2 = 2*pi*rand(); a3 = a1+a2;
  a4 = 2*pi*rand(); a5 = 2*pi*rand(); a6 = a4+a5;
  
  x1 = cos(2*pi*f1*k+a1); x2 = cos(2*pi*f2*k+a2);
  x3 = cos(2*pi*f3*k+a3); x4 = cos(2*pi*f4*k+a4);
  x5 = cos(2*pi*f5*k+a5); x6 = cos(2*pi*f6*k+a6);
  
  X = x1+x2+x3+x4+x5+x6;
  
  C  = C + abs(fft(autocorr(X,128)));
  B1 = B1 + bispecd(X,);
  B2 = B2 + bispeci(X,);
  B3 = B3 + bispeci(X,);  
end

