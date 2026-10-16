clc;
clear;
close all;

% Parametres simples pour validation
theta = [0; 0; 0];

p = [0.2; 0.3; 0.3; 0.2; 0; 0; 0; 0; 0; 0];

X = modele_geom(theta, p)

% Test avec un offset articulaire
theta = [0; 0; 0];

p = [0; 1; 1; 1; pi/2; 0; 0; 0; 0; 0];

X = modele_geom(theta, p)