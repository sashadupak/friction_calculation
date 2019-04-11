//read data
res = read("/home/aleksandr/ITMO_lab2/ev3/lab2/2/my/pi/snut_t05_p0.0046-i0.23.txt", -1, 2)
y = res(:, 1)*%pi/180
x = res(:, 2)

plot2d(x, y)
