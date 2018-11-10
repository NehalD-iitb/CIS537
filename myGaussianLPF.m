function filtered = myGaussianLPF(image, sigma)
 
    if sigma==0
        filtered = image;
        return
    end
 
 
    filter_len = ceil(6 * sigma + 1);
    if mod(filter_len, 2) == 0
       filter_len = filter_len + 1;
    end
    
    [x,y,z] = ndgrid(1:filter_len, 1:filter_len, 1:filter_len);
    gaussian_filterX = Gaussian1D(x,sigma,filter_len);
    gaussian_filterY = Gaussian1D(y,sigma,filter_len);
    gaussian_filterZ = Gaussian1D(z,sigma,filter_len);
    G = 1 / (sigma*(2*pi)^0.5) *gaussian_filterX.*gaussian_filterY.*gaussian_filterZ;
    filtered = imfilter3d(image, G);
end
 
 
function gauss = Gaussian1D(t,sigma,filter_len)
    t = (t - (filter_len+1)/2);
    gauss =  exp((-1/(2*sigma^2)) *(t.^2));
end



