clc;
clear;
close all;

p_reel = [0.2; 0.3; 0.2; 0.1; -0.1; 0.08; 0.1; 0.03; 0.025; 0.6];

% Dix configurations articulaires
theta_mes = [
    0.1  0.2  -0.3;
   -0.4  0.5   0.2;
    0.3 -0.2   0.4;
   -0.1  0.3  -0.5;
    0.6  0.1   0.2;
   -0.5 -0.4   0.3;
    0.2  0.6  -0.1;
    0.4 -0.6   0.5;
   -0.3  0.2   0.6;
    0.5  0.4  -0.4 ];

% Generation des mesures parfaites
N = size(theta_mes, 1);
X_mes = zeros(N, 3);

for i = 1:N
    theta_i = theta_mes(i, :)';
    X_mes(i, :) = modele_geom(theta_i, p_reel)';
end

% Estimation initiale
p_init = [0.2; 0.6; 0.2; 0.35; -0.1; 0.1; -0.05; 0.3; 0.2; -0.1];


% Identification
n_iter = 8;
[p_identifie, err_hist] = identification(theta_mes, X_mes, p_init, n_iter);

disp('Parametres reels :')
disp(p_reel')

disp('Estimation initiale :')
disp(p_init')

disp('Parametres identifies :')
disp(p_identifie')

disp('Erreur finale :')
disp((p_identifie - p_reel)')

disp('Historique du critere d''erreur :')
disp(err_hist')