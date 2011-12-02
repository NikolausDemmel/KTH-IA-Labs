% 1. Displaying images
subplot(1,1,1)
% Load and display gray scale image
load canoe256
image(Canoe)
colormap(gray(256))
colorbar
axis equal
pause

showgray(Canoe)
pause
showgray(Canoe, 4)
pause

% Phone
phone = phonecalc256;
showgray(phone, 256); title('256');
pause
showgray(phone, 128); title('128');
pause
showgray(phone, 64); title('64');
pause
showgray(phone, 32); title('32');
pause
showgray(phone, 16); title('16');
pause
showgray(phone, 8); title('8');
pause
showgray(phone, 4); title('4');
pause
showgray(phone, 2); title('2');
pause

% What is this?
vad = whatisthis256;
showgray(vad)
pause

zmin = min(vad(:))
zmax = max(vad(:))
showgray(vad, 64, zmin, zmax)
pause

showgray(vad, 64, 0, 50)
pause
showgray(vad, 64, 0, 40)
pause
showgray(vad, 64, 10, 40)
pause

% Load as function
nallo = nallo256;
image(nallo)
colormap(gray(256))
colormap(cool)
colormap(hot)
pause

% 2. Subsampling

% function pixels = rawsubsample(inpic)
% [m, n] = size(inpic);
% pixels = inpic(1:2:m, 1:2:n);

ninepic = indexpic9
rawsubsample(ninepic)

% Subsample phone

sub = rawsubsample(Canoe);
subplot(5,2,1); showgray(sub); title('subsample once');
sub = rawsubsample(sub);
subplot(5,2,3); showgray(sub); title('subsample twice');
sub = rawsubsample(sub);
subplot(5,2,5); showgray(sub); title('subsample three times');
sub = rawsubsample(sub);
subplot(5,2,7); showgray(sub); title('subsample four times');
sub = rawsubsample(sub);
subplot(5,2,9); showgray(sub); title('subsample five times');

sub = rawsubsample(phone);
subplot(5,2,2); showgray(sub); title('subsample once');
sub = rawsubsample(sub);
subplot(5,2,4); showgray(sub); title('subsample twice');
sub = rawsubsample(sub);
subplot(5,2,6); showgray(sub); title('subsample three times');
sub = rawsubsample(sub);
subplot(5,2,8); showgray(sub); title('subsample four times');
sub = rawsubsample(sub);
subplot(5,2,10); showgray(sub); title('subsample five times');

pause

sub = rawsubsample(phone);
sub = rawsubsample(sub);
subplot(1,1,1);
subplot(2,1,1); showgray(sub); title('rawsubsample');

sub = binsubsample(phone);
sub = binsubsample(sub);
subplot(2,1,2); showgray(sub); title('binsubsample');

pause

% 3. Gray-level transformations and look-up tables

neg1 = -Canoe;
neg2 = 255 - Canoe;

subplot(4,2,1)
showgray(neg1); title('neg1');
subplot(4,2,2)
showgray(neg2); title('neg2');
subplot(4,2,3)
hist(neg1(:)); title('neg1 histogram');
subplot(4,2,4)
hist(neg2(:)); title('neg2 histogram');
subplot(4,2,5)
showgray(nallo .^(1/3)); title('nallo .^(1/3)');
subplot(4,2,6)
showgray(cos(nallo/10)); title('cos(nallo/10)');
subplot(4,2,7)
plot( 1:255, (1:255) .^ (1/3) )
subplot(4,2,8)
plot( 1:255, cos((1:255)/10) )

pause

% Look-up tables

negtransf = (255: -1 : 0)';
neg3 = compose(negtransf, Canoe + 1);
diff = neg3 - neg2;
dmin = min(diff(:))
dmax = max(diff(:))
subplot(1,1,1)
image(diff): title('diff');

pause

% Manipulation of colour tables

subplot(2,1,1)
image(Canoe +1)
negcolormapcol = linspace(1, 0, 256)';
colormap([negcolormapcol negcolormapcol negcolormapcol])
title('manipulation of colortables')

subplot(2,1,2)
showgray(Canoe, linspace(1,0,256), 0, 255)
title('showgray can do the same')

% 4. Stretching of gray-levels

subplot(1,1,1);
nallo = nallo256float;
subplot(4,3,[1 5]);
showgray(nallo);
title('original nallo');

subplot(4,3,3);
hist(nallo(:));
title('original histogram');

subplot(4,3,[7 11]);
zmin = min(nallo(:));
zmax = max(nallo(:));
nallo2 = (nallo - zmin) / (zmax-zmin); % Scale into range 0-1
alpha = 0.1;
lognallo = log(alpha + nallo2);
showgray( lognallo );
title('nallo log transformed');

subplot(4,3,9);
y = (linspace(0,1,256) - zmin) / (zmax-zmin);
y = log(alpha + y);
plot(linspace(0,1,256), y);
title('log transformation');

subplot(4,3,12);
hist(lognallo(:));
title('histogram of log transformed image');

% 5. Histogram equalization
verbose = 1;
subplot(1,1,1)
subplot(2,2,1); showgray(histeq(nallo, 16, verbose));
subplot(2,2,2); showgray(histeq(nallo, 64, verbose));
subplot(2,2,3); showgray(histeq(nallo, 256, verbose));
subplot(2,2,4); showgray(histeq(histeq(nallo, 256, verbose), 256, verbose));

pause

% Do it twice in a row
singl = histeq(nallo, 1e6, 0);
dbl = histeq(singl, 1e6, 0);
err = norm(singl(:)-dbl(:))
subplot(1,2,1);
hist(singl(:),256)
subplot(1,2,2);
hist(dbl(:),256)

im1 = histeq(nallo, 256, 0);
im2 = histeq(nallo, 1e6, 0);
h1 = hist(im1(:),256);
h2 = hist(im2(:),256);
subplot(1,2,1);
hist(im1(:),256)
subplot(1,2,2);
hist(im2(:),256)

pause

im1 = histeq(nallo, 256, verbose);
im2 = -histeq(-nallo, 256, verbose);
h1 = hist(im1(:),256);
h2 = hist(im2(:),256);
histerr = norm(h1-h2)

subplot(2,2,1);
showgray(im1);
subplot(2,2,2);
showgray(im2);
subplot(2,2,3);
hist(im1(:),256);
subplot(2,2,4);
hist(im2(:),256);

pause


