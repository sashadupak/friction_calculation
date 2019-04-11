#!/usr/bin/env python3
from ev3dev.ev3 import *
import math

kp = 4.5
ki = 67.5
kd = 0.1
integral = 0
err_old = 0
mA = LargeMotor('outA')
try:
    mA.position = 0
    with open('bat_t02_p'+str(kp)+'-i'+str(ki)+'-d'+str(kd)+'.txt', 'w') as f_obj:
        start = time.time()
        while (time.time() - start) < 5:
            err = 2*math.pi - mA.position*math.pi/180
            integral += err*ki
            if abs(integral) > 1:
                integral = math.copysign(1, integral)
            derivative = (err - err_old)*kd
            err_old = err
            u = kp * err + integral + derivative
            u = u*100/8.4
            if abs(u)>100:
                u=math.copysign(100,u)
            mA.run_direct(duty_cycle_sp=u)
            f_obj.write(str(mA.position) + ' ' + str(time.time() - start) + '\n \n')
finally:
    mA.stop(stop_action='brake')

