% Ariyan Molazem
% 9911326

clc;
clear;
close all;

image = imread("./inputs/project.png");
image = im2gray(image);

sigma = 0.5;
alpha = 0.5;
lap = locallapfilt(image, sigma, alpha);
added_image = imadd(image, lap);
smoothed = imboxfilt(added_image, 5);
smoothed = imadd(image, smoothed);
gamma = 0.4;
smoothed = im2double(smoothed);
power_law = smoothed .^ gamma;

figure("Name", "Project");
tiledlayout(2, 3);

nexttile;
imshow(image);
title("original");

nexttile;
imshow(lap);
title("laplacian");

nexttile;
imshow(added_image);
title("added image");

nexttile;
imshow(smoothed);
title("smoothed");

nexttile;
imshow(power_law);
title("power law transform");
