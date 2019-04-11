clear()

Ke = 0.5
Km = 0.5
Jm = 0.0025
R = 6
Umax = 8.4
Kf = 0
A = Kf/Jm + (Ke*Km)/(Jm*R)
B = (Km*Umax)/(Jm*R)
l = 1
w = l*%pi
import = "/home/aleksandr/ITMO_lab2/ev3/lab2/data/sin_"+string(l)+"pi.txt"
export1 = "/home/aleksandr/ITMO_lab2/ev3/lab2/photos/graph"+string(l)+".png"
export2 = "/home/aleksandr/ITMO_lab2/ev3/lab2/photos/graph"+string(l+3)+".png"

results = read(import, -1, 2)
len = length(results)/2
angle = results(1:len/l, 1)*%pi/180
time = results(1:len/l, 2)/1000

angle2 = B*(A^2*(1-cos(w*time))+w^2*(1-exp(-A*time))-A*w*sin(w*time))/(A*w*(A^2+w^2))
f1 = figure(1)
a1 = newaxes()
plot2d(time, angle, 2)
plot2d(time, angle2, 5)
xtitle('', 'время, с', 'угол, рад')
legend('Эксперимент', 'Модель', 2)
//xs2png(f1, export1)

function err = func(estimate, measure)
    time = measure(1)
    angle = measure(2)
    A = estimate(1)
    B = estimate(2)
    err = angle - B*(A^2*(1-cos(w*time))+w^2*(1-exp(-A*time))-A*w*sin(w*time))/(A*w*(A^2+w^2))
endfunction

aim = [time, angle]'
init_guess = [40; 4]
[koeffs, errs] = datafit(func, aim, init_guess)
A = koeffs(1)
B = koeffs(2)
Kf = Jm*A - Ke*Km/R
//K = Jm*A

angle3 = B*(A^2*(1-cos(w*time))+w^2*(1-exp(-A*time))-A*w*sin(w*time))/(A*w*(A^2+w^2))

f2 = figure(2)
a2 = newaxes()
plot2d(time, angle, 2)
plot2d(time, angle3, 3)
xtitle('', 'время, с', 'угол, рад')
legend('Эксперимент', 'Модель', 2)
//xs2png(f2, export2)

//mid Kf = 0.00239613

