image = double(imread('rubiks-cube2.jpg'))/255;
gray = double(image(:,:,1)) + double(image(:,:,2)) + double(image(:,:,3));

% Sobel kernels for gradient approximation
dxkernel = [1 2 1]'*[-1 0 1];
dykernel = [1 0 -1]'*[1 2 1];
dx = conv2(gray, dxkernel, 'valid');
dy = conv2(gray, dykernel, 'valid');
grad = sqrt(dx.^2 + dy.^2);
%subplot(2,2,2); showgray(grad); title('sobel kernel gradient');

subplot(1,1,1); % Clear
subplot(2,3,1); imshow(image); title('original');
subplot(2,3,4); showfs(fft2(gray)); title('fft2 gray');

subplot(2,3,2); showgray(grad); title('sobel kernel gradient of gray');
subplot(2,3,5); showfs(fft2(grad)); title('fft2 sobel kernel gradient of gray');

subplot(2,3,3); showgray(edgek33(image, 'color')); title('edgek33 color only');
subplot(2,3,6); showfs(fft2(edgek33(image, 'color'))); title('fft2 edgek33 color only');
