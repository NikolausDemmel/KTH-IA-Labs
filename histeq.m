function pixels = histeq( image, nacc, verbose )
%HISTEQ Histogram equalization of gray-level image
% Find min and max
zmin = min(image(:));
zmax = max(image(:));

% Rescale values
rimage = (image-zmin)/(zmax-zmin);

% Find bucket indices
%iimage = 1 + round( rimage*(nacc-1) );
iimage = 1 + floor( rimage*(nacc-1e-10));
i2image = 1 + floor( rimage*(nacc+1-1e-10));

% Create histogram
h = zeros(1,nacc);
for i = iimage(:)'
    h(i) = h(i) + 1; % count it
end

h2 = hist(image(:),nacc);

%err = sum((h - h2).^2)

%hh = [h' h2']

% Calculate the accumulative sum
acc = cumsum(h/numel(image));

% Rescale to original scale
acc = acc*(zmax-zmin) + zmin;

% Compose using the accumulative sum as the look-up table
pixels = compose([0 acc], i2image);
%pixels = compose(acc, iimage);

% Verbose output
if verbose > 0
    h % Output histogram as vector
    oldh = gcf; % Keep track of old figure handle
    figure % Create new figure
    subplot(2,2,1);
    showgray(image)
    subplot(2,2,2);
    hist(image(:), nacc)
    subplot(2,2,3);
    showgray(pixels);
    subplot(2,2,4);
    hist(pixels(:), nacc);
    
    figure(oldh); % Switch back
end

end

