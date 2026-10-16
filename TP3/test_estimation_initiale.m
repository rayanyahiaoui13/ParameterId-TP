clc;
clear;
close all;

% Parametres reels
p_reel = [0.2; 0.3; 0.2; 0.1; -0.1; 0.08; 0.1; 0.03; 0.025; 0.6];
% Generation des mesures bruitees
N = 30;
sigma = 0.002;
n_iter = 50;

rng(1);
theta_parfait = rand(N,3)*2 - 1;

X_parfait = zeros(N,3);
for i = 1:N
    X_parfait(i,:) = modele_geom(theta_parfait(i,:)', p_reel)';
end

theta_mes = theta_parfait + sigma*randn(N,3);
X_mes = X_parfait + sigma*randn(N,3);

% Test de plusieurs estimations initiales
n_essais = 10;
erreur_init = zeros(n_essais,1);
p_estimees = zeros(n_essais,10);

for k = 1:n_essais

    p_init = rand(10,1)*2 - 1;

    % On impose l0 = 0.2
    p_init(1) = 0.2;
    p_init(5) = -0.1;

    p_bruit = identification(theta_mes, X_mes, p_init, n_iter);

    p_estimees(k,:) = p_bruit';
    erreur_init(k) = norm(p_bruit - p_reel);

    fprintf('Essai %2d : erreur = %.6e\n', k, erreur_init(k));
end

disp('Erreurs selon l''estimation initiale :')
disp(erreur_init')

disp('Meilleure estimation initiale :')
[erreur_min, indice] = min(erreur_init);
disp(indice)

disp('Parametres identifies pour le meilleur essai :')
disp(p_estimees(indice,:))