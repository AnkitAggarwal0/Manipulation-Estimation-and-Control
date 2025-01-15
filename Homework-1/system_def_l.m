function dx = system_def_l(t,x)
A_linearised = [0 0 1 0; 0 0 0 1; 0 1 -3 0; 0 2 -3 0];

B_linearised = [0 0 1 1]';

Qu = 10;
Qx = [1 0 0 0; 0 5 0 0; 0 0 1 0; 0 0 0 5];

[K,S,P] = lqr(A_linearised,B_linearised,Qx,Qu);
Acl = A_linearised - B_linearised* K; 

dx = Acl*x;

end
