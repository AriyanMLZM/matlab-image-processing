clc;
clear;
close all;

image = imread("input.jpg");
image = imresize(image, [512 512]);
image = im2gray(image);

count = 1;
compressed = cell(512, 1);
for row = 1:512
    cCol = 1;
    eachRow = [];
    for col = 1:511
        pixel = image(row, col);
        if pixel == image(row, col + 1)
            count = count + 1;
        else
            eachRow(1, cCol) = count;
            eachRow(1, cCol + 1) = pixel;
            cCol = cCol + 2;
            count = 1;
        end
    end
    compressed{row, 1} = eachRow;
end
