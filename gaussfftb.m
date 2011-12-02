function pixels = gaussfftb(pic, t)
%gaussfftb Gaussian smoothing in Fourier domain
%   Performs smoothing based on a definition of the filter in Fourier
%   domain
[w h] = size(pic);
%x = linspace(-pi, pi, w); 
x = ((-w/2:w/2-1)/(w))*2*pi;
[X Y] = meshgrid(x, x);
Ghat = fftshift( exp(-(X .^ 2 + Y.^ 2) .* (t/2)) );
pixels = real(ifft2(fft2(pic) .* Ghat));
end
