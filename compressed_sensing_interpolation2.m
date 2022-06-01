clear all; close all; clc;
% f = psi* C
% b= phi* f
% b= A*C
% Steps: 
% 1- Determine the sampling matrix (phi) (Gaussian random matrix for example).
% 2- Determine the transformation matrix (psi) (Fourier, Curvelet, ...). 
% 3- Calculate A= phi * psi. 
% 4- Solve for s in  A*C = b (using L0 or L1 or L2 norm). 
% 5- Recover the original signal (f) using f= psi * C.  
%---------------------------------------------------

load Syn_shot1g % load the synthetic data
 AA= double(imread('reag_image.gif'));
% AA=imresize(B,[50 50]);

[r col]=size(AA);% get original data size 
%_____________________________________
%transform original 2D data to 1D
Dg_temp= AA;
f=Dg_temp(:);
%______________________________________
n= length(f); % total number of samples
%_________________________________
%  Pre processing to get A 

temp=randperm(col);  % generate (Col) random numbers from 1 to (col)
% m=zeros(20,1);
ii=0;
SNR_CS = zeros(1,20);
SNR_linear = zeros(1,20);

for i=1:0.2:3-0.2
    ii=ii+1
mm=ceil((i/10)*col);
ind=temp(1:mm); % the indeces of available data
ind1=temp(mm+1:end); % the indeces of missed data
%_______________________________________
% calculations tao get the data indces in 1D
Dg_temp1=f;
Dg_temp1(Dg_temp1 == 0) = eps; % replace any zero by epsilon
% to check zeros use: sum(Dg_temp1 == 0, 'all') 
Dg_temp2= Dg_temp1;
 Dg_temp2(:,ind1)=0; % replace missing data with zeros
 Dg_temp2=Dg_temp2(:);% vectorize data
 Dg_temp2(1)=eps;
 Dg_temp2(n)=f(n);
 indx2= 1:n;
indx3= indx2(Dg_temp2 ~= 0); %the indces of available data >>> (b)
b=double( Dg_temp2(indx3,:));

% the percentage of available data
% ft=dct(f); % dct for the original data
% figure(1)
% hold on, plot(f,'linewidth', [2]), plot(b,'ro', 'linewidth', [2])
%-------------------------------------------
disp('begin with Theta calculations')
PSI=idct(eye(n,n)); % calculate the trasformation matrix
A=PSI(indx3,:);% calculation of A
% phi=A*inv(PSI);
estimated_signal= interp1(indx3,b,indx2,'linear')';

%------------------------------------------------
% solve using L1 norm

  %___l2 NORM SOLUTION___ s2 = Theta\y; %s2 = pinv(Theta)*y
disp('begin with s2 calculations')

  s2 = pinv(A)*b;

%___BP SOLUTION___
disp('begin with s1 calculations')

s1 = l1eq_pd(s2,A,A',b,5e-3,5); % L1-magic toolbox

%---------------------------------------------------         
sig1=PSI*s1; % Recover the original signal (f) using f= psi * C.  
 E= f-sig1;
 E1= f-estimated_signal;

SNR_CS(ii)=snr(f,E);
 SNR_linear(ii)=snr(f,E1);

% figure(2)
% imagesc(offset(1:60),t,reshape(sig1,501,60)),colormap(sgray),colorbar
% xlabel('Offset(m)','FontName','times','FontSize',14)
% set(gca,'xaxislocation','top')
% ylabel('Time(s)','FontName','times','FontSize',14)
% figure(1)
% imagesc(offset(1:60),t,Dg),colormap(sgray),colorbar
% xlabel('Offset(m)','FontName','times','FontSize',14)
% set(gca,'xaxislocation','top')
% ylabel('Time(s)','FontName','times','FontSize',14)
end

disp('sucssecful end of programm -_-')

it=10:2:30-2;
figure(1)
plot(it,SNR_linear,it,SNR_CS)
legend('linear','CS')
grid minor
xlabel('Observed trace percentage %')
ylabel('Signal-to-noise ratio (dB)')


% At=dct2(Dg);
% F = log(abs(fftshift(At))+1); % put FFT on log-scale
% imshow(mat2gray(At),[]);
% AF=abs(fftshift(At));
% imagesc(offset,t,At),colormap(sgray),colorbar
% xlabel('Offset(m)','FontName','times','FontSize',14)
% set(gca,'xaxislocation','top')
% ylabel('Time(s)','FontName','times','FontSize',14)
figure(2)
subplot 131
imshow(uint8(AA))
title('original image')

sig11=uint8(sig1);
subplot 132
imshow(reshape(sig11,50,50))
title('interpolated image using CS(80% available traces)')

subplot 133

estimated_signal1=uint8(estimated_signal);
imshow(reshape(estimated_signal1,50,50))
title('interpolated image using linear(80% available traces)')


