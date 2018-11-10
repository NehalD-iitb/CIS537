function value = myRMSOverROI(image, seg, label)

roiDiff = image(seg == label);
roiSize = sum(seg == label,'all');
value = sqrt((sum(roiDiff.^2))/roiSize);

end