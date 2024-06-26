clear;
close all;
clc;

image = imread("./inputs/input.jpg");
image = imresize(image, [512 512]);
%%
gray = im2gray(image);
%%
bw = gray;
threshold = input("Enter threshold: ");
for r = 1:512
    for c = 1:512
        if bw(r, c) <= threshold
            bw(r, c) = 0;
        else
            bw(r, c) = 255;
        end
    end
end
%%
f = fft2(gray);
f = fftshift(f);
%%
c = input("Enter c: ");
f_log = c * log(1 + f);
%%
lowc = imread("./inputs/lowc.png");
lowc = imresize(lowc, [512 512]);
lowc = im2gray(lowc);

minVal = min(lowc(:));
maxVal = max(lowc(:));
a = 255 / double(maxVal - minVal);

cont = lowc;
for r = 1:512
    for c = 1:512
        pixelVal = cont(r, c);
        if pixelVal <= minVal
            cont(r, c) = 0;
        elseif pixelVal >= maxVal
            cont(r, c) = 255;
        else
            cont(r, c) = a * double(pixelVal) - (a * double(minVal));
        end
    end
end
%%
dark = imread("./inputs/dark.png");
bright = imread("./inputs/bright.png");
highc = imread("./inputs/highc.png");
dark = imresize(dark, [512 512]);
bright = imresize(bright, [512 512]);
highc = imresize(highc, [512 512]);
dark = im2gray(dark);
bright = im2gray(bright);
highc = im2gray(highc);

histo_dark = histeq(dark);
histo_bright = histeq(bright);
histo_lowc = histeq(lowc);
histo_highc = histeq(highc);
%%
figure("Name", "results");
tiledlayout(2, 3);

nexttile;
imshow(image);
title("Color");

nexttile;
imshow(gray);
title("Gray");

nexttile;
imshow(bw);
title("BW");

nexttile;
imshow(f, []);
title("Fourier");

nexttile;
imshow(f_log, []);
title("Log");
%%
figure("Name", "results2");
tiledlayout(1, 2);

nexttile;
imshow(lowc);
title("Gray");

nexttile;
imshow(cont);
title("Contrast");
%%
figure("Name", "results3");

subplot(4, 4, 1);
imshow(dark);
title("dark");
subplot(4, 4, 2);
imhist(dark);
title("histogram");
subplot(4, 4, 3);
imshow(histo_dark);
title("histoeq");
subplot(4, 4, 4);
imhist(histo_dark);
title("histogram");

subplot(4, 4, 5);
imshow(bright);
title("bright");
subplot(4, 4, 6);
imhist(bright);
title("histogram");
subplot(4, 4, 7);
imshow(histo_bright);
title("histoeq");
subplot(4, 4, 8);
imhist(histo_bright);
title("histogram");

subplot(4, 4, 9);
imshow(lowc);
title("low contrast");
subplot(4, 4, 10);
imhist(lowc);
title("histogram");
subplot(4, 4, 11);
imshow(histo_lowc);
title("histoeq");
subplot(4, 4, 12);
imhist(histo_lowc);
title("histogram");

subplot(4, 4, 13);
imshow(highc);
title("high contrast");
subplot(4, 4, 14);
imhist(highc);
title("histogram");
subplot(4, 4, 15);
imshow(histo_highc);
title("histoeq");
subplot(4, 4, 16);
imhist(histo_highc);
title("histogram");
