clc;
clear;
close all;

% Parametres reels
p_reel = [0.2; 0.4; 0.3; 0.25; 0.05; -0.03; 0.02; 0.1; -0.05; 0.08];

% Parametres du test
N = 30;
sigma = 0.002;
n_iter = 30;

p_init = [0.2; 0.6; 0.2; 0.35; -0.1; 0.1; -0.05; 0.3; 0.2; -0.1];

% Test 1 : un seul angle variable
theta_parfait = zeros(N,3);
theta_parfait(:,1) = rand(N,1)*2 - 1;

[erreur_1, rang_1] = tester_configuration( ...
    theta_parfait, p_reel, sigma, p_init, n_iter);

% Test 2 : deux angles variables
theta_parfait = zeros(N,3);
theta_parfait(:,1) = rand(N,1)*2 - 1;
theta_parfait(:,2) = rand(N,1)*2 - 1;

[erreur_2, rang_2] = tester_configuration( ...
    theta_parfait, p_reel, sigma, p_init, n_iter);

% Test 3 : trois angles variables
theta_parfait = rand(N,3)*2 - 1;

[erreur_3, rang_3] = tester_configuration( ...
    theta_parfait, p_reel, sigma, p_init, n_iter);

disp('Test du choix des mesures :')

disp('Un seul angle variable :')
fprintf('Rang de la jacobienne : %d\n', rang_1)
fprintf('Erreur sur les parametres : %.6e\n\n', erreur_1)

disp('Deux angles variables :')
fprintf('Rang de la jacobienne : %d\n', rang_2)
fprintf('Erreur sur les parametres : %.6e\n\n', erreur_2)

disp('Trois angles variables :')
fprintf('Rang de la jacobienne : %d\n', rang_3)
fprintf('Erreur sur les parametres : %.6e\n\n', erreur_3)