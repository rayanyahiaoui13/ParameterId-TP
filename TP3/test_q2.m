clc;
clear;
close all;

% Valeurs de test
theta = [0.2; -0.4; 0.6];

p = [0.2; 0.4; 0.3; 0.25; 0.05; -0.03; 0.02; 0.1; -0.05; 0.08];

% Petite variation des parametres
dp = 1e-6 * ones(10,1);

% Jacobienne analytique
J = jacobien(theta, p);

% Variation analytique
dX_analytique = J * dp;

% Variation numerique
X1 = modele_geom(theta, p);
X2 = modele_geom(theta, p + dp);

dX_numerique = X2 - X1;

disp('Variation analytique :')
disp(dX_analytique)

disp('Variation numerique :')
disp(dX_numerique)

disp('Difference :')
disp(dX_analytique - dX_numerique)