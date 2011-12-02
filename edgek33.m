function pixels = edgek33( image, options )
%EDGEK33 Rasmus Göranssons K33 edge detection
%   Edge detection in color
%   The result is similar to gradient magnitude
%   but takes color information into account

red = double(image(:,:,1));
gre = double(image(:,:,2));
blu = double(image(:,:,3));

rg = red-gre;
gb = gre-blu;
br = blu-red;

% Small kernels for gradient approximation
dxkernel = [1 1]'*[-1 1];
dykernel = [1 -1]'*[1 1];

dxkernel2 = [1 1]'*[-2 2];
dykernel2 = [2 -2]'*[1 1];

dx_red = conv2(red, dxkernel, 'valid');
dy_red = conv2(red, dykernel, 'valid');

dx_gre = conv2(gre, dxkernel, 'valid');
dy_gre = conv2(gre, dykernel, 'valid');

dx_blu = conv2(blu, dxkernel, 'valid');
dy_blu = conv2(blu, dykernel, 'valid');

dx_rg = conv2(rg, dxkernel2, 'valid');
dy_rg = conv2(rg, dykernel2, 'valid');

dx_gb = conv2(gb, dxkernel2, 'valid');
dy_gb = conv2(gb, dykernel2, 'valid');

dx_br = conv2(br, dxkernel2, 'valid');
dy_br = conv2(br, dykernel2, 'valid');

if nargin < 2 || strcmp(options, 'full')
    pixels = sqrt( ...
        dx_red .^ 2 + dy_red .^ 2 + ...
        dx_gre .^ 2 + dy_gre .^ 2 + ...
        dx_blu .^ 2 + dy_blu .^ 2 + ...
        dx_rg .^ 2 + dy_rg .^ 2 + ...
        dx_gb .^ 2 + dy_gb .^ 2 + ...
        dx_br .^ 2 + dy_br .^ 2 );
elseif strcmp(options, 'gray')
    pixels = sqrt( ...
        dx_red .^ 2 + dy_red .^ 2 + ...
        dx_gre .^ 2 + dy_gre .^ 2 + ...
        dx_blu .^ 2 + dy_blu .^ 2 );
elseif strcmp(options, 'color')
    pixels = sqrt( ...
        dx_rg .^ 2 + dy_rg .^ 2 + ...
        dx_gb .^ 2 + dy_gb .^ 2 + ...
        dx_br .^ 2 + dy_br .^ 2 );
else
    error( 'unknown option: %s', options );
end
end

