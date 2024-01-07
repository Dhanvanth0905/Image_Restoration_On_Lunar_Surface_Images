function [absdiff,snr,psnr,imfid, mse] = compare(originalimg, restoredimg)
%Function to compare the original image with the
%restored image using some predefined methods
%Inputs: originalimg, restoredimg
%Returns: absdiff, snr, psnr, imfid, mse
%
%originalimg:  It is the original unblurred image
%restoredimg:  It is the restored image
%absdiff:      Average Absolute Difference
%snr:          Signal to Noise Ratio (dB)
%psnr:         Peak Signal to Noise Ratio (dB)
%imfid:        Image Fidelity
%mse:          Mean Square Error
%
%Example:
%      [absdiff, snr, psnr, imfid, mse] = compare(originalimg, restoredimg);
%      This call takes original image and the restored image and returns
%      the comparison of both the images using some predefined methods.
%Average absolute difference

md = originalimg - restoredimg;
mdsize = size(md);
summation = 0;
for i = 1:mdsize(1)
    for j = 1:mdsize(2)
        summation = summation + abs(md(i,j));
    end
end
absdiff = summation/(mdsize(1)*mdsize(2));

%Signal to Noise Ratio (SNR)

md = (originalimg - restoredimg).^2;
mdsize = size(md);
summation = 0;
sumsq=0;
for  i = 1:mdsize(1)
    for j = 1:mdsize(2)
        summation = summation + abs(md(i,j));
        sumsq = sumsq + (originalimg(i,j)^2);
    end
end
snr = sumsq/summation;
snr = 10 * log10(snr);

%Peak Signal to Noise Ratio (PSNR)

md = (originalimg - restoredimg).^2;
mdsize = size(md);
summation = 0;
sumsq=0;
for  i = 1:mdsize(1)
    for j = 1:mdsize(2)
        summation = summation + abs(md(i,j));
    end
end
psnr = size(originalimg, 1) * size(originalimg, 2) * max(max(originalimg.^2))/summation;
psnr = 10 * log10(psnr);

%Image Fidelity

md = (originalimg - restoredimg).^2;
mdsize = size(md);
summation = 0;
sumsq1 = 0;
for  i = 1:mdsize(1)
    for j = 1:mdsize(2)
        summation = summation + abs(md(i,j));
        sumsq1 = sumsq1 + (originalimg(i,j)^2);
    end
end
imfid = (1-summation)/sumsq1;

%Mean Square Error

diff = originalimg - restoredimg;
diff1 = diff.^2;
mse = mean(mean(diff1));