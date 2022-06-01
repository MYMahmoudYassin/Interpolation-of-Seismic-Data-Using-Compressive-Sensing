clear all; close all; clc;
n=5000;% samples number
% fs = 96000;
t=linspace(0,1/8,n);% from 0 to 1/8 sec get n samples
f=sin(1394*pi*t)+sin(3266*pi*t); % my signal
plot(t, f, 'Linewidth', [2]);
ft=dct(f); %discerte cosine transform
figure(2);
plot(ft, 'Linewidth', [2])

% sound(t,fs)
m=floor(0.1*n);%number of samples from original data
temp=randperm(n);
ind=temp(1:m);
tr=t(ind);% samples of time
b=sin(1394*pi*tr)+sin(3266*pi*tr);% b  is the sampled data
figure(1)
hold on, plot(tr, b,'ro', 'linewidth', [2])

PSI=dct(eye(n,n)); %the transformation matrix (psi)
A=PSI(ind,:); %Calculate A= phi * psi. 
%-----------------------------------------------------
%Solve for s in  A*C = b (using  L1 norm). 

  cvx_begin
     variable x(n)
      minimize(norm(x,1));
      subject to 
         A*x==b.';
         cvx_end
 %----------------------------------------------------
 C =x;
sig1=idct(C)'; % Recover the original signal (f) using f= psi * C.  
 
 figure(3)
plot(ft,'b'), hold on , plot(C,'r');

figure(4)
plot(t,f,t,sig1);
E=f-sig1;
snr(f,E)
mean(E)
