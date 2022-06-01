# Interpolation of Seismic Data Using Compressive Sensing
Interpolation of Seismic data traces is a very important topic for the oil and gas industry. One of the interpolation methods is using Compressive Sensing. We managed to apply the theory on a sinusoidal signal perfectly. Then we applied CS to interpolate seismic data, but unfortunately the results were bad compared to basic interpolation methods like linear interpolation. The main obstacle that we faced is finding a sparse transform for seismic data and applying compressive sensing using that transform. We found in the literature that seismic images are sparse in the curvelet transform. However, we could not construct the transform basis 𝜓 and therefore failed in applying compressive sensing on seismic data.

**The organization of the codes as follow:**

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
