clear all; close all; clc;
pkg load signal;
pkg load statistics;

% ==============================
% load data from input files
% ==============================

% sampling frequency (192kHz)
fs = 192000;

maleA = audioread('samples/male/a.wav');
maleE = audioread('samples/male/e.wav');
maleI = audioread('samples/male/i.wav');
maleO = audioread('samples/male/o.wav');
maleU = audioread('samples/male/u.wav');

femaleA = audioread('samples/female/a.wav');
femaleE = audioread('samples/female/e.wav');
femaleI = audioread('samples/female/i.wav');
femaleO = audioread('samples/female/o.wav');
femaleU = audioread('samples/female/u.wav');

% =====================================
% Lifter the voice samples
% =====================================

maleCepA = cceps(maleA); femaleCepA = cceps(femaleA);
maleCepE = cceps(maleE); femaleCepE = cceps(femaleE);
maleCepI = cceps(maleI); femaleCepI = cceps(femaleI);
maleCepO = cceps(maleO); femaleCepO = cceps(femaleO);
maleCepU = cceps(maleU); femaleCepU = cceps(femaleU);
