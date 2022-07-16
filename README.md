# ASPT-assignments
This repository contains my solutions for the programming assignments of the "Advanced Signal Processing 
Techniques" course. The assignments consist of 4 different exercises aimed at familiarizing students
with concepts such as:
1) the role of higher order spectra (eg bispectrum, trispectrum) in detecting
   non-linear phenomena like quadratic phase coupling.

2) using higher order cumulants to estimate the coefficients of an MA-system.  
 
3) the use of cepstrum and quefrency-domain tools in human speech analysis.

The programming tasks were solved using Octave, a high-level programming language intended for scientific
computing which is for the most part compatible with MATLAB. In order to calculate certain quantities such 
as the Bispectrum and Higher Order Cumulants,a custom version of the "Higher-Order Spectral Analysis Toolbox"
(HOSA Toolbox) was used. Installation of this Toolbox is not required in order to run the scripts, because 
all the necessary utility files are included in this repository and they have been modified to be compatible
with Octave instead of MATLAB.

The repository is organised in 4 folders. Every folder contains Octave scripts, input files as well as a
report which presents my findings for every assignment. The reports are written in Greek, but they will 
probably be translated in English at some point in the near future. That being said, this repository will 
not be maintained and it won't receive any further updates. Therefore, I cannot guarantee that those scripts
will remain compatible with future versions of Octave. At the time of writing this, the latest stable 
release of Octave is 7.1.0. Make sure that to use the same version or at least one that is backwards
compatible with 7.1.0
