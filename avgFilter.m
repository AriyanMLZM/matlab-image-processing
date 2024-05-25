clear;
close all;
clc;

image = imread("input.jpg");
image = imresize(image, [512 512]);
gray = im2gray(image);

noised = imnoise(gray, 'salt & pepper');

sum = 0;
mask = ones(3);
smoothed = zeros(512 - 2);
for row = 1:(512 - 2)
    for col = 1:(512 - 2)
        for innerRow = row:(row + 2)
            for innerCol = col:(col + 2)
                sum =  sum + double(noised(innerRow, innerCol));
            end
        end
        avg = sum / 9;
        avg = avg / 255;
        smoothed(row, col) = avg;
        sum = 0;
    end
end

imshow(smoothed)
