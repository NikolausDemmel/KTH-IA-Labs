function lab2()
while 1
    choice = menu('Choose a section', ...
        'Question 1: Sample points', ...
        'Question 2: Sine waves', ...
        'Question 5: Pass the center', ...
        '1.4 Linearity', ...
        '1.5 Multiplication', ...
        '1.6 Scaling', ...
        '1.7 Rotation', ...
        '1.8 Rotational symmetry', ...
        '1.9 Translation', ...
        '2 Phase  vs Magnitude', ...
        '3 Gaussian Filter on deltafcn', ...
        '3 A couple of images', ...
        '4 Smoothing', ...
        '4 Ideal low-pass filter', ...
        '5 Sharpening');
    switch choice
        case 1
            q1();
        case 2
            q2();
        case 3
            q5();
        case 4
            s14();
        case 5
            s15();
        case 6
            s16();
        case 7
            s17();
        case 8
            s18();
        case 9
            s19();
        case 10
            s2();
        case 11
            s3();
        case 12
            s3b();
        case 13
            s4();
        case 14
            s4i();
        case 15
            s5();
        otherwise
            break
    end     
end

% Question 1: Sample points
function q1()
set(figure(1),'Name', 'Question 1: Sample points');
lab2_1(5, 9);
pause
lab2_1(9, 5);
pause
lab2_1(17, 19);
pause
lab2_1(17, 121);
pause

% Question 2: Sine waves
function q2()
set(figure(1),'Name', 'Question 2: Sine waves');
lab2_1(1, 1);
pause
lab2_1(2, 1);
pause
lab2_1(2, 2);
pause
lab2_1(1, 2);
pause
lab2_1(128, 2);
pause
lab2_1(128, 1);
pause
lab2_1(128, 128);
pause
lab2_1(1, 128);
pause
lab2_1(2, 128);
%pause

% Question 5: Pass the center
function q5()
set(figure(1),'Name', 'Question 5: Pass the center');
for x=1:128
    lab2_1(x,1);
    drawnow;
end
%pause

% 1.4 Linearity
function s14()
F = [ zeros(56, 128); ones(16, 128); zeros(56,128) ];
G = F';
H = F + 2 * G;

Fhat = fft2(F);
Ghat = fft2(G);
Hhat = fft2(H);

set(figure(1),'Name', '1.4 Linearity');
subplot(1,1,1); % Clear
subplot(3,3,1); showgrey(F);
subplot(3,3,2); showgrey(G);
subplot(3,3,3); showgrey(H);
subplot(3,3,4); showgrey(log(1 + abs(Fhat)));
subplot(3,3,5); showgrey(log(1 + abs(Ghat)));
subplot(3,3,6); showgrey(log(1 + abs(Hhat)));
subplot(3,3,7); showgrey(log(1 + abs(fftshift(Fhat))));
subplot(3,3,8); showgrey(log(1 + abs(fftshift(Ghat))));
subplot(3,3,9); showgrey(log(1 + abs(fftshift(Hhat))));
%pause

% 1.5 Multiplication
function s15()
F = [ zeros(56, 128); ones(16, 128); zeros(56,128) ];
G = F';
Fhat = fft2(F);
Ghat = fft2(G);

set(figure(1),'Name', '1.5 Multiplication');
subplot(1,1,1); % Clear
subplot(2,2,1); showgrey(F .* G); title('F .* G');
subplot(2,2,2); showfs(fft2(F .* G)); title('fft2(F .* G)');
subplot(2,3,4); showfs(Fhat); title('fft2(F)');
subplot(2,3,5); showfs(Ghat); title('fft2(G)');
subplot(2,3,6); showfs( fftshift(conv2(fftshift(Fhat), fftshift(Ghat), 'same')) ); % FIXME!!!!
%pause

% 1.6 Scaling
function s16()
F = [zeros(60, 128); ones(8, 128); zeros(60,128)] .* ...
    [zeros(128,48) ones(128, 32) zeros(128, 48)];

set(figure(1),'Name', '1.6 Scaling');
subplot(1,1,1); % Clear
subplot(2,2,1); showgrey(F);
subplot(2,2,2); showfs(fft2(F));
%pause

for alpha=0:0.01:2*pi
    i = round(32-32*sin(alpha));
    F = [zeros(64-i, 128); ones(2*i, 128); zeros(64-i,128)] .* ...
        [zeros(128,48) ones(128, 32) zeros(128, 48)];

    subplot(2,2,3); showgrey(F);
    subplot(2,2,4); showfs(fft2(F));
    drawnow;
end
%pause

% 1.7 Rotation
function s17()
F = [zeros(60, 128); ones(8, 128); zeros(60,128)] .* ...
    [zeros(128,48) ones(128, 32) zeros(128, 48)];
Fhat = fft2(F);
vinkel = 30;
G = rot(F, vinkel);                            % Rotate
Ghat = fft2(G);                                % Transform
Hhat = fftshift(rot(fftshift(Ghat), -vinkel)); % Undo rotation
H = abs(ifft2(fftshift(Hhat)));                % Undo transform

% Cropped version
s = size(G)/2;
Hhat2 = [ Hhat(1:s(1), 1:s(2)), Hhat(1:s(1), end-s(2)+1:end); ...
          Hhat(end-s(1)+1:end, 1:s(2)), Hhat(end-s(1)+1:end, end-s(2)+1:end)];
H2 = abs(ifft2(fftshift(Hhat2))); % Undo transform

set(figure(1),'Name', '1.7 Rotation');
subplot(1,1,1); % Clear
subplot(2,4,1); showgrey(F); axis on; title('F');
subplot(2,4,2); showgrey(G); axis on; title('G');
subplot(2,4,3); showgrey(H); axis on; title('H');
subplot(2,4,4); showgrey(H2); axis on; title('ifft2 of Hhat cropped');
subplot(2,4,5); showfs(Fhat); axis on; title('Fhat');
subplot(2,4,6); showfs(Ghat); axis on; title('Ghat');
subplot(2,4,7); showfs(Hhat); axis on; title('Hhat');
subplot(2,4,8); showfs(Hhat2); axis on; title('Hhat cropped');
%pause

% 1.8 Rotational symmetry
function s18()
[G H] = meshgrid(-64:63, -64:63);
F = G .^ 2 + H .^ 2 < 128;
set(figure(1),'Name', '1.8 Rotational symmetry');
subplot(1,1,1); % Clear
subplot(2,2,1); showgrey(F);     title('F');
subplot(2,2,2); showfs(fft2(F)); title('Fhat');
subplot(2,2,3); showgrey(G);     title('G');
subplot(2,2,4); showgrey(H);     title('H');

% 1.9 Translation
function s19()
[G H] = meshgrid(-64:63, -64:63);
F = G .^ 2 + H .^ 2 < 128;
G = [F(:,21:128) F(:, 1:20)];
Fhat = fft2(F);
Ghat = fft2(G);
set(figure(1),'Name', '1.9 Translation');
subplot(1,1,1); % Clear
subplot(2,3,1); showgrey(F);     title('F');
subplot(2,3,2); showfs(Fhat);    title('Fhat magnitude');
subplot(2,3,3); showgrey(angle(Fhat), 64, -pi, pi); title('Fhat angle');
subplot(2,3,4); showgrey(G); title('G');
subplot(2,3,5); showfs(Ghat); title('Ghat magnitude');
subplot(2,3,6); showgrey(angle(Ghat), 64, -pi, pi); title('Ghat angle');

% 2 Phase  vs Magnitude
function s2()
phone = phonecalc128();
few = few128();
nallo = nallo128();
F = [ zeros(56, 128); ones(16, 128); zeros(56,128) ];

a = 1e-10;

set(figure(1),'Name', '2 Phase vs Magnitude');
subplot(1,1,1); % Clear
subplot(3,4,1); showgrey(phone); title('phonecalc128');
subplot(3,4,2); showgrey(few); title('few128');
subplot(3,4,3); showgrey(nallo); title('nallo128');
subplot(3,4,4); showgrey(F); title('F');
subplot(3,4,5); showgrey(pow2image(phone,a)); title('pow2image(phonecalc128)');
subplot(3,4,6); showgrey(pow2image(few,a)); title('pow2image(few128)');
subplot(3,4,7); showgrey(pow2image(nallo,a)); title('pow2image(nallo128)');
subplot(3,4,8); showgrey(pow2image(F,a)); title('pow2image(F)');
subplot(3,4,9); showgrey(randphaseimage(phone)); title('randphaseimage(phonecalc128)');
subplot(3,4,10); showgrey(randphaseimage(few)); title('randphaseimage(few128)');
subplot(3,4,11); showgrey(randphaseimage(nallo)); title('randphaseimage(nallo128)');
subplot(3,4,12); showgrey(randphaseimage(F)); title('randphaseimage(F)');

% 3 Gaussian Filter
function s3()
set(figure(1),'Name', '3 Gaussian Filter on deltafcn');
subplot(1,1,1); % Clear

pic = deltafcn(128, 128);
i=1;
for t=[0.1 1 10 100]
    subplot(3,4,i);
    psf = gaussffta(pic, t);
    v = variance(psf);
    showgray(psf);
    title(sprintf('gaussffta t = %g \nvar = [%f %f;\n %f %f]', t, v(1,1), v(1,2), v(2,1), v(2,2)));
    i = i+1;
end

for t=[0.1 1 10 100]
    subplot(3,4,i);
    psf = gaussfftb(pic, t);
    v = variance(psf);
    showgray(psf);
    title(sprintf('gaussfftb t = %g \nvar = [%f %f;\n %f %f]', t, v(1,1), v(1,2), v(2,1), v(2,2)));
    i = i+1;
end

for t=[0.1 1 10 100]
    subplot(3,4,i);
    psf = gaussfftb(pic, t);
    v = variance(psf);
    showfs(fft2(psf));
    title(sprintf('fft2 gaussfftb t = %g \nvar = [%f %f;\n %f %f]', t, v(1,1), v(1,2), v(2,1), v(2,2)));
    i = i+1;
end

% 3 A couple of images
function s3b()
set(figure(1),'Name', '3 A couple of images');
subplot(1,1,1); % Clear

pics = zeros(128, 128, 3);
pics(:,:,1) = phonecalc128();
pics(:,:,2) = few128();
pics(:,:,3) = nallo128();

i=1;
for k = 1:3
    pic = pics(:,:,k);
    for t=[1 4 16 64 256]
        subplot(3,5,i);
        psf = gaussffta(pic, t);
        showgray(psf);
        title(sprintf('gaussffta t = %d', t));
        i = i+1;
    end
end

% 4 Smoothing
function s4()
set(figure(1),'Name', '4 Smoothing');
subplot(1,1,1); % Clear
office = office256;
add = gaussnoise(office, 16);
sap = sapnoise(office, 0.1, 255);

g = 3;
m = 3;
i = 0.15;
subplot(2,4,1); showgray(add); title('add');
subplot(2,4,2); showgray(gaussffta(add, g)); title(sprintf('gaussffta(add, %d)',g));
subplot(2,4,3); showgray(medfilt(add, m)); title(sprintf('medfilt(add, %d)',m));
subplot(2,4,4); showgray(ideal(add, i)); title(sprintf('ideal(add, %g)',i));

subplot(2,4,5); showgray(sap); title('sap');
subplot(2,4,6); showgray(gaussffta(sap, g)); title(sprintf('gaussffta(sap, %d)',g));
subplot(2,4,7); showgray(medfilt(sap, m)); title(sprintf('medfilt(sap, %d)',m));
subplot(2,4,8); showgray(ideal(sap, i)); title(sprintf('ideal(sap, %g)',i));

% 4 Ideal low-pass filter
function s4i()
set(figure(1),'Name', '4 Ideal low-pass filter');
subplot(1,1,1); % Clear
pic = deltafcn(256, 256);
pic1 = ideal(pic, 0.15);
pic1hat = fft2(pic1);
pic2 = ideal(pic, 0.1);
pic2hat = fft2(pic2);
pic3 = ideal(pic, 0.05);
pic3hat = fft2(pic3);

subplot(3,3,1); showgray(pic1); title('ideal 0.15');
subplot(3,3,2); showgray(pic2); title('ideal 0.1');
subplot(3,3,3); showgray(pic3); title('ideal 0.05');

subplot(3,3,4); showfs(pic1hat); title('fft2 of ideal 0.15');
subplot(3,3,5); showfs(pic2hat); title('fft2 of ideal 0.1');
subplot(3,3,6); showfs(pic3hat); title('fft2 of ideal 0.05');

subplot(3,3,7); plot(1:256, real(pic1(:,128))); title('cross section of fft2 of ideal 0.15');
subplot(3,3,8); plot(1:256, real(pic2(:,128))); title('cross section of fft2 of ideal 0.1');
subplot(3,3,9); plot(1:256, real(pic3(:,128))); title('cross section of fft2 of ideal 0.05');

% 5 Sharpening
function s5()
set(figure(1),'Name', '5 Sharpening');
subplot(1,1,1); % Clear

laplace = [0 1 0; 1 -4 1; 0 1 0];
laplaceblocks = conv2(blocks1, laplace, 'valid');
add = gaussnoise(blocks1, 16);
sap = sapnoise(blocks1, 0.1, 255);

subplot(2,2,1); showgray(blocks1, 64, 0, 256); title('blocks1');
subplot(2,2,2); showgray(laplaceblocks, 64, -256, 256); title('laplaceblocks');
subplot(2,2,3); showgray(conv2(add, laplace, 'valid'), 64, -256, 256); title('add');
subplot(2,2,4); showgray(conv2(sap, laplace, 'valid'), 64, -256, 256); title('sap');

pause

i = 1;
stripblocks = conv2(blocks1, [0 0 0; 0 1 0; 0 0 0], 'valid');
for k = [0.01 0.1 0.5 1 2 4 ]
    sharpblocks = stripblocks - k * laplaceblocks;
    subplot(2,3,i); showgray(sharpblocks, 64, 0, 256); title(sprintf('k = %g', k));
    i = i + 1;
end

pause

i = 1;
stripblocks = conv2(blocks1, [0 0 0; 0 1 0; 0 0 0], 'valid');
for k = [0.01 0.1 0.5 1 2 4]
    sharpblocks = stripblocks - k * laplaceblocks;
    subplot(2,3,i); plot(sharpblocks(128,:)); ylim([0 256]); title(sprintf('k = %g', k));
    i = i + 1;
end
