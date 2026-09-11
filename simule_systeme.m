definit_parametres

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

G1 = 1/(F1- (F2*F3/(F4-(F5*F6/F7)))
G2 = G1*-F3/(F4-(F5*F6/F7))
G3 = -F6/F7*G2
