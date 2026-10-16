clc;
clear;
close all;

% Parametres reels
p = [0.2; 0.3; 0.2; 0.1; -0.1; 0.08; 0.1; 0.03; 0.025; 0.6];
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

% Construction de la jacobienne globale
N = size(theta_mes, 1);
Jglobale = zeros(3*N, 10);

for i = 1:N
    theta_i = theta_mes(i, :)';
    J_i = jacobien(theta_i, p);
    Jglobale(3*i-2:3*i, :) = J_i;
end

rang = rank(Jglobale)

disp('Dimension de la jacobienne globale :')
disp(size(Jglobale))

disp('Rang de la jacobienne globale :')
disp(rang)

v = [1; 0; 0; 0; 0; 0; 0; 0; 1; 0];
disp('Norme de Jglobale*v :')
disp(norm(Jglobale*v))

% Deuxieme direction non identifiable
v2 = [0; 0; 0; 0; 1; 0; 0; p(1)-p(9); p(8); 1];

disp('Norme de Jglobale*v2 :')
disp(norm(Jglobale*v2))