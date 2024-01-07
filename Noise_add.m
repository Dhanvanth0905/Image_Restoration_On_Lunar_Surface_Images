% Read images from the "SourceImages" folder
source_folder = 'Path to the folder containing the source images';
image_files = dir(fullfile(source_folder, '*.png')); % or *.png, *.bmp, etc.

% Add noise and save to corresponding folders
for i = 1:numel(image_files)
    % Read the image
    img = imread(fullfile(source_folder, image_files(i).name));
    
    % Add Gaussian noise and save to "GaussianNoise" folder
    % you can change the noise levels by changing the 0.5 value
    img_gauss = imnoise(img, 'gaussian', 0, 0.5);
    imwrite(img_gauss, fullfile(strcat(source_folder,'\\GaussianNoise'), image_files(i).name));
    
    % Add Salt & Pepper noise and save to "SaltPepperNoise" folder
    img_sp = imnoise(img, 'salt & pepper', 0.5);
    imwrite(img_sp, fullfile(strcat(source_folder,'\\SaltPepperNoise'), image_files(i).name));

    % Add Speckle noise and save to "SpeckleNoise" folder
    img_speckle = imnoise(img, 'speckle', 0.5);
    imwrite(img_speckle, fullfile(strcat(source_folder,'\\SpeckleNoise'), image_files(i).name));
end
