#!/usr/bin/env python3
from ev3dev.ev3 import *
import math

kp = 0.058
ki = 2.1
old = 0
old_time = 0
int = 0

mA = LargeMotor('outA')
try:
    mA.position = 0
    with open('sbat_t01_p'+str(kp)+'-i'+str(ki)+'.txt', 'w') as f_obj:
        start = time.time()
        while (time.time() - start) < 5:
            #dt = time.time()-old_time
            #old_time = time.time()
            err = 10 - mA.speed*math.pi/180
            #old = mA.position
            int += err*ki
            if abs(int) > 10:
                int = math.copysign(1, int)
            #dev = (err - err_old)*kd
            u = kp * err + int
            u = u*100/8.4
            if abs(u)>100:
                u=math.copysign(100,u)
            mA.run_direct(duty_cycle_sp=u)
            f_obj.write(str(mA.speed) + ' ' + str(time.time() - start) + '\n \n')
finally:
    mA.stop(stop_action='brake')

