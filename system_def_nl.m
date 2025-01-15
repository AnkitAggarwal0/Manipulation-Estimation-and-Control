function dx = system_def_nl(t,x)

xc = x(1);
phi = x(2);
xc_dot = x(3);
phi_dot = x(4);

gamma = 2; alpha = 1; beta = 1; D = 1; mu = 3;

A_l = [0 0 1 0; 0 0 0 1; 0 1 -3 0; 0 2 -3 0];
B_l= [0 0 1 1]';
C = [39.37008 0 0 0];
Qu = 450;
Qx = [700 0 0 0; 0 700 0 0; 0 0 15 0; 0 0 0 10];
%Qu = 10; Qx = [1 0 0 0; 0 5 0 0; 0 0 1 0; 0 0 0 5];
[K,S,P] = lqr(A_l,B_l,Qx,Qu);
P
Acl = A_l - B_l * K; 
Acl_inv = inv(Acl);

y_des = 20 * square(2*pi*0.01*t);
K_f = -inv(C*Acl_inv*B_l);

F = K_f * y_des - K * x;


dx = [xc_dot;
    phi_dot;
    (- alpha*sin(phi)*beta*phi_dot^2 + F*alpha - alpha*mu*xc_dot + cos(phi)*sin(phi)*D*beta)/(alpha*gamma - beta^2*cos(phi)^2);
    (- cos(phi)*sin(phi)*beta^2*phi_dot^2 + F*cos(phi)*beta + sin(phi)*D*gamma - mu*xc_dot*cos(phi)*beta)/(alpha*gamma - beta^2*cos(phi)^2)
    ];

end