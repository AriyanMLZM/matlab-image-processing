clc;
clear;
close all;

% a) get image
image = imread("./inputs/project.png");
image = im2gray(image);

% b) implement laplacian
lap = locallapfilt(image, 0.5, 0.5);

% c) add laplacian to original
added_image = imadd(image, lap);

% d) implement sobel gradient
[gmag, gdir] = imgradient(image, "sobel");

% e) implement smoothing with box filter 5x5
smoothed = imboxfilt(uint8(gdir), 5);

% f) get product of e and b
product = immultiply(lap, smoothed);

% g) add original to f
added_image2 = imadd(image, product);

% h) implement power law transform
gamma = 0.4;
added_image2 = im2double(added_image2);
power_law = added_image2 .^ gamma;

imshow(power_law)