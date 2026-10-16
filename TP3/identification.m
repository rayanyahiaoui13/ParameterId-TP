function [p, err_hist] = identification(theta_mes, X_mes, p_init, n_iter)
% theta_mes : matrice Nx3 des angles articulaires mesures
% X_mes : matrice Nx3 des mesures cartesiennes
% p_init : estimation initiale des 10 parametres
% n_iter : nombre maximal d'iterations
% p : vecteur 10x1 des parametres identifies

    N = size(theta_mes, 1);
    p = p_init;

    err_hist = zeros(n_iter, 1);

    fprintf('\nIterations de Gauss-Newton :\n');
    fprintf('----------------------------------------------\n');
    fprintf('  Iteration      ||erreur||          cout\n');
    fprintf('----------------------------------------------\n');

    for k = 1:n_iter
        % Construction du residu et de la jacobienne globale

        err = zeros(3*N, 1);
        J = zeros(3*N, 10);

        for i = 1:N
            theta_i = theta_mes(i, :)';

            X_calc = modele_geom(theta_i, p);
            J_i = jacobien(theta_i, p);

            err(3*i-2:3*i) = X_mes(i, :)' - X_calc;
            J(3*i-2:3*i, :) = J_i;
        end

        % Affichage de l'iteration courante

        norm_err = norm(err);
        cout = norm_err^2;

        fprintf('%10d %18.6e %18.6e\n', k, norm_err, cout);

        % On retire la colonne associee a l0
        J_reduit = J(:, 2:10);

        % Mise a jour Gauss-Newton
        dp_reduit = J_reduit \ err;

        % La variation de l0 est nulle
        dp = [0; dp_reduit];

        % Mise a jour des parametres
        p = p + dp;

        % Historique de l'erreur

        err_hist(k) = cout;

    end

    fprintf('----------------------------------------------\n');

end