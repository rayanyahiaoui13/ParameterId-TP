function J = jacobien(theta, p)

    l0   = p(1);
    l1   = p(2);
    l2   = p(3);
    l3   = p(4);

    qo1  = p(5);
    qo2  = p(6);
    qo3  = p(7);

    dx   = p(8);
    dy   = p(9);
    dphi = p(10);

    % Angles reels et angles cumules

    q1 = theta(1) + qo1;
    q2 = theta(2) + qo2;
    q3 = theta(3) + qo3;

    a1 = q1;
    a2 = q1 + q2;
    a3 = q1 + q2 + q3;

    % Position dans R0
    x0 = l1*cos(a1) + l2*cos(a2) + l3*cos(a3);
    y0 = l0 + l1*sin(a1) + l2*sin(a2) + l3*sin(a3);

    % Changement de repere R0 -> Rc

    c = cos(dphi);
    s = sin(dphi);


    % Derivees de x0 et y0 par rapport a l0, l1, l2, l3
    dx0_dl0 = 0;
    dy0_dl0 = 1;

    dx0_dl1 = cos(a1);
    dy0_dl1 = sin(a1);

    dx0_dl2 = cos(a2);
    dy0_dl2 = sin(a2);

    dx0_dl3 = cos(a3);
    dy0_dl3 = sin(a3);

    % Derivees par rapport aux offsets articulaires

    % Derivees de x0 et y0 par rapport a qo1
    dx0_dqo1 = -l1*sin(a1) - l2*sin(a2) - l3*sin(a3);
    dy0_dqo1 =  l1*cos(a1) + l2*cos(a2) + l3*cos(a3);

    % Derivees de x0 et y0 par rapport a qo2
    dx0_dqo2 = -l2*sin(a2) - l3*sin(a3);
    dy0_dqo2 =  l2*cos(a2) + l3*cos(a3);

    % Derivees de x0 et y0 par rapport a qo3
    dx0_dqo3 = -l3*sin(a3);
    dy0_dqo3 =  l3*cos(a3);

    % Jacobienne dans R0

    % Colonnes pour l0, l1, l2, l3
    Jx0 = [dx0_dl0, dx0_dl1, dx0_dl2, dx0_dl3];
    Jy0 = [dy0_dl0, dy0_dl1, dy0_dl2, dy0_dl3];

    % Colonnes pour qo1, qo2, qo3
    Jx0 = [Jx0, dx0_dqo1, dx0_dqo2, dx0_dqo3];
    Jy0 = [Jy0, dy0_dqo1, dy0_dqo2, dy0_dqo3];

    % Prise en compte du changement de repere

    % xm =  c*(x0 - dx) + s*(y0 - dy)
    % ym = -s*(x0 - dx) + c*(y0 - dy)

    % Derivees par rapport aux 7 premiers parametres
    Jx =  c*Jx0 + s*Jy0;
    Jy = -s*Jx0 + c*Jy0;

    % Derivees par rapport a dx
    Jx_dx = -c;
    Jy_dx =  s;

    % Derivees par rapport a dy
    Jx_dy = -s;
    Jy_dy = -c;

    % Derivees par rapport a dphi
    Jx_dphi = -s*(x0 - dx) + c*(y0 - dy);
    Jy_dphi = -c*(x0 - dx) - s*(y0 - dy);

    % Assemblage de la jacobienne 3x10

    J = [ Jx, Jx_dx, Jx_dy, Jx_dphi ;
          Jy, Jy_dx, Jy_dy, Jy_dphi ;
          0 0 0 0 1 1 1 0 0 -1 ];

end