function showedgedetect( image )
%UNTITLED2 Shows analysis of edge detection
subplot(1,1,1); % Clear
subplot(2,2,1); imshow(image); title('original');
gray = double(image(:,:,1)) + double(image(:,:,2)) + double(image(:,:,3));
% Sobel kernels for gradient approximation
dxkernel = [1 2 1]'*[-1 0 1];
dykernel = [1 0 -1]'*[1 2 1];
dx = conv2(gray, dxkernel, 'valid');
dy = conv2(gray, dykernel, 'valid');
grad = sqrt(dx.^2 + dy.^2);
subplot(2,2,2); showgray(grad); title('sobel kernel gradient');

subplot(2,2,3); showgray(edgek33(image, 'color')); title('edgek33 color only');
subplot(2,2,4); showgray(edgek33(image, 'gray')); title('edgek33 gray levels only');
%subplot(2,3,6); showgray(edgek33(image)); title('edgek33 full');
end

