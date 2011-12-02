function lab2_1( u, v, sz)
%LAB2_2 Display inverse fourier transform of a basis vector
%   u, v is the basis vector to be displayed


if (nargin < 2)
    error('Need 2 or 3 arguments');
end
if (nargin == 2)
    sz = 128;
end

Fhat = zeros(sz);
Fhat(u,v) = 1;

F = ifft2(Fhat);
Fabsmax = max(abs(F(:)));

%F2 = fft2(F);

% center the input image
if (u <= sz/2)
    uc = u - 1;
else
    uc = u - 1 - sz;
end

if (v <= sz/2)
    vc = v - 1;
else
    vc = v - 1 - sz;
end

Fabsmax

wavelength = 0.0; % TODO
amplitude = 1.0/sz % TODO
Fabsmax

subplot(2,3,1)
showgrey(Fhat);
title(sprintf('Fhat (u=%d v=%d)',u,v))

subplot(2,3,4)
showgrey(fftshift(Fhat));
title(sprintf('centered Fhat (uc=%d vu=%d)',uc,vc))

% subplot(2,3,4)
% showgrey(F2);
% title(sprintf('F2 (p=%d q=%d)',p,q))

subplot(2,3,2)
showgrey(real(F), 64, -Fabsmax, Fabsmax)
title('real(F)')

subplot(2,3,3)
showgrey(imag(F), 64, -Fabsmax, Fabsmax)
title('imag(F)')

subplot(2,3,5)
showgrey(abs(F), 64, -Fabsmax, Fabsmax)
title('abs(F)')

subplot(2,3,6)
showgrey(angle(F), 64, -pi, pi)
title('angle(F)')

end

