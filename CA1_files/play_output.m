clc; clear; close all;

Fs = 44100;
%dec2bin assumes the binary inputs are in unsigned format
data = bin2dec(strsplit(fileread('outputs.txt'), {'\r', '\n'}));
idx = data > (2^37-1);
data(idx) = data(idx) - 2^38;
data = data / (2^30);
sound(data, Fs);