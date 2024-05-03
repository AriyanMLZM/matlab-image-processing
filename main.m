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
image2 = imread
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
