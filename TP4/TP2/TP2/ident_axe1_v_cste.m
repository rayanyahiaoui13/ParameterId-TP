%% CE PROGRAMME PERMET D'IDENTIFIER LES PARAMETRES DU MODELE
%% DE L'AXE 2 POUR DES MOUVEMENTS A VITESSE CONSTANTE
%% G. MOREL - 29-12-05.
%% M. Khoramshahi 02-02-2023

close all
clc
clear all; %% efface toutes les variables existantes


load releve_vit_cste_axe1

%% Parametres connus
kc1 = 0.0525;      % Constante de couple axe 1 (N.m/A)
N1  = 20.25;


%% Construction de la matrice Y.
Y = zeros(33208,4);
u = zeros(33208,1);

for i=1:29344
    Y(i,:) = [cos(q1(i)) sign(qpfil1(i)) qpfil1(i) 1];
    u(i) = kc1*N1*ifil1(i);
end
%% Calcul des paramètres
p=pinv(Y)*u;

%% Affichage des résultats.
format long
disp('Paramètres estimés à partir des données brutes :');
p'

figure(1)
clf; %% clear figure
h=plot3(q1,qpfil1,kc1*N1*ifil1,'x');
set(h,'LineWidth',0.5);
hold on; %% permet de conserver le graphique et d'en ajouter d'autres sur la même fig.
h=plot3(q1,qpfil1,Y*p,'.');
set(h,'LineWidth',1.5);
title('Résultats de l''identification avec filtrage');
legend('\Gamma_2 non filtré', 'modèle');
grid on;
xlabel('$q_2$','Interpreter','latex')
ylabel('$\dot{q}_2$','Interpreter','latex')
zlabel('$\tau$','Interpreter','latex')


%% Extra plots to check the quality of the identification

figure;
qqplot(Y*p-u)
grid on
axis equal
axis square

figure;
plot(u,Y*p,'.')
hold on
plot([min(u) max(u)],[min(u) max(u)],'--g','LineWidth',2)
grid on
xlabel('$y$','Interpreter','latex','FontSize',16)
ylabel('$\hat{y}$','Interpreter','latex','FontSize',16)
xlim([-0.25 0.25])
ylim([-0.25 0.25])
axis equal
axis square