clc;
clear;
close all;

% Parametres reels
p_reel = [0.2; 0.3; 0.2; 0.1; -0.1; 0.08; 0.1; 0.03; 0.025; 0.6];

% Estimation initiale
p_init = [0.2; 0.6; 0.2; 0.35; -0.1; 0.1; -0.05; 0.3; 0.2; -0.1];

% nombre de mesures
N_valeurs = [5 10 20 50 100];
erreur_N = zeros(size(N_valeurs));

for k = 1:length(N_valeurs)

    N = N_valeurs(k);

    theta_parfait = rand(N,3)*2 - 1;

    X_parfait = zeros(N,3);
    for i = 1:N
        X_parfait(i,:) = modele_geom(theta_parfait(i,:)', p_reel)';
    end

    theta_mes = theta_parfait + 0.002*randn(N,3);
    X_mes = X_parfait + 0.002*randn(N,3);

    p_bruit = identification(theta_mes, X_mes, p_init, 30);

    erreur_N(k) = norm(p_bruit - p_reel);
end

disp('Nombre de mesures :')
disp(N_valeurs)

disp('Erreur finale sur les parametres :')
disp(erreur_N')