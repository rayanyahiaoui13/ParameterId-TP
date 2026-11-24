clear all;
load releve_mvts_combines;

%% constantes connues
kc1=0.0525;
N1=20.25;
kc2=0.0525;
N2=4.5;

%% Paramètres identifiés à vitesse constante (parties 1 et 2 du TP)
%% Pour l'axe 1 :
alpha1 = 0.875500354165729;
a1     = 0.178629934156217;
b1     = 0.002455649251838;
c1     = -0.033419239847275;
%% Pour l'axe 2 :
alpha2 = 0.082896732238708;
a2     = 0.058158202699900;
b2     = 0.001935495788991;
c2     = -0.012299158456500;

%% identification à partir des données filtrées
for i=1:length(t)
    dq = q2(i)-q1(i);
    Z(2*i-1:2*i,1:3)=[qppfil1(i)             qppfil2(i)*cos(dq)-qpfil2(i)^2*sin(dq)   0
                       0                     qppfil1(i)*cos(dq)+qpfil1(i)^2*sin(dq)   qppfil2(i)];
    u(2*i-1,1) = N1*kc1*ifil1(i) - alpha1*cos(q1(i)) - (a1*sign(qpfil1(i))+b1*qpfil1(i)+c1);
    u(2*i,1)   = N2*kc2*ifil2(i) - alpha2*cos(q2(i)) - (a2*sign(qpfil2(i))+b2*qpfil2(i)+c2);
end

p = pinv(Z)*u;
format long
disp('Paramètres estimés à partir des données filtrées :');
p'

% reconstruction du modele complet
p1=p(1);   % I1' + m2*l1^2 + Ia1
p2=p(2);   % h = m2*l1*lambda2
p3=p(3);   % I2' + Ia2

for i=1:length(t)
    dq = q2(i)-q1(i);
    %% couple d'inertie
    ciner(2*i-1,1)= p1*qppfil1(i) + p2*cos(dq)*qppfil2(i);  %% AXE 1
    ciner(2*i,1)  = p2*cos(dq)*qppfil1(i) + p3*qppfil2(i);  %% AXE 2
    %% couple centrifuge
    ccentri(2*i-1,1)= -p2*sin(dq)*qpfil2(i)^2;               %% AXE 1
    ccentri(2*i,1)  =  p2*sin(dq)*qpfil1(i)^2;                %% AXE 2
    %% couple de gravité
    cgravi(2*i-1,1) = alpha1*cos(q1(i));                      %% AXE 1
    cgravi(2*i,1)   = alpha2*cos(q2(i));                      %% AXE 2
    %% couple de frottements
    cfrott(2*i-1,1) = a1*sign(qpfil1(i))+b1*qpfil1(i)+c1;     %% AXE 1
    cfrott(2*i,1)   = a2*sign(qpfil2(i))+b2*qpfil2(i)+c2;     %% AXE 2
    %% couple total
    ctotal(2*i-1:2*i,1)=ciner(2*i-1:2*i,1)+ccentri(2*i-1:2*i,1)+cgravi(2*i-1:2*i,1)+cfrott(2*i-1:2*i,1);
end

%% Affichage des commandes.
figure(1) %% pour l'axe 1
clf
hold on
grid on
h=plot(t,N1*kc1*i1,'y');
h=plot(t,N1*kc1*ifil1,'b');
set(h,'LineWidth',1.5);
h=plot(t,ciner(1:2:length(ctotal)),'r');
set(h,'LineWidth',1.5);
h=plot(t,cgravi(1:2:length(ctotal)),'m');
set(h,'LineWidth',1.5);
h=plot(t,ccentri(1:2:length(ctotal)),'k');
set(h,'LineWidth',1.);
h=plot(t,cfrott(1:2:length(ctotal)),'g');
set(h,'LineWidth',1.);
h=plot(t,ctotal(1:2:length(ctotal)),'c--');
set(h,'LineWidth',1.5);
legend('\Gamma_1 mesuré','\Gamma_1 filtré','inertie','gravité','centrifuge','frottements','modèle total');
title('Résultats axe 1 ; identification à partir de données filtrées');
figure(2)
clf
hold on
grid on
h=plot(t,N2*kc2*i2,'y');
h=plot(t,N2*kc2*ifil2,'b');
set(h,'LineWidth',1.5);
h=plot(t,ciner(2:2:length(ctotal)),'r');
set(h,'LineWidth',1.5);
h=plot(t,cgravi(2:2:length(ctotal)),'m');
set(h,'LineWidth',1.5);
h=plot(t,ccentri(2:2:length(ctotal)),'k--');
set(h,'LineWidth',1);
h=plot(t,cfrott(2:2:length(ctotal)),'g');
set(h,'LineWidth',1);
h=plot(t,ctotal(2:2:length(ctotal)),'c--');
set(h,'LineWidth',1.5);
legend('\Gamma_2 mesuré','\Gamma_2 filtré','inertie','gravité','centrifuge','frottements','modèle total');
title('Résultats axe 2 ; identification à partir de données filtrées');