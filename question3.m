clear; close all; clc 

definit_parametres;

k1=5000;
b1=400;

simule_systeme;

alpha=0.00001*round(alpha*100000);
beta=0.00001*round(beta*100000);
gamma=0.00001*round(gamma*100000);

vit_alpha=0.0001*round(vit_alpha*10000);
vit_beta=0.0001*round(vit_beta*10000);
vit_gamma=0.0001*round(vit_gamma*10000);

acc_alpha=0.001*round(acc_alpha*1000);
acc_beta=0.001*round(acc_beta*1000);
acc_gamma=0.001*round(acc_gamma*1000);

mesures= 1:length(t);  

identifie_parametres; 


x_reel = [k0;k1;k2;b0;b1;b2;m1;m2;m3];

err_rel = abs(x_reel - x_hat)./x_reel*100;

disp('valeur réelles')
disp(x_reel);

disp('valeurs estimées');
disp(x_hat);

disp("erreur relative");
disp(err_rel)