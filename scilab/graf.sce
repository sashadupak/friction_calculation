sim_time = 5
sim_period = 0.01
sim_buffer = sim_time/sim_period
Jm = 0.0025
K = 0.043
km = 0.5
R = 6.1
voltage = 8.4
des = 2*%pi
kp = 0.037
ki = 0.64
kd = 0
anti_wind_up = 1
file_name = "Nut_sp_pi/t0.3_p0.037-i0.64.txt"

res = read("/home/aleksandr/ITMO_lab2/ev3/lab2/data/" + file_name, -1, 2)
y = res(:, 1)*%pi/180
x = res(:, 2)

importXcosDiagram("/home/aleksandr/ITMO_lab2/ev3/lab2/scilab/model1.zcos");
xcos_simulate(scs_m, 4);

plot2d(x, y, 2)
plot2d(S.time, S.values, 5)
xtitle('', 'время, с', 'скорость, рад/с')
legend('Эксперимент', 'Модель', 4)
xs2png(0, "/home/aleksandr/ITMO_lab2/ev3/lab2/photos/speed_nut_03")
