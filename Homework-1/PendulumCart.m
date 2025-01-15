clear; 

syms alpha beta gamma D mu xc phi xc_dot phi_dot F xc_ddot phi_ddot
equation1 = gamma * xc_ddot - beta * phi_ddot * cos(phi) + beta * phi_dot * phi_dot * sin(phi) + mu * xc_dot - F == 0;
equation2 = alpha * phi_ddot - beta * xc_ddot * cos(phi) - D * sin(phi) == 0;
Sol = solve([equation1,equation2],[xc_ddot,phi_ddot]);


dt = 0.01;
tspan = 0:dt:30;
%x_0 = [0,0.1,0,0]';
%x_0 = [0 0.5 0 0]';
%x_0 = [0 1.0886 0 0]';
x_0 = [0 1.1 0 0]';

A_linearised = [0 0 1 0; 0 0 0 1; 0 1 -3 0; 0 2 -3 0];
B_linearised = [0 0 1 1]';
Qu = 10;
Qx = [1 0 0 0; 0 5 0 0; 0 0 1 0; 0 0 0 5];
[K,S,P] = lqr(A_linearised,B_linearised,Qx,Qu);

eig(A_linearised)

t_nonlinear = 0:dt:5; %used for when system is not converging to 0
[t_sol_nl, x_sol_nl] = ode45(@system_def_nl_open,t_nonlinear,x_0);
figure()
plot(t_sol_nl, x_sol_nl(:,1))
hold on
plot(t_sol_nl, x_sol_nl(:,2))
hold on
plot(t_sol_nl, x_sol_nl(:,3))
hold on
plot(t_sol_nl, x_sol_nl(:,4))
legend('X_c','phi','X_c dot', 'phi dot')
xlabel('time, s')
ylabel('Non-Linear System State Elements')

[t_sol_l, x_sol_l] = ode45(@system_def_l,tspan,x_0);
figure()
plot(t_sol_l, x_sol_l(:,1))
hold on
plot(t_sol_l, x_sol_l(:,2))
hold on
plot(t_sol_l, x_sol_l(:,3))
hold on
plot(t_sol_l, x_sol_l(:,4))
legend('X_c','phi','X_c dot', 'phi dot')
xlabel('time, s')
ylabel('Linear System State Elements')

