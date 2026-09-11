clear; close all; clc 

definit_parametres;
simule_systeme;

alpha=0.00001*round*(alpha*100000)


mesures= 50:10:800; 

identifie_parametres; 


x_reel = [k0;k1;k2;b0;b1;b2;m1;m2;m3];

err_rel = abs(x_reel - x_hat)./x_reel*100;

disp('valeur réelles')
disp(x_reel);

disp('valeurs estimées');
disp(x_hat);

disp("erreur relative");
disp(err_rel)