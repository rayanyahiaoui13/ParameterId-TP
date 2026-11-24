**TP2 ID Parameter**

This repository contains the MATLAB implementation for the dynamic parameter identification of a 2-axis planar manipulator robot.
Using the Newton-Euler formalism, the robot's dynamic equations are modeled with an absolute parameterization that simplifies coupling and inertia terms.
We first isolate friction and gravity effects on each axis using constant-velocity trajectories where acceleration terms vanish.
These identified dry friction, viscous friction, and gravity parameters are then subtracted from the total torque measured during dynamic multi-axis motions.
Finally, linear Least Squares estimation is applied to the filtered kinematic and electrical current signals to identify the remaining inertial parameters.
The identified dynamic model is verified by comparing the reconstructed torques against the experimental actuator measurements over time.