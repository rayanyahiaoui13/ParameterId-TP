function [erreur, rang] = tester_configuration( theta_parfait, p_reel, sigma, p_init, n_iter)


% sigma : amplitude du bruit


    N = size(theta_parfait,1);

    % Generation des mesures parfaites

    X_parfait = zeros(N,3);

    for i = 1:N
        X_parfait(i,:) = modele_geom(theta_parfait(i,:)', p_reel)';
    end

    % Ajout de bruit
    theta_mes = theta_parfait + sigma*randn(N,3);
    X_mes = X_parfait + sigma*randn(N,3);

    % Calcul du rang de la jacobienne globale

    Jglobale = zeros(3*N,10);

    for i = 1:N
        J_i = jacobien(theta_parfait(i,:)', p_reel);
        Jglobale(3*i-2:3*i,:) = J_i;
    end

    rang = rank(Jglobale);

    % Identification

    p_bruit = identification(theta_mes, X_mes, p_init, n_iter);

    % Erreur sur les parametres

    erreur = norm(p_bruit - p_reel);

end