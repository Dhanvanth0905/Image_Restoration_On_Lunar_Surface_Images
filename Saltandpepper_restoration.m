% Read images from the "Salt and Pepper noise" folder
noisy_folder = 'Path to the folder containing the Salt and Peper noise images ';
image_files = dir(fullfile(noisy_folder, '*.png')); % or *.png, *.bmp, etc.

% Apply filter and save to corresponding folders
for i = 1:numel(image_files)
    % Read the noisy image
    img_noisy = imread(fullfile(noisy_folder, image_files(i).name));
    
    % Apply Gaussian filter and save to "GaussianRestored" folder
    img_gauss = imgaussfilt(img_noisy, 1.5);
    restored = strcat(noisy_folder,'\\GaussianRestored');
    imwrite(img_gauss, fullfile(restored, image_files(i).name));
    
    % Apply Wiener filter and save to "WienerRestored" folder
    gray_noisy = rgb2gray(img_noisy);
    img_wiener = wiener2(gray_noisy);
    img_wiener = cat(3,img_wiener,img_wiener,img_wiener);
    restored = strcat(noisy_folder,'\\WienerRestored');
    imwrite(img_wiener, fullfile(restored, image_files(i).name));
    
    % Apply Median filter and save to "MedianRestored" folder
    img_median = medfilt2(gray_noisy);
    img_median = cat(3,img_median,img_median,img_median);
    restored = strcat(noisy_folder,'\\MedianRestored');
    imwrite(img_median, fullfile(restored, image_files(i).name));
end
