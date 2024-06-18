clc;
clear;
close all;

% a) get image
image = imread("input.jpg");
image = imresize(image, [512 512]);
image = im2gray(image);

% b) implement laplacian
lap = locallapfilt(image, 0.5, 0.5);

% c) add laplacian to original
added_image = imadd(image, lap);
