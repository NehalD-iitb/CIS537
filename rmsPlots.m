[baseline, baseline_spacing] = myReadNifti('baseline.nii');
[followup, followup_spacing] = myReadNifti('followup.nii');
[seg, seg_spacing] = myReadNifti('seg.nii');
data = load('-ascii', 'f2b.txt');
A = data(1:3, 1:3);
b = data(1:3, 4);
sigma = [0:0.5:5];
radius = [0:10];
label =[1,2,3];
filterNum = 2;

    for i = 1: filterNum
       if i==1 %Gaussian filter
           RMSvalueGauss = zeros(3,size(sigma,2));
              for k = 1: size(sigma,2)
                  diff = myGaussianLPF(baseline, sigma(k))- myTransformImage(baseline, myGaussianLPF(followup, sigma(k)), A, b, 'linear');
                  for j = 1:size(label,2)         
                     RMSvalueGauss(j,k) = myRMSOverROI(diff, seg, label(j));    
                  end
              end
       else  %Mean filter
           RMSvalueMean = zeros(3,size(radius,2));
              for k = 1: size(radius,2)
                  diff = myMeanLPF(baseline, radius(k))- myTransformImage(baseline, myMeanLPF(followup, radius(k)), A, b, 'linear');
                  for j = 1:size(label,2)         
                     RMSvalueMean(j,k) = myRMSOverROI(diff, seg, label(j));    
                  end
              end
           
        end
    end
  
    
    
    for i=1:size(label,2)
           figure
           plot(sigma, RMSvalueGauss(i,:))
           title(sprintf('RMS for ROI %d, Gaussian', i))
           xlabel('sigma')
           ylabel('RMS')
           figure
           plot(radius, RMSvalueMean(i,:))
           title(sprintf('RMS for ROI %d, Mean', i))
           xlabel('radius')
           ylabel('RMS')
 
    end
    
    
 