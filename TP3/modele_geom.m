function X = modele_geom(theta, p)

    % Extraction des parametres
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

    q1 = theta(1) + qo1;
    q2 = theta(2) + qo2;
    q3 = theta(3) + qo3;

    a1 = q1;
    a2 = q1 + q2;
    a3 = q1 + q2 + q3;

    x0 = l1*cos(a1) + l2*cos(a2) + l3*cos(a3);
    y0 = l0 + l1*sin(a1) + l2*sin(a2) + l3*sin(a3);

    % Orientation de l'outil dans Rc
    alpha = a3 - pi/2 - dphi;

    % Expression de la position dans Rc
    c = cos(dphi);
    s = sin(dphi);

    xm =  c*(x0 - dx) + s*(y0 - dy);
    ym = -s*(x0 - dx) + c*(y0 - dy);

    X = [xm; ym; alpha];
end