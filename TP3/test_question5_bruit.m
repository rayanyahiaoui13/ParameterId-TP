clc;
clear;
close all;

% Parametres reels
p_reel = [0.2; 0.3; 0.2; 0.1; -0.1; 0.08; 0.1; 0.03; 0.025; 0.6];
% Nombre de mesures
N = 20;

% Generation des configurations articulaires
rng(1);
theta_parfait = rand(N,3)*2 - 1;

% Generation des mesures parfaites
X_parfait = zeros(N,3);

for i = 1:N
    X_parfait(i,:) = modele_geom(theta_parfait(i,:)', p_reel)';
end

% Ajout de bruit
sigma_q = 0.002;
sigma_X = 0.002;

bruit_q = sigma_q*randn(N,3);
bruit_X = sigma_X*randn(N,3);

theta_mes = theta_parfait + bruit_q;
X_mes = X_parfait + bruit_X;

p_init = [0.2; 0.6; 0.2; 0.35; -0.1; 0.1; -0.05; 0.3; 0.2; -0.1];

% Identification avec bruit
n_iter = 30;
[p_bruit, err_hist] = identification(theta_mes, X_mes, p_init, n_iter);

disp('Parametres reels :')
disp(p_reel')

disp('Parametres identifies avec bruit :')
disp(p_bruit')

disp('Erreur sur les parametres :')
disp((p_bruit - p_reel)')

disp('Historique du critere d''erreur :')
disp(err_hist')