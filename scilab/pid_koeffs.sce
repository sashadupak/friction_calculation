Jm = 0.0025
Ke = 0.5
Km = 0.5
R = 6.1
Umax = 8.4
Kf = 0.0024 //0.00239613
A = Kf/Jm + (Ke*Km)/(Jm*R)
B = (Km*Umax)/(Jm*R)
K = Jm*A

tp = 0.5
//Nuton
t_n2 = 4.8
t_n3 = 6.3
w0_n2 = t_n2/tp
w0_n3 = t_n3/tp
//pid
Kp_n = 3*(w0_n3^2)*Jm
Ki_n = (w0_n3^3)*Jm
Kd_n = 3*w0_n3*Jm - K
//pi
kp_n1 = 2*w0_n2*Jm - K
ki_n1 = (w0_n2^2)*Jm

//Batterwort
t_b2 = 2.9
t_b3 = 6.0
w0_b2 = t_b2/tp
w0_b3 = t_b3/tp
//pid
kp_b = 2*(w0_b3^2)*Jm
ki_b = (w0_b3^3)*Jm
kd_b = 2*w0_b3*Jm - K
//pi
kp_b1 = 1.4*w0_b2*Jm - K
ki_b1 = (w0_b2^2)*Jm

