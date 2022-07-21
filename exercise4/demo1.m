clear all; close all; clc;
pkg load signal;

% ==============================
% load data from input files
% ==============================

% sampling frequency (192kHz)
fs = 192000;

maleA = audioread('samples/male/a.wav')(211:1:4682);
maleE = audioread('samples/male/e.wav')(972:1:5442);
maleI = audioread('samples/male/i.wav')(465:1:4612);
maleO = audioread('samples/male/o.wav')(1018:1:5442);
maleU = audioread('samples/male/u.wav')(1640:1:5557);

femaleA = audioread('samples/female/a.wav')(1997:1:6161);
femaleE = audioread('samples/female/e.wav')(1747:1:5715);
femaleI = audioread('samples/female/i.wav')(578:1:4154);
femaleO = audioread('samples/female/o.wav')(1018:1:4372);
femaleU = audioread('samples/female/u.wav')(2048:1:5471);

%figure(1); plot(maleA); xlabel('samples'); ylabel('signal'); title('a-male');
%figure(2); plot(maleE); xlabel('samples'); ylabel('signal'); title('e-male');
%figure(3); plot(maleI); xlabel('samples'); ylabel('signal'); title('i-male');
%figure(4); plot(maleO); xlabel('samples'); ylabel('signal'); title('o-male');
%figure(5); plot(maleU); xlabel('samples'); ylabel('signal'); title('u-male');

%figure(6); plot(femaleA); xlabel('samples'); ylabel('signal'); title('a-female');
%figure(7); plot(femaleE); xlabel('samples'); ylabel('signal'); title('e-female');
%figure(8); plot(femaleI); xlabel('samples'); ylabel('signal'); title('i-female');
%figure(9); plot(femaleO); xlabel('samples'); ylabel('signal'); title('o-female');
%figure(10); plot(femaleU); xlabel('samples'); ylabel('signal'); title('u-female');

% =====================================
% Lifter the voice samples
% =====================================


