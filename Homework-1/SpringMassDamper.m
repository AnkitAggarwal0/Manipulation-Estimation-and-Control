clear; 
dt = 0.01;
t = 0:dt:5;
m = 1; mu = 0.5; k = 5;

A = [0 1;
    -k/m -mu/m];
B = [0 1/m]';
C = eye(2);
D = [0;0];

x_1 = [0 1]';

% response for 1e
x = zeros(2,length(t));
for idx = 1:length(t)
    x(:,idx) = expm(A*t(idx)) * x_1;
end
figure()
plot(t,x(1,:))
title("Unforced Open Loop System")
xlabel('Time, s')
ylabel('System position (q), m')

% 1.f
p = [-1 + 1i, -1 - 1i];
K = place(A,B,p);

% 1.g
tcl = 0:dt:10;
Acl = A - B*K;
xcl = zeros(2,length(tcl));
for j = 1:length(tcl)
    xcl(:,j) = expm(Acl*tcl(j)) * x_1;
end
figure()
plot(tcl,xcl(1,:))
title("System with Feedback Law")
xlabel('Time, s')
ylabel('System position (q), m')
