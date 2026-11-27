clear;
close all;
clc;

load('releve_vit_cste_axe2.mat');

kc2=0.0525; 
N2=4.5;
P=100*eye(4);
Q=0.0000001*eye(4);
theta=zeros(4,1);
N=length(q2);
Ak = [cos(q2(:)), sign(qpfil2(:)), qpfil2(:), ones(N,1)];
y = kc2*N2*ifil2(:);
R=100;

T=Ak\y;

disp('Parametres LS hors ligne :');
disp(T);

erreur_pre = zeros(N,1);
erreur_post = zeros(N,1);
theta_est = zeros(4,N);


for k = 1:N

    ak = Ak(k,:);
    yk = y(k);

    Pk=P+Q;
    erreur_pre(k) = yk - ak*theta;

    Sk=ak*Pk*ak' + R;

    RLSK = Pk*ak'/ Sk ;

    theta = theta + RLSK*erreur_pre(k);

    P = (eye(4) - RLSK*ak)*Pk;

    erreur_post(k) = yk - ak*theta;

    theta_est(:,k) = theta;

end

figure;

noms = {'alpha_2', 'a_2', 'b_2', 'c_2'};

for j = 1:4
    subplot(2,2,j);
    plot(theta_est(j,:), 'b');
    hold on;
    yline(T(j), '--r');
    grid on;
    title(noms{j});
    xlabel('Echantillon k');
    ylabel('Valeur estimee');
    legend('kalman', 'Moindres carres hors ligne');
end

sgtitle('Evolution des parametres estimes par kalman');

% Graphique 2 : erreurs de prediction
figure;
plot(erreur_pre, 'Color', [0.7 0.7 0.7]);
hold on;
plot(erreur_post, 'b');
grid on;
xlabel('Echantillon k');
ylabel('Erreur (N.m)');
legend('Avant correction', 'Apres correction');
title('Erreurs de prediction du kalman');

% Comparaison finale
disp('Parametres finaux kalman:');
disp(theta);

disp('Parametres LS hors ligne :');
disp(T);