function filtered = myMeanLPF(image,radius)

    if radius ==0
        filtered = image;
        return
    end

    filter_len = 2 * radius + 1;
    meanFilter = ones(filter_len, filter_len, filter_len) ./ filter_len^3;
    filtered = imfilter3d(image, meanFilter);

end