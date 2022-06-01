clear all; close all; clc;

% load Syn_shot1g % load the synthetic data
 A = double(imread('testimage3.gif'));
% A = double(A([200:500],[250:399]));
% A= imresize(A,0.25)
 imshow(A)
% A=Dg;
x = double(A(:));

[r col]=size(A);% get original data size 
%_____________________________________
%transform original 2D data to 1D
Dg_temp= A;
f=Dg_temp(:);
%______________________________________
n= length(x); % total number of samples
%_________________________________
%  Pre processing to get A 

temp=randperm(col);  % generate (Col) random numbers from 1 to (col)
% m=zeros(20,1);
j=0;
SNR_CS_nearest= zeros(1,20);
SNR_linear= zeros(1,20);
m = ceil(0.3*n); % NOTE: small error still present after increasing m to 1500;
Phi = randn(m,n);
%___THETA___
% NOTE: Avoid calculating Psi (nxn) directly to avoid memory issues.
Theta = zeros(m,n);
for ii = 1:n
    ii
    ek = zeros(1,n);
    ek(ii) = 1;
    psi = idct(ek)';
    Theta(:,ii) = Phi*psi;
end


 for i=1:0.2:5-0.2
    j=j+1
mm=ceil((i/10)*col);
% the percentage of available data
ind=temp(1:mm); % the indeces of available data
ind1=temp(mm+1:end); % the indeces of missed data
%_______________________________________
% calculations tao get the data indces in 1D
Dg_temp1=A;
Dg_temp1(Dg_temp1 == 0) = eps; % replace any zero by epsilon
% to check zeros use: sum(Dg_temp1 == 0, 'all') 
Dg_temp2= Dg_temp1;
 Dg_temp2(:,ind1)=0; % replace missing data with zeros
 Dg_temp2=Dg_temp2(:);% vectorize data
 Dg_temp2(1)=eps;
 Dg_temp2(n)=f(n);
 indx2= 1:n;
indx3= indx2(Dg_temp2 ~= 0); %the indces of available data >>> (b)
%--------------------------------------------
% calculate b
b=double( Dg_temp2(indx3,:));


estimated_signal= interp1(indx3,b,indx2,'linear')';
estimated_signal1= interp1(indx3,b,indx2,'linear')';


    %__ALTERNATIVES TO THE ABOVE MEASUREMENT MATRIX___ 
    %Phi = (sign(randn(m,n))+ones(m,n))/2; % micro mirror array (mma) e.g. single
    %pixel camera Phi = orth(Phi')'; % NOTE: See Candes & Romberg, l1
    %magic, Caltech, 2005.

%___COMPRESSION___
y = Phi*estimated_signal1;



%___l2 NORM SOLUTION___ s2 = Theta\y; %s2 = pinv(Theta)*y
s2 = pinv(Theta)*y;

%___BP SOLUTION___
s1 = l1eq_pd(s2,Theta,Theta',y,5e-3,20); % L1-magic toolbox
%x = l1eq_pd(y,A,A',b,5e-3,32);



%___IMAGE RECONSTRUCTIONS___
% x2 = zeros(n,1);
% for ii = 1:n
%     ii
%     ek = zeros(1,n);
%     ek(ii) = 1;
%     psi = idct(ek)';
%     x2 = x2+psi*s2(ii);
% end

x1 = zeros(n,1);
for ii = 1:n
    ii
    ek = zeros(1,n);
    ek(ii) = 1;
    psi = idct(ek)';
    x1 = x1+psi*s1(ii);
end


E1=x-estimated_signal;
E2= x-x1;
% ff=mean(f.^2);
% EE=mean(E.^2);
SNR_CS_nearest(j)=snr(x,E2);
SNR_linear(j)=snr(x,E1);

end
disp('sucssecful end of programm -_-')
it=10:2:50-2;
plot(it,SNR_linear,it,SNR_CS_nearest)
legend('linear','CS_linear')
grid minor
xlabel('Observed trace percentage')
ylabel('Signal-to-noise ratio (dB)')

 
