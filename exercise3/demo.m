N = 2048;
v = exprnd(1,[1,N]));

h0 = +1.00; h1 = +0.93; h2 = +0.85;
h3 = +0.72; h4 = +0.59; h5 = -0.10; 
h = [h0, h1, h2, h3, h4, h5];
x = conv(h,v);

m = mean(v);
s = std(v);
skewness = sum((v-m).^3)/((N-1)*s);

K=32;
M=64;
L=20;
c3 = cum3(x,);

q = 5;
k = 0:1:q;
h_est = c3(q,k)/c3(q,0);
x_est = conv(h_est,v);

q_sub = q-2;
k = 0:1:q_sub;
h_sub = c3(q_sub,k)/c3(q_sub,0);
x_sub = conv(h_sub,v);

q_sup = q+3;
k = 0:1:q_sup;
h_sup = c3(q_sup,k)/c3(q,0);
x_sup = conv(h_sup,v);

RMSE_est  = sqrt(sum((x_est - x).^2)/N);
NRMSE_est = RMSE_est / (max(x) - min(x));

RMSE_sub  = sqrt(sum((x_sub - x).^2)/N);
NRMSE_sub = RMSE_sub / (max(x) - min(x));

RMSE_sup  = sqrt(sum((x_sup - x).^2)/N);
NRMSE_sup = RMSE_sup / (max(x) - min(x)); 

SNR = [30, 25, 20, 15, 10, 5, 0, -5];
M = 8;
nrmse = zeros(1,M);

for i = 1:1:8
  n = awgn(x,snr,'measured');
  y = x + n;
  q = 5;
  k = 0:1:q;
  c3 = cum3(y,);
	
  h_est = = c3(q,k)/c3(q,0);
  x_est = conv(h_est,v);
	
  RMSE_est  = sqrt(sum(x_est - ).^2/N); 
  NRMSE_est = RMSE_est / (max() - min());
  nrmse[i] = NRMSE_est;
end

