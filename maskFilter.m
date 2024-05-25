clear;
close all;
clc;

image = imread("input.jpg");
image = imresize(image, [512 512]);
gray = im2gray(image);

noised = imnoise(gray, 'salt & pepper');

mask = ones(3);

sum = 0;
smoothed_avg = zeros(512 - 2);
for row = 1:(512 - 2)
    for col = 1:(512 - 2)
        maskRow = 1;
        for innerRow = row:(row + 2)
            maskCol = 1;
            for innerCol = col:(col + 2)
                sum = sum + double(noised(innerRow, innerCol)) * mask(maskRow, maskCol);
                maskCol = maskCol + 1;
            end
            maskRow = maskRow + 1;
        end
        avg = sum / 9;
        avg = avg / 255;
        smoothed_avg(row, col) = avg;
        sum = 0;
    end
end

smoothed_med = zeros(512 - 2);
med_list = zeros(3);
for row = 1:(512 - 2)
    for col = 1:(512 - 2)
        maskRow = 1;
        for innerRow = row:(row + 2)
            maskCol = 1;
            for innerCol = col:(col + 2)
                med_list(maskRow, maskCol) = double(noised(innerRow, innerCol)) * mask(maskRow, maskCol);
                maskCol = maskCol + 1;
            end
            maskRow = maskRow + 1;
        end
        med = median(med_list, "all");
        med = med / 255;
        smoothed_med(row, col) = med;
    end
end

figure("Name", "Mask Filters");
tiledlayout(2, 2);

nexttile;
imshow(gray);
title("Gray");

nexttile;
imshow(noised);
title("Salt & Pepper noised");

nexttile;
imshow(smoothed_avg);
title("Avg Mask Filter");

nexttile;
imshow(smoothed_med);
title("Median Mask Filter");

