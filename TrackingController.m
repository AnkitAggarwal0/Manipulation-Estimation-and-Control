clear;
t_des = 0:0.01:200;
x_0 = [0,0,0,0];

[t_sol_nl, x_sol_nl] = ode45(@system_def_nl,t_des,x_0);

C = [39.37008 0 0 0];
y_actual = zeros(1,length(x_sol_nl));
x_sol_nl_t = x_sol_nl';
for i = 1:length(x_sol_nl_t)
    y_actual(i) = C * x_sol_nl_t(:,i);
end

figure()
plot(t_sol_nl,y_actual)
hold on 
y_des = 20 * square(2*pi*0.01*t_sol_nl);
plot(t_sol_nl, y_des)
legend('y_{actual}', 'y_{des}')
xlabel('time, s')
ylabel('Cart position, in')

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
ylabel('Non-Linear System State Elements with desired inputs y_{des}')