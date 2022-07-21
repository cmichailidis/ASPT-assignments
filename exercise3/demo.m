clear; clc;
pkg load signal;
pkg load statistics;
pkg load communications;

% =========================================
% 1) Construct v[k] and x[k]
% =========================================

% number of samples
N = 2048;

% zero-mean input signal
load data; m = mean(z);
v = z - m;

% coefficients of MA system
h0 = +1.00; h1 = +0.93; h2 = +0.85;
h3 = +0.72; h4 = +0.59; h5 = -0.10;
h = [h0, h1, h2, h3, h4, h5];

% output of MA-system
x = conv(v,h,'same');

% standard deviation of input signal
s = std(v);

% skewness of input signal
skewness = sum((z-m).^3)/((N-1)*s^3);

printf('The skewness of the input is %f\n', skewness);
printf('\n');

figure(1);
hist(z,32);
xlabel('Input signal v[k]');
ylabel('Frequency');
title('Histogram of v[k]');

% =========================================
% 2) Apply Giannakis' Formula to estimate
% the impulse response of the MA-system
% =========================================

% estimated coefficients (assuming 5th order system)
q = 5;
k = 1:1:(q+1);
c3 = cum3x(x,x,x,20,256,0.0,'biased',q);
h_est = c3(k)/c3(1);

% Reconstructed output signal
x_est = conv(v,h_est,'same');

printf('=======================================\n');
printf('Actual impulse response:\n');

for i=1:6
  printf('h[%d] = %f\n',i-1,h(i));
end

printf('\n');

printf('Estimated impulse response (5th order):\n');

for i=1:6
  printf('h[%d] = %f\n',i-1,h_est(i));
end

printf('\n');

% =========================================
% 3)
% sub-estimation: (3rd order system)
% sup-estimation: (8th order system)
% =========================================

% estimated coefficients and reconstructed
% output (assuming 3rd order MA-system)
q_sub = q-2;
k = 1:1:(q_sub+1);
c3 = cum3x(x,x,x,20,256,0.0,'biased',q_sub);
h_sub = c3(k)/c3(1);
x_sub = conv(v,h_sub,'same');

% estimated coefficients and reconstructed
% output (assuming 8th order MA-system)
q_sup = q+3;
k = 1:1:(q_sup+1);
h_sup = c3(k)/c3(1);
c3 = cum3x(x,x,x,20,256,0.0,'biased',q_sup);
x_sup = conv(v,h_sup,'same');

printf('Sub-estimated impulse response (3rd order):\n');

for i=1:4
  printf('h[%d] = %f\n', i-1, h_sub(i));
end

printf('\n');

printf('Sup-estimated impulse response (8th order):\n');

for i=1:9
  printf('h[%d] = %f\n', i-1, h_sup(i));
end

printf('\n');

figure(2);
plot(x,'k', x_est,'r');
xlabel('time axis / samples');
ylabel('MA-system output');
title('actual output signal vs 5th order reconstructed output');
legend('x[k]', 'x_{est}[k]');

figure(3);
plot(x,'k', x_sub,'r');
xlabel('time axis / samples');
ylabel('MA-system output');
title('actual output signal vs 3rd order reconstructed output');
legend('x[k]', 'x_{sub}[k]');

figure(4);
plot(x,'k', x_sup,'r');
xlabel('time axis / samples');
ylabel('MA-system output');
title('actual output signal vs 8th order reconstructed output');
legend('x[k]', 'x_{sup}[k]');

% =========================================
% 4) Calculate some estimation metrics
% =========================================

% RMSE and NRMSE for 5th order reconstruction
RMSE_est  = sqrt(sum((x_est - x).^2)/N);
NRMSE_est = RMSE_est / (max(x) - min(x));

% RMSE and NRMSE for 3rd order reconstruction
RMSE_sub  = sqrt(sum((x_sub - x).^2)/N);
NRMSE_sub = RMSE_sub / (max(x) - min(x));

% RMSE and NRMSE for 8th order reconstruction
RMSE_sup  = sqrt(sum((x_sup - x).^2)/N);
NRMSE_sup = RMSE_sup / (max(x) - min(x));

printf('==================================');
printf('\n');

printf('evaluation metrics for 5th order reconstruction\n');
printf('RMSE = %f\n', RMSE_est);
printf('NRMSE = %f\n', NRMSE_est);

printf('evaluation metrics for 3rd order reconstruction\n');
printf('RMSE = %f\n', RMSE_sub);
printf('NRMSE = %f\n', NRMSE_sub);

printf('evaluation metrics for 8th order reconstruction\n');
printf('RMSE = %f\n', RMSE_sup');
printf('NRMSE = %f\n', NRMSE_sup);

% =========================================
% 5) Effect of additive gaussian noise
% on impulse response estimation and output
% signal reconstruction
% =========================================

% list for different noise levels (in dB)
SNR = [30, 25, 20, 15, 10, 5, 0, -5];
M = length(SNR);

% list for NRMSE at every different noise level
nrmse = zeros(1,M);

iter = 20;

for j = 1:iter
  for i = 1:M
    % contaminate the output signal
    % with additive gaussian noise
    y = awgn(x,SNR(i),'measured');

    % apply Giannakis' Formula to
    % reconstruct the impulse response
    q = 5;
    k = 1:1:(q+1);
    c3 = cum3x(y,y,y,20,256,0.0,'biased',q);
    h_est = c3(k)/c3(1);

    % Estimate the output of the system
    y_est = conv(v,h_est,'same');

    % Calculate RMSE and NRMSE metrics
    RMSE_est = sqrt(sum((y_est-y).^2)/N);
    NRMSE_est = RMSE_est / (max(y) - min(y));
    nrmse(i) = nrmse(i) + NRMSE_est / iter;
  end
end

figure(5);
plot(SNR, log10(nrmse), 'linestyle','--', 'marker','o', 'markerfacecolor', 'r');
xlabel('Signal to Noise Ratio in dB');
ylabel('NRMSE in log10 scale');
title('NRMSE vs SNR (average of 10 realizations)');
