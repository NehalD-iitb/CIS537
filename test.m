%testing myTransformImage.m
[baseline, baseline_spacing] = myReadNifti('baseline.nii');
[followup, followup_spacing] = myReadNifti('followup.nii');
data = load('-ascii', 'f2b.txt');
A = data(1:3, 1:3);
b = data(1:3, 4);
crosshair = [56 100 64];


transformedFollowup = myTransformImage(baseline, followup, A, b, 'linear');
myView(baseline, baseline_spacing, crosshair, [], 'jet')
myView(transformedFollowup, baseline_spacing, crosshair, [], 'jet')

%Testing your Gaussian Filter

deltaImage = zeros(31,31,31);
deltaImage(16,16,16) =1;
crosshair = [16,16,16];
sigma =4;
filtered = myGaussianLPF(deltaImage, sigma);
spacing = [1,1,1]';
myView(filtered, spacing, crosshair, [], 'jet')


%baseline image filtered with the Gaussian filter at sigma = 2 and filtered with the mean filter
%with radius 2.


sigma = 2;
crosshair = [56 100 64];
Gaussianfiltered = myGaussianLPF(baseline, sigma);
myView(Gaussianfiltered, baseline_spacing, crosshair, [], 'jet')

Meanfiltered = myMeanLPF(baseline, sigma);
myView(Meanfiltered, baseline_spacing, crosshair, [], 'jet')

%four difference images

crange = [-125,125];
difference1 = baseline - myTransformImage(baseline, followup, A, b, 'nearest');
myView(difference1, baseline_spacing, crosshair,crange, 'jet')

difference2 = baseline - myTransformImage(baseline, followup, A, b, 'linear');
myView(difference2, baseline_spacing, crosshair, crange, 'jet')

crange = [-1000,1000];
difference3 = myGaussianLPF(baseline, 2)- myTransformImage(baseline, myGaussianLPF(followup, 2), A, b, 'linear');
myView(difference3, baseline_spacing, crosshair, crange, 'jet')

crange = [-50,50];
difference4 = myMeanLPF(baseline, 2)- myTransformImage(baseline,myMeanLPF(followup, 2), A, b, 'linear');
myView(difference4, baseline_spacing, crosshair, crange, 'jet')

