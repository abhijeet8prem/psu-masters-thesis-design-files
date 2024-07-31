##########################################################################################
# 3-phase-duty.py - Script to generate the duty ratios for 3 phase space vector modulation
#
# Authors        : Abhijeet Prem, Mahima Gupta
# Rev           : 0.1  
# Last modified : 07-27-22
#
# Description
# ------------
#   This scripts plots the duty ratios for 3 pahse AC using space vector modulation.

# Tasks:
# ------
#   o Write to file option
#   o Offset duty ratios
# Dependencies
# ------------
# Last bult for Python 3.10, install python from https://www.python.org/downloads/
# make sure to check install pip option while installing python
# Numphy: 1.23.1,       Run 'pip install numpy'
# Matplotlib: 3.5.2,    Run 'pip install matplotlib'
#
###########################################################################################

from random import sample
import matplotlib.pyplot as plt
import numpy as np
import math


# declare variables
sectors = 6
samples = sectors*44
pi = np.pi
fp = 60
tp = 1/fp
N_bits = 13                   # number of bits 
# n = np.linspace(0,264,264)  # 264,264 the actual number of samples
# number of smaples for 1 secter
n = np.linspace(0,sectors*(pi/3),samples)
A = 170  # for out case the Vpeak line to line = 170V,  
Vdc = 400
dead_time = 0.00244        # the dead time in % for 13 bit resulution, 160ns

Va = A*np.cos(n)
Vb = A*np.cos(n -(2*pi)/3)
Vc = A*np.cos(n -(4*pi)/3)

# find line to line voltages
Vab = Va - Vb
Vbc = Vb - Vc

# list declaration
Vmax = []
Vmin = []
Vmid = []
Vx = []
Vy = []
dx =[]
dy = []
hA_duty = []
hA_offset = []
hA_duty_b2 = []
hA_offset_b2 = []
hA_duty_b1 = []

hB_duty = []
hB_offset = []
hB_duty_b1 = []
hB_duty_b2 = []
hB_offset_b2 = []

hC_duty = []
hC_offset = []
hC_duty_b1 = []
hC_duty_b2 = []
hC_offset_b2 = []


for i in range(0,samples):
    Vmax.append(max(Va[i],Vb[i],Vc[i]))
    Vmin.append(min(Va[i],Vb[i],Vc[i]))
    Vmid.append(((-1*Vmax[i])-Vmin[i]))
    
    Vx.append(Vmax[i]-Vmid[i])
    Vy.append(Vmid[i]-Vmin[i])
    
    dx.append(Vx[i]/Vdc)
    dy.append(Vy[i]/Vdc)

    

# finding the duty expressions for phase a
    if Va[i] >= Vb[i] and Va[i] >=Vc[i]:
        hA_duty.append(dx[i] + dy[i])
        hA_offset.append(0 + dead_time)
        hA_duty_b2.append(1 - (dx[i] + dy[i] + (2 * dead_time)))       # calculating the duty for the bottom switch 
        hA_offset_b2.append(dx[i] + dy[i] + (2 * dead_time))
        hA_duty_b1.append(0)
        
    elif Va[i] < Vb[i] and Va[i] < Vc[i]:
        hA_duty.append(0) 
        hA_offset.append(0)
        hA_duty_b2.append(0.999755859375)       # calculating the duty for the bottom switch 
        hA_offset_b2.append(0)
        hA_duty_b1.append(0)

    else:
        if Va[i] >= 0:
            hA_duty.append(dy[i]) 
            hA_offset.append(0 + dead_time)
            hA_duty_b2.append(1 - (dx[i] + (2 * dead_time)))       # calculating the duty for the bottom switch 
            hA_offset_b2.append(dx[i] + (2 * dead_time))
            hA_duty_b1.append(0)

        else:
            hA_duty.append(dy[i]) 
            hA_offset.append(dx[i] + dead_time)
            hA_duty_b2.append(1 - (dx[i] + dy[i] + (2 * dead_time)))       # calculating the duty for the bottom switch 
            hA_offset_b2.append(dx[i] + dy[i] + (2 * dead_time))         # calculating the offset for the bottom switch
            hA_duty_b1.append(dy[i])

# finding the duty expressions for phase b
    if Vb[i] >= Va[i] and Vb[i] >=Vc[i]:
        hB_duty.append(dx[i] + dy[i]) 
        hB_offset.append(0 + dead_time)
        hB_duty_b2.append(1 - (dx[i] + dy[i] + (2 * dead_time)))          # calculating the duty for the bottom switch 
        hB_offset_b2.append(dx[i] + dy[i] + (2 * dead_time))
        hB_duty_b1.append(0)
        
    elif Vb[i] < Va[i] and Vb[i] < Vc[i]:
        hB_duty.append(0) 
        hB_offset.append(0)
        hB_duty_b2.append(0.999755859375)                               # calculating the duty for the bottom switch 
        hB_offset_b2.append(0)
        hB_duty_b1.append(0)

    else:
        if Vb[i] >= 0:
            hB_duty.append(dy[i]) 
            hB_offset.append(0 +  dead_time)
            hB_duty_b2.append(1 - (dx[i] + (2 * dead_time)))               # calculating the duty for the bottom switch 
            hB_offset_b2.append(dx[i] + (2 * dead_time))
            hB_duty_b1.append(0) 
        else:
            hB_duty.append(dy[i]) 
            hB_offset.append(dx[i] + dead_time)
            hB_duty_b2.append(1 - (dx[i] + dy[i] + (2 * dead_time)))       # calculating the duty for the bottom switch 
            hB_offset_b2.append(dx[i] + dy[i] + (2 * dead_time))         # calculating the offset for the bottom switch
            hB_duty_b1.append(dy[i])

# finding the duty expressions for phase c
    if Vc[i] >= Va[i] and Vc[i] >=Vb[i]:
        hC_duty.append(dx[i] + dy[i]) 
        hC_offset.append(0 + dead_time)
        hC_duty_b2.append(1 - (dx[i] + dy[i] + (2 * dead_time)))       # calculating the duty for the bottom switch 
        hC_offset_b2.append(dx[i] + dy[i] + (2 * dead_time))
        hC_duty_b1.append(0)
        
    elif Vc[i] < Va[i] and Vc[i] < Vb[i]:
        hC_duty.append(0) 
        hC_offset.append(0)
        hC_duty_b2.append(0.999755859375)                                  # calculating the duty for the bottom switch 
        hC_offset_b2.append(0)
        hC_duty_b1.append(0)

    else:
        if Vc[i] >= 0:
            hC_duty.append(dy[i]) 
            hC_offset.append(0 + dead_time)                                # adding some dead time to the offset
            hC_duty_b2.append(1 - (dx[i] + (2 * dead_time)))                 # calculating the duty for the bottom switch 
            hC_offset_b2.append(dx[i] + (2 * dead_time))
            hC_duty_b1.append(0) 
        else:
            hC_duty.append(dy[i]) 
            hC_offset.append(dx[i] + dead_time)                           # the offset + dead time
            hC_duty_b2.append(1 - (dx[i] + dy[i] + (2 * dead_time) ))       # calculating the duty for the bottom switch 
            hC_offset_b2.append(dx[i] + dy[i] + (2 * dead_time) )         # calculating the offset for the bottom switch
            hC_duty_b1.append(dy[i])
 

# test parameter, remove later
print("size of n "+ str(len(n)))  

print(Va[samples-1])
print("Vab : ")
print(Vab)
print("\nVbc : ")
print(Vbc)
print("max values ")
print(Vmax)
print("\nhA: ")
print(hA_duty)


# generating a figure object
fig = plt.figure()

#plt.subplot(3,2,1)
plt.plot(n,Va, 'b-', label='Va=cos(wt)')
plt.plot(n,Vb, 'c-', label='Vb=cos(wt - (2pi/3) )')
plt.plot(n,Vc, 'm-', label='Vc=cos(wt - (4pi/3))')
#plt.legend(loc='upper left')

# ploat function
# plot the functions, with labels
#plt.subplot(3,2,1)
#plt.plot(n,Va, 'b-', label='Va=cos(wt)')
#plt.plot(n,Vb, 'c-', label='Vb=cos(wt - (2pi/3) )')
#plt.plot(n,Vc, 'm-', label='Vc=cos(wt - (4pi/3))')
#plt.legend(loc='upper left')
#
#
##plt.subplot(3,2,2)
##plt.plot(n,Vab, 'r-',label= 'Vab')
##plt.plot(n,Vbc, 'y-',label= 'Vbc')
##plt.plot(n,Vx, 'g-',label= 'Vx')
##plt.plot(n,Vy, 'b-',label= 'Vy')
##plt.legend(loc='upper left')
#
#plt.subplot(3,2,3)
#plt.plot(n,Vmax, 'r-',label= 'Vmax')
#plt.plot(n,Vmin, 'y-',label= 'Vmin')
#plt.plot(n,Vmid, 'b-', label='Vmid')
#
#plt.legend(loc='upper left')
#
#plt.subplot(3,2,5)
#plt.plot(n,dx, 'b-', label='dx')
#plt.plot(n,dy, 'm-', label='dy')
#plt.legend(loc='upper left')
#
#plt.subplot(3,2,2)
#plt.plot(n, hA_duty, 'b-', label='hA')
#plt.plot(n,hA_offset, 'm-', label='hA_offset')
#plt.legend(loc='upper left')
#
#plt.subplot(3,2,4)
#plt.plot(n,hB_duty, 'y-', label='hB')
#plt.plot(n,hB_offset, 'g-', label='hB_offset')
#plt.legend(loc='upper left')
#
#plt.subplot(3,2,6)
#plt.plot(n,hC_duty, 'r-', label='hC')
#plt.plot(n,hC_offset, 'g-', label='hC_offset')
#plt.legend(loc='upper left')
##Auto adjust
#plt.tight_layout()

# show the plot
plt.show()

# generate the necessary files

#ph_a_top_duty   = open("pwm_phase_a_dty_t.txt","w")            # opening teh file to store phase "A" top duty values in write mode
#ph_a_top_offset = open("pwm_phase_a_dty_t_off.txt","w")        # opening teh file to store phase "A" top duty values in write mode


ph_a_top_duty    = open("pwm_phase_a_dty_t.vh","w")             # opening teh file to store phase "A" top duty values in write mode
ph_a_top_offset  = open("pwm_phase_a_dty_t_off.vh","w")         # opening teh file to store phase "A" top duty values in write mode
ph_a_btm2_duty   = open("pwm_phase_a_dty_b2.vh","w")            # opening teh file to store phase "A" bottom duty values in write mode
ph_a_btm2_offset = open("pwm_phase_a_dty_b2_off.vh","w")        # opening teh file to store phase "A" bottom duty values in write mode
ph_a_btm1_duty   = open("pwm_phase_a_dty_b1.vh","w")            # opening teh file to store phase "A" bottom duty values in write mode


ph_b_top_duty    = open("pwm_phase_b_dty_t.vh","w")             # opening teh file to store phase "B" top duty values in write mode
ph_b_top_offset  = open("pwm_phase_b_dty_t_off.vh","w")         # opening teh file to store phase "B" top duty values in write mode
ph_b_btm2_duty   = open("pwm_phase_b_dty_b2.vh","w")            # opening teh file to store phase "B" bottom duty values in write mode
ph_b_btm2_offset = open("pwm_phase_b_dty_b2_off.vh","w")        # opening teh file to store phase "B" bottom duty values in write mode
ph_b_btm1_duty   = open("pwm_phase_b_dty_b1.vh","w")            # opening teh file to store phase "B" bottom duty values in write mode

ph_c_top_duty    = open("pwm_phase_c_dty_t.vh","w")             # opening teh file to store phase "C" top duty values in write mode
ph_c_top_offset  = open("pwm_phase_c_dty_t_off.vh","w")         # opening teh file to store phase "C" top duty values in write mode
ph_c_btm2_duty   = open("pwm_phase_c_dty_b2.vh","w")            # opening teh file to store phase "C" bottom duty values in write mode
ph_c_btm2_offset = open("pwm_phase_c_dty_b2_off.vh","w")        # opening teh file to store phase "C" bottom duty values in write mode
ph_c_btm1_duty   = open("pwm_phase_c_dty_b1.vh","w")            # opening teh file to store phase "C" bottom duty values in write mode


# uncomment this when needed

K= 2 ** N_bits

hA_duty_value       = [math.floor(x * K) for x in hA_duty]       # generating the duty ratio values for phase a top switch
hA_offset_value     = [math.floor(x * K) for x in hA_offset]          # generating the duty ratio values for phase a top switch
hA_duty_b2_value    = [math.floor(x * K) for x in hA_duty_b2]         # generating the duty ratio values for phase a btm switch
hA_offset_b2_value  = [math.floor(x * K) for x in hA_offset_b2]       # generating the duty ratio values for phase a btm switch
hA_duty_b1_value    = [math.floor(x * K) for x in hA_duty_b1]         # generating the duty ratio values for phase a top switch

hB_duty_value       = [math.floor(x * K) for x in hB_duty]            # generating the duty ratio values for phase a top switch
hB_offset_value     = [math.floor(x * K) for x in hB_offset]          # generating the duty ratio values for phase a top switch
hB_duty_b2_value    = [math.floor(x * K) for x in hB_duty_b2]         # generating the duty ratio values for phase a btm switch
hB_offset_b2_value  = [math.floor(x * K) for x in hB_offset_b2]       # generating the duty ratio values for phase a btm switch
hB_duty_b1_value    = [math.floor(x * K) for x in hB_duty_b1]         # generating the duty ratio values for phase a top switch

hC_duty_value       = [math.floor(x * K) for x in hC_duty]            # generating the duty ratio values for phase a top switch
hC_offset_value     = [math.floor(x * K) for x in hC_offset]          # generating the duty ratio values for phase a top switch
hC_duty_b2_value    = [math.floor(x * K) for x in hC_duty_b2]         # generating the duty ratio values for phase a btm switch
hC_offset_b2_value  = [math.floor(x * K) for x in hC_offset_b2]       # generating the duty ratio values for phase a btm switch
hC_duty_b1_value    = [math.floor(x * K) for x in hC_duty_b1]         # generating the duty ratio values for phase a top switch

#print("\nhA duty :")
#print(hA_duty_value)
#print("\nhA offset :")
#print(hA_offset_value)

#ph_a_top_duty.write("\n".join(str(item[2:]) for item in hA_duty_value))         # writing to the phase a file
#ph_a_top_offset.write("\n".join(str(item[2:]) for item in hA_offset_value))     # writing to the phase a file


for i in range(0,samples):  
    ph_a_top_duty.write("\t\trom_mem_dty_t["+ str(i) +"] = 13'd"+ str(hA_duty_value[i]) +";\n")
    ph_a_top_offset.write("\t\trom_mem_dty_t_off["+ str(i) +"] = 13'd"+ str(hA_offset_value[i]) +";\n")
    ph_a_btm1_duty.write("\t\trom_mem_dty_b1["+ str(i) +"] = 13'd"+ str(hA_duty_b1_value[i]) +";\n") 
    ph_a_btm2_duty.write("\t\trom_mem_dty_b2["+ str(i) +"] = 13'd"+ str(hA_duty_b2_value[i]) +";\n")
    ph_a_btm2_offset.write("\t\trom_mem_dty_b2_off["+ str(i) +"] = 13'd"+ str(hA_offset_b2_value[i]) +";\n")

    ph_b_top_duty.write("\t\trom_mem_dty_t["+ str(i) +"] = 13'd"+ str(hB_duty_value[i]) +";\n")
    ph_b_top_offset.write("\t\trom_mem_dty_t_off["+ str(i) +"] = 13'd"+ str(hB_offset_value[i]) +";\n")
    ph_b_btm1_duty.write("\t\trom_mem_dty_b1["+ str(i) +"] = 13'd"+ str(hB_duty_b1_value[i]) +";\n") 
    ph_b_btm2_duty.write("\t\trom_mem_dty_b2["+ str(i) +"] = 13'd"+ str(hB_duty_b2_value[i]) +";\n")
    ph_b_btm2_offset.write("\t\trom_mem_dty_b2_off["+ str(i) +"] = 13'd"+ str(hB_offset_b2_value[i]) +";\n")

    ph_c_top_duty.write("\t\trom_mem_dty_t["+ str(i) +"] = 13'd"+ str(hC_duty_value[i]) +";\n")
    ph_c_top_offset.write("\t\trom_mem_dty_t_off["+ str(i) +"] = 13'd"+ str(hC_offset_value[i]) +";\n")
    ph_c_btm1_duty.write("\t\trom_mem_dty_b1["+ str(i) +"] = 13'd"+ str(hC_duty_b1_value[i]) +";\n") 
    ph_c_btm2_duty.write("\t\trom_mem_dty_b2["+ str(i) +"] = 13'd"+ str(hC_duty_b2_value[i]) +";\n")
    ph_c_btm2_offset.write("\t\trom_mem_dty_b2_off["+ str(i) +"] = 13'd"+ str(hC_offset_b2_value[i]) +";\n")  
         

    
## closing all the open files     
    
ph_a_top_duty.close()     
ph_a_top_offset.close()   
ph_a_btm2_duty.close()  
ph_a_btm2_offset.close()
ph_a_btm1_duty.close() 

ph_b_top_duty.close()     
ph_b_top_offset.close()   
ph_b_btm2_duty.close()  
ph_b_btm2_offset.close()
ph_b_btm1_duty.close() 

ph_c_top_duty.close()     
ph_c_top_offset.close()   
ph_c_btm2_duty.close()  
ph_c_btm2_offset.close()
ph_c_btm1_duty.close() 
