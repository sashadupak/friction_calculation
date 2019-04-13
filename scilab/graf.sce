sim_time = 5
sim_period = 0.01
sim_buffer = sim_time/sim_period
Jm = 0.0025
K = 0.043
km = 0.5
R = 6.1
voltage = 8.4
des = 2*%pi
kp = 0.8
ki = 2.9
kd = 0.035
anti_wind_up = 0.1
file_name = "Nut_ang_pid/t0.6_p0.8-i2.9-d0.035.txt"

res = read("/home/aleksandr/ITMO_lab2/ev3/lab2/data/" + file_name, -1, 2)
y = res(:, 1)*%pi/180
x = res(:, 2)

importXcosDiagram("/home/aleksandr/ITMO_lab2/ev3/lab2/scilab/model.zcos");
xcos_simulate(scs_m, 4);

plot2d(x, y, 2)
plot2d(S.time, S.values, 5)
xtitle('', 'время, с', 'угол, рад')
legend('Эксперимент', 'Модель', 4)
xs2png(0, "/home/aleksandr/ITMO_lab2/ev3/lab2/photos/ang_nut_06")
