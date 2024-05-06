clear;
close all;
clc;

image = imread("input.jpg");
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
lowc = imread("lowc.png");
lowc = imresize(lowc, [512 512]);
lowc = im2gray(lowc);

minVal = min(gray2(:));
maxVal = max(gray2(:));
a = 255 / double(maxVal - minVal);

cont = gray2;
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
dark = imread("dark.png");
bright = imread("bright.png");
highc = imread("highc.png");
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
imshow(gray2);
title("Gray");

nexttile;
imshow(cont);
title("Contrast");
%%
figure("Name", "results3");
tiledlayout(4, 4);

nexttile;
imshow(dark);
title("dark");
nexttile;
imhist(dark);
title("histogram")
nexttile;
