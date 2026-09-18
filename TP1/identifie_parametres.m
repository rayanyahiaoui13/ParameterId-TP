A = [];
c = [];

for i = 1:length(mesures)
    k = mesures(i);
    
    ligne1 = [alpha(k), alpha(k)-beta(k), 0, vit_alpha(k), vit_alpha(k)-vit_beta(k), 0, acc_alpha(k), 0, 0];
    ligne2 = [0, beta(k)-alpha(k), beta(k)-gamma(k), 0, vit_beta(k)-vit_alpha(k), vit_beta(k)-vit_gamma(k), 0, acc_beta(k), 0];
    ligne3 = [0, 0, gamma(k)-beta(k), 0, 0, vit_gamma(k)-vit_beta(k), 0, 0, acc_gamma(k)];

    c1 = f(k);
    c2 = 0;
    c3 = 0;
    
    A = [A ; ligne1 ; ligne2 ; ligne3];
    c = [c ; c1 ; c2 ; c3];
end

x_hat= A \c;