%___INPUT Seismic shot___
% compressed sensing interpolation for Seismic data
%
%___DESCRIPTION___
% MATLAB implementation of compressive sensing interpolation inspired by described in R.
% Baraniuk, Compressive Sensing, IEEE Signal Processing Magazine, [118],
% July 2007. The code acquires m averaged random measurements of a 501*60
% Seismic shot. We assume that the Seismic shot has a sparse representation in the
% DCT domain (not very sparse in practice). Hence the Seismic shot can be
% recovered from its compressed form using basis pursuit.
%
%___DEPENDENCIES___
% Requires the MATLAB toolbox l_1-MAGIC: Recovery of Sparse Signals via Convex
% Programming v1.11 by J. Candes and J. Romberg, Caltech, 2005. 
%
%___VARIABLES___
% x = original signal (nx1) y = compressed signal (mx1) Phi = measurement
% matrix (mxn) Psi = Basis functions (nxn) Theta = Phi * Psi (mxn) s =
% sparse coefficient vector (to be determined) (nx1)
%
%___PROBLEM___
% Invert the matrix equation y = Theta * s and therefore recover hat_x as
% k-sparse linear combination of basis functions contained in Psi. Note
% also that y = Phi * x.
%
%___SOLUTION___
% Let Phi be a matrix of i.i.d. Gaussian variables. Solve matrix inversion
% problem using basis pursuit (BP).

%___CREATED___
% o Original code created by By S.Gibson, School of Physical Sciences, University of Kent. 
% o 1st May, 2013.
% o version 1.0
% o Modified Verision for Seismic data interpolation created by  
% o M.Yassin & M. Hafez, EE Department, KFUPM, KSA
% o 18/3/2022 verion 1.0
% o NOTES: If the max number of iterations exceeds 25, error sometimes
%   occurs in l1eq_pd function call.
%
%___DISCLAIMER___
% The code below is my interpretation of Baraniuk's compressed sensing
% article. I don't claim to be an authority on the subject!


%___INPUT IMAGE___
clear, close all, clc
load Syn_shot1g
A = Dg;
x = double(A(:));
n = length(x);

%___MEASUREMENT MATRIX___
m = 0.2*n; % NOTE: small error still present after increasing m to 1500;
Phi = randn(m,n);
    %__ALTERNATIVES TO THE ABOVE MEASUREMENT MATRIX___ 
    %Phi = (sign(randn(m,n))+ones(m,n))/2; % micro mirror array (mma) e.g. single
    %pixel camera Phi = orth(Phi')'; % NOTE: See Candes & Romberg, l1
    %magic, Caltech, 2005.

%___COMPRESSION___
y = Phi*x;

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

%___l2 NORM SOLUTION___ s2 = Theta\y; %s2 = pinv(Theta)*y
s2 = pinv(Theta)*y;

%___BP SOLUTION___
s1 = l1eq_pd(s2,Theta,Theta',y,5e-3,20); % L1-magic toolbox
%x = l1eq_pd(y,A,A',b,5e-3,32);

%___DISPLAY SOLUTIONS___
plot(s2,'b'), hold
plot(s1,'r.-')
legend('least squares','basis pursuit')
title('solution to y = \Theta s')

%___IMAGE RECONSTRUCTIONS___
x2 = zeros(n,1);
for ii = 1:n
    ii
    ek = zeros(1,n);
    ek(ii) = 1;
    psi = idct(ek)';
    x2 = x2+psi*s2(ii);
end

x1 = zeros(n,1);
for ii = 1:n
    ii
    ek = zeros(1,n);
    ek(ii) = 1;
    psi = idct(ek)';
    x1 = x1+psi*s1(ii);
end
figure(1)
imagesc(offset(1:60),t,Dg),colormap(sgray),colorbar
xlabel('Offset(m)','FontName','times','FontSize',14)
set(gca,'xaxislocation','top')
ylabel('Time(s)','FontName','times','FontSize',14)

figure(2)
imagesc(offset(1:60),t,reshape(x1,501,60)),colormap(sgray),colorbar
xlabel('Offset(m)','FontName','times','FontSize',14)
set(gca,'xaxislocation','top')
ylabel('Time(s)','FontName','times','FontSize',14)
figure(3)
imagesc(offset(1:60),t,reshape(x2,501,60)),colormap(sgray),colorbar
xlabel('Offset(m)','FontName','times','FontSize',14)
set(gca,'xaxislocation','top')
ylabel('Time(s)','FontName','times','FontSize',14)
 E= x-x1;
SNR_CS=snr(x,E);

