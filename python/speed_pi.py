#!/usr/bin/env python3
from ev3dev.ev3 import *
import math

kp = 0.058
ki = 2.1
integral = 0

mA = LargeMotor('outA')
try:
    mA.position = 0
    with open('bat_t01_p'+str(kp)+'-i'+str(ki)+'.txt', 'w') as f_obj:
        start = time.time()
        while (time.time() - start) < 5:
            err = 10 - mA.speed*math.pi/180
            integral += err*ki
            if abs(integral) > 10:
                int = math.copysign(1, integral)
            u = kp * err + integral
            u = u*100/8.4
            if abs(u)>100:
                u=math.copysign(100,u)
            mA.run_direct(duty_cycle_sp=u)
            f_obj.write(str(mA.speed) + ' ' + str(time.time() - start) + '\n \n')
finally:
    mA.stop(stop_action='brake')

