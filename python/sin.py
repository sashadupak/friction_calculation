#!/usr/bin/env python3
from ev3dev.ev3 import *
import time
import math

mA = LargeMotor('outA')
mA.position = 0
start = time.time()

try:
    with open('sin_3pi.txt', 'w') as f_obj:
        while (time.time()-start) < 7:
            u = 100*math.sin(3*math.pi*(time.time()-start))
            mA.run_direct(duty_cycle_sp=u)
            f_obj.write(str(mA.position) + ' ' + str(round((time.time()-start)*1000)) + '\n')
finally:
    mA.stop(stop_action='brake')
