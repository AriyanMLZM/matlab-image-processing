clear;
close all;
clc;

image = imread("input.jpg");
image = imresize(image, [512 512]);
gray = im2gray(image);

noised = imnoise(gray, 'salt & pepper');

imshow(noised);