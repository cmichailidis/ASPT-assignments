function [h, s] = lifter (x, a)
  % length of input signal
  n = length(x);

  % construct a window signal
  w = hamming(n);

  % apply window function w[n] to signal x[n]
  y = x .* w;

  % estimate the cepstrum of the windowed signal
  Y = fftshift(rceps(y));

  % debug information, remove later
  plot(log(1+50*abs(Y)));

  % construct a homomorphic filter which
  % will be applied in the quefrency domain.
  % currently the homomorphic filter is
  % implemented as unit-step function.
  % It may be more suitable to use a different
  % transfer function such a Gaussian curve or
  % a Butterworth filter to suppress the impact
  % of the ripple effect (aka Gibbs phenomenon)
  I = 1:1:n < a;

  % apply the homomorphic filter to split the
  % impulse responpse of the vocal chords from
  % the excitation signal.
  H = I .* Y;
  S = (1.0 - I) .* Y;

  % Move from the quefrency domain back to the
  % time domain by estimating the inverse cepstrum
  % of the impulse response and the excitation signal

  h = icceps(H);
  s = icceps(S);
end
