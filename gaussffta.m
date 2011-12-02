function pixels = gaussffta(pic, t)
%gaussffta Convolve with Gaussian
%   Convolves the image pic with a two-dimenstional Gaussian function of
%   arbitrary variance t via a discretizaion of the Gaussian function in
%   the spatial domain.
[w h] = size(pic);
%if w/2 == floor(w/2)
wrange = -w/2 : w/2-1;
%else
%    wrange = -(w/2
hrange = ceil(-h/2): ceil(h/2)-1;
[X Y] = meshgrid(wrange, hrange);
G = fftshift(exp(-(X .^ 2 + Y.^ 2) .* (1/(2*t))));
pixels = ifft2(fft2(G) .* fft2(pic));
