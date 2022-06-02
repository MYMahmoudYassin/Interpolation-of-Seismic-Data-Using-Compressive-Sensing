# Interpolation of Seismic Data Using Compressive Sensing
Interpolation of Seismic data traces is a very important topic for the oil and gas industry. One of the interpolation methods is using Compressive Sensing. We managed to apply the theory on a sinusoidal signal perfectly. Then we applied CS to interpolate seismic data, but unfortunately the results were bad compared to basic interpolation methods like linear interpolation. The main obstacle that we faced is finding a sparse transform for seismic data and applying compressive sensing using that transform. We found in the literature that seismic images are sparse in the curvelet transform. However, we could not construct the transform basis 𝜓 and therefore failed in applying compressive sensing on seismic data.<br />
This project was a part of class EE562 – DIGITAL SIGNAL PROSSING I -KFUPM-spring 2022
- Project members:
Mahmoud Yassin Mahmoud and [Mohamed Hafez Mohamed](https://github.com/mohamad1998630)
- Submitted to:
Prof. Wail Mousa<br />
-----------------------------------------------------![vibrator](https://user-images.githubusercontent.com/106708838/171564575-b650cfc6-a26e-40cf-9159-7325b872e80f.gif)

![image](https://user-images.githubusercontent.com/106708838/171564105-227bb6fb-c60c-4c97-8ac1-70209002af2a.png)


## The organization of the codes as follow:

1. compressiveSensingTest<br />
(implementation of compressive sensing theory on sinusoid signal)(use CVX for optimization)<br />
2. compressed_sensing_example_interpo1<br />
compressed sensing interpolation for Seismic data<br />
(missing data is random values not traces)
(We assume that the Seismic shot has a sparse representation in the<br />
DCT domain (not very sparse in practice -_-))
3. compressed_sensing_interpolation2<br />
(final version that perform interpolation using Copressive sensing and linear interpolation and <br />
comparing between them in terms of SNR)
4. LinearVsLinearCV<br />
( perform linear interpolation and new version which is linear interpolation and compressive sensing and comparing the results)<br />
 



![reag_image](https://user-images.githubusercontent.com/106708838/171561480-48a628d1-88d0-4cd4-9ae1-bfda4db68001.jpg)


##  Some Successful Results:
**Firstly**, to prove the concept of compressive sensing, we started by a
simple example of a sinusoidal signal.
Let
𝑓𝑎(𝑡) = sin(1394𝜋𝑡) + sin (3266𝜋𝑡)
If we sample 𝑓𝑎 at 40 kHz for 1/8
seconds, we get a vector 𝑓 that has
5000 samples. Taking 500 random
samples of 𝑓, we get 𝑏 as illustrated
below. Note the sparsity of 𝑥 in the
DCT domain.

![1](https://user-images.githubusercontent.com/106708838/171563131-fe510b82-11e2-4da0-b5cd-80bee2e47b71.gif) 
![2](https://user-images.githubusercontent.com/106708838/171563413-2d8d3930-9b10-44a2-841f-2016f7488be2.gif)

**Secondly**, We developed an interporaltion  algorithm based on the CS where we designed a measurament matrix that satisfies the problem requirments and tested with an image with the dimensions 50*50. 

![image](https://user-images.githubusercontent.com/106708838/171563674-717274e7-c773-4611-b5eb-1ea1ea92a074.png)
![image](https://user-images.githubusercontent.com/106708838/171563857-c37ee80a-f421-469b-b807-982ad15c00a3.png)














<!-- 
okoko <br />
;lk o

**000000**

1. pop
2. lolol
3. ;p;p;

- pop
- lolol
- ;p;0p;



-->
