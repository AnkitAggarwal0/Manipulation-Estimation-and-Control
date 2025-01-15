function dx_xhat = system_nl_error(t,x)

% model set up 
x_true = x(1:4);
x_estimate = x(5:8);

xc = x(1);
phi = x(2);
xc_dot = x(3);
phi_dot = x(4);

xc_hat = x(5);
phi_hat = x(6);
xc_dot_hat = x(7);
phi_dot_hat = x(8);

gamma = 2; alpha = 1; beta = 1; D = 1; mu = 3;

A_l = [0 0 1 0; 0 0 0 1; 0 1 -3 0; 0 2 -3 0];
B_l= [0 0 1 1]';
C = [39.37008 0 0 0];
Qu = 450;
Qx = [700 0 0 0; 0 700 0 0; 0 0 15 0; 0 0 0 10];
[Kc,~,~] = lqr(A_l,B_l,Qx,Qu);
% P = [-0.4571 -0.6601 -1.2558 -3.2915]'
Acl = A_l - B_l * Kc; 
Acl_inv = inv(Acl);
y_des = 20 * square(2*pi*0.01*t);
K_f = -inv(C*Acl_inv*B_l);

% true model 
F = K_f * y_des - Kc * x_estimate;
dx_true = [xc_dot;
    phi_dot;
    (- alpha*sin(phi)*beta*phi_dot^2 + F*alpha - alpha*mu*xc_dot + cos(phi)*sin(phi)*D*beta)/(alpha*gamma - beta^2*cos(phi)^2);
    (- cos(phi)*sin(phi)*beta^2*phi_dot^2 + F*cos(phi)*beta + sin(phi)*D*gamma - mu*xc_dot*cos(phi)*beta)/(alpha*gamma - beta^2*cos(phi)^2)
    ];

% estimated model 
poles_observed = [-3, -4, -6, -15];
K_not = (place(A_l',C',poles_observed))';

dx_hat = [xc_dot_hat;
    phi_dot_hat;
    (- alpha*sin(phi_hat)*beta*phi_dot_hat^2 + F*alpha - alpha*mu*xc_dot_hat + cos(phi_hat)*sin(phi_hat)*D*beta)/(alpha*gamma - beta^2*cos(phi_hat)^2);
    (- cos(phi_hat)*sin(phi_hat)*beta^2*phi_dot_hat^2 + F*cos(phi_hat)*beta + sin(phi_hat)*D*gamma - mu*xc_dot_hat*cos(phi_hat)*beta)/(alpha*gamma - beta^2*cos(phi_hat)^2)
    ];
dx_hat = dx_hat + K_not * (C*x_true - C*x_estimate);

% final output
dx_xhat = [dx_true; dx_hat];

end