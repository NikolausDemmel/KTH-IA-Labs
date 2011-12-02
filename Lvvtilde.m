function pixels = Lvvtilde( inpic, shape )
%LVVTILDE Second order derivative
%   
if nargin < 2
    shape = 'same';
end
dx = [0 0 0 0 0; 0 0 0 0 0; 0 -1/2 0 1/2 0; 0 0 0 0 0; 0 0 0 0 0];
dxx = [0 0 0 0 0; 0 0 0 0 0; 0 1 -2 1 0; 0 0 0 0 0; 0 0 0 0 0];
dy = dx';
dyy = dxx';
dxy = conv2(dx,dy, 'same');

Lx = conv2(inpic, dx, shape);
Ly = conv2(inpic, dy, shape);
Lxx = conv2(inpic, dxx, shape);
Lyy = conv2(inpic, dyy, shape);
Lxy = conv2(inpic, dxy, shape);

pixels = (Lx .^ 2).*Lxx + 2*Lx.*Ly.*Lxy + (Ly .^ 2).*Lyy;

end
