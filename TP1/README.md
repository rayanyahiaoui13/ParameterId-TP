# ParameterId-TP1
*Authors: Yves Harold VALCIUS & Rayan Yahaoui*

This repository contains the MATLAB implementation for the first practical session on linear parameter identification.
The core objective is to identify the unknown masses, spring stiffnesses, and damping coefficients of a linear mechanical system.
We first establish the theoretical linear-in-the-parameters model in the form $Ax=b$.
Using MATLAB, we simulate the system's response to a unit step force across 8 seconds of measurements.
We then apply the Least Squares estimation method to recover the parameters from the stacked positional, velocity, and acceleration data.
Subsequent scripts explore the impact of practical measurement constraints on our estimation accuracy.
Specifically, we analyze the effects of digital sensor quantization and zero-phase low-pass filtering on the regressor matrix conditioning.
All scripts clear the workspace automatically and output comparative identification errors to validate our models.  