clear; 
t_des = 0:0.01:20; 
x_0 = [0,0,0,0]';
xhat_0 = [0.01, 0.01, -0.03, 0.01]';
x_xhat_0 = [x_0; xhat_0];

[t_sol, d_x_xhat_sol] = ode45(@system_nl_error, t_des, x_xhat_0);

figure()
plot(t_sol, d_x_xhat_sol(:,1))
hold on
plot(t_sol, d_x_xhat_sol(:,5))
xlabel('time, s')
ylabel('x_c')
legend('Actual','Estimated')
title('Actual v/s Estimated Linear Position')
hold off

figure()
plot(t_sol, d_x_xhat_sol(:,2))
hold on
plot(t_sol, d_x_xhat_sol(:,6))
xlabel('time, s')
ylabel('phi')
legend('Actual','Estimated')
title('Actual v/s Estimated Angular Position')
hold off

figure()
plot(t_sol, d_x_xhat_sol(:,3))
hold on
plot(t_sol, d_x_xhat_sol(:,7))
xlabel('time, s')
ylabel('Xc_{dot}')
legend('Actual','Estimated')
title('Actual v/s Estimated Linear Velocity')
hold off

figure()
plot(t_sol, d_x_xhat_sol(:,4))
hold on
plot(t_sol, d_x_xhat_sol(:,8))
xlabel('time, s')
ylabel('phi_{dot}')
legend('Actual','Estimated')
title('Actual v/s Estimated Angular Velocity')
hold off


