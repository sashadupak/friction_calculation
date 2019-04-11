function err = func(estimate, measure)
    time = measure(1)
    angle = measure(2)
    A = estimate(1)
    B = estimate(2)
    err = angle - B*(A^2*(1-cos(w*time))+w^2*(1-exp(-A*time))-A*w*sin(w*time))/(A*w*(A^2+w^2))
endfunction

clear()

Ke = 0.5
Km = 0.5
Jm = 0.0025
R = 6
Umax = 8.4
num = 3

for l = 1:num
    w = l*%pi
    import = "/home/aleksandr/ITMO_lab2/ev3/lab2/data/sin_"+string(l)+"pi.txt"
    export1 = "/home/aleksandr/ITMO_lab2/ev3/lab2/photos/graph"+string(l)+".png"
    export2 = "/home/aleksandr/ITMO_lab2/ev3/lab2/photos/graph"+string(l+3)+".png"

    results = read(import, -1, 2)
    len = length(results)/2
    angle = results(1:len/l, 1)*%pi/180
    time = results(1:len/l, 2)/1000
    
    Kf = 0
    A = Kf/Jm + (Ke*Km)/(Jm*R)
    B = (Km*Umax)/(Jm*R)
    
    angle2 = B*(A^2*(1-cos(w*time))+w^2*(1-exp(-A*time))-A*w*sin(w*time))/(A*w*(A^2+w^2))
    f1 = figure(l)
    a1 = newaxes()
    plot2d(time, angle, 2)
    plot2d(time, angle2, 5)
    xtitle('', 'время, с', 'угол, рад')
    legend('Эксперимент', 'Модель', 2)
    //xs2png(f1, export1)

    aim = [time, angle]'
    init_guess = [40; 4]
    [koeffs, errs] = datafit(func, aim, init_guess)
    A = koeffs(1)
    B = koeffs(2)
    Kf = Jm*A - Ke*Km/R

    angle3 = B*(A^2*(1-cos(w*time))+w^2*(1-exp(-A*time))-A*w*sin(w*time))/(A*w*(A^2+w^2))

    f2 = figure(l+1)
    a2 = newaxes()
    plot2d(time, angle, 2)
    plot2d(time, angle3, 3)
    xtitle('', 'время, с', 'угол, рад')
    legend('Эксперимент', 'Модель', 2)
    //xs2png(f2, export2)
    
    sum_Kf = sum_Kf + Kf
end

//Kf = 0.00239613 0.0024
Kf = sum_Kf/num
A = Kf/Jm + (Ke*Km)/(Jm*R)
B = (Km*Umax)/(Jm*R)
K = Jm*A

tp = 3.5
//Nuton
t_n2 = 4.8
t_n3 = 6.3
w0_n = t_standart/tp
//pid
Kp_n = 3*(w0^2)*Jm
Ki_n = (w0^3)*Jm
Kd_n = 3*w0*Jm - K
//pi
kp_n = 2*w0*Jm - K//k - ???
ki = 

//Batterwort
t_b2 = 2.9
t_b3 = 6.0
//pid
kp = 2*(w0^2)*Jm
ki = (w0^3)*Jm
kd = 2*w0*Jm - K
//pi
kp = 1.4*w0*Jm - K
ki = (w0^2)*Jm
ki = (w0^2)*Jm
