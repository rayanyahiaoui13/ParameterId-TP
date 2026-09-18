%definit_parametres

t = (0:0.01:8)';
f = ones(length(t), 1);

s = tf('s');

F1=m1*s^2 + (b1+b0)*s + k1 + k0;
F2=-(b1*s+k1);
F3=F2;
F4=m2*s^2 + (b1+b2)*s + k1 + k2;
F5=b2*s+k2;
F6=F5;
F7=m3*s^2 + b2*s + k2;

G1 = 1/(F1- (F2*F3/(F4-(F5*F6/F7))));
G2 = G1*-F3/(F4-(F5*F6/F7));
G3 = F6/F7*G2;

alpha = step(G1, t);
vit_alpha = step(G1*s, t);
acc_alpha = step(G1*s^2, t);

beta = step(G2, t);
vit_beta = step(G2*s, t);
acc_beta = step(G2*s^2, t);

gamma = step(G3, t);
vit_gamma = step(G3*s, t);
acc_gamma = step(G3*s^2, t);

figure;
subplot(3,1,1);
plot(t, alpha, 'r', t, beta, 'b', t, gamma, 'g');
title('positions');
legend('alpha', 'beta', 'gamma');
grid on;

subplot(3,1,2);
plot(t, vit_alpha, 'r', t, vit_beta, 'b', t, vit_gamma, 'g');
title('vitesses');
legend('valpha', 'vbeta', 'vgamma');
grid on;

subplot(3,1,3);
plot(t, acc_alpha, 'r', t, acc_beta, 'b', t, acc_gamma, 'g');
title('accels');
legend('aalpha', 'abeta', 'agamma');
grid on;
