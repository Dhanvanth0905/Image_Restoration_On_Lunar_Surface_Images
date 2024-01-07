original_folder = 'Path to the folder containing the original images';
restored_folders = {'\\GaussianNoise\\GaussianRestored','\\GaussianNoise\\WienerRestored','\\GaussianNoise\\MedianRestored'
    '\\SaltPepperNoise\\GaussianRestored','\\SaltPepperNoise\\WienerRestored','\\SaltPepperNoise\\MedianRestored'
    '\\SpeckleNoise\\GaussianRestored','\\SpeckleNoise\\WienerRestored','\\SpeckleNoise\\MedianRestored'};
% ,'\\GaussianNoise\\WienerRestored','\\GaussianNoise\\MedianRestored'

for i = 1:numel(restored_folders)
    image_files = dir(fullfile(original_folder, '*.png'));
    restored_folder =strcat(original_folder,restored_folders{i});
    disp(restored_folder);
    mean_abs_diff = im2double(zeros(numel(image_files), 1));
    mean_snr = im2double(zeros(numel(image_files), 1));
    mean_psnr = im2double(zeros(numel(image_files), 1));
    mean_imfid = im2double(zeros(numel(image_files), 1));
    mean_mse = im2double(zeros(numel(image_files), 1));

    for j=1:numel(image_files)
        img_original = im2double(imread(fullfile(original_folder, image_files(i).name)));
        img_restored = im2double(imread(fullfile(restored_folder, image_files(i).name)));
        [absdiff,snr,psnr,imfid, mse] = compare(img_original,img_restored);
        mean_abs_diff(i) = absdiff;
        mean_snr(i) = snr;
        mean_psnr(i) = (psnr(1)+psnr(2)+psnr(3))/3;
        mean_imfid(i) = imfid;
        mean_mse(i) = (mse(1)+mse(2)+mse(3))/3;

%         fid = fopen(fullfile(restored_folder, 'Metrics.txt'), 'a');
%         fprintf(fid, '%s\n', image_files(i).name);
%         fprintf(fid, 'MSE: %.2f\n', mse);
%         fprintf(fid, 'SNR: %.2f dB\n', snr);
%         fprintf(fid, 'PSNR: %.2f dB\n', psnr);
% %         fprintf(fid, 'Image Fidelity: %.2f\n', fi);
% %         fprintf(fid, 'Similarity Index: %.2f\n\n', sim);
%         fclose(fid);
    end
    m_abs_diff = mean(mean_abs_diff);
    m_snr = mean(mean_snr);
    m_psnr = mean(mean_psnr);
    m_imfid = mean(mean_imfid);
    m_mse = mean(mean_mse);
    disp("Mean Abs Diff = " + num2str(m_abs_diff));
    disp("Mean SNR = " + num2str(m_snr));
    disp("Mean PSNR = " + num2str(m_psnr));
    disp("Mean Imfid = " + num2str(m_imfid));
    disp("Mean MSE = " + num2str(m_mse));
end
