clc;
clear;
disp('program started');
sim = remApi('remoteApi');
sim.simxFinish(-1);
clientID = sim.simxStart('127.0.0.1',19999,true,true,5000,5);
while (clientID > -1)
    disp('connect to the server successfully');
    %open the simulation and define the simmulation mode
    sim.simxStartSimulation(clientID,sim.simx_opmode_oneshot);
    %When most remote API functions are called, they will be translated into commands that might travel to the server, 
    %and come back as a command reply from the server. The operation mode of a remote API function defines what exactly 
    %happens to those commands and command replies
    %simx_opmode_oneshot:clinet send a cmd and will not wait for the reply
    %from the server all the time.
    
    %initialize the motor
    [return_code11,return_handle11] = sim.simxGetObjectHandle(clientID,'lb_rot_1',sim.simx_opmode_blocking);
    [return_code12,return_handle12] = sim.simxGetObjectHandle(clientID,'lb_rot_2',sim.simx_opmode_blocking);
    [return_code13,return_handle13] = sim.simxGetObjectHandle(clientID,'lb_rot_3',sim.simx_opmode_blocking);
    [return_code21,return_handle21] = sim.simxGetObjectHandle(clientID,'lf_rot_1',sim.simx_opmode_blocking);
    [return_code22,return_handle22] = sim.simxGetObjectHandle(clientID,'lf_rot_2',sim.simx_opmode_blocking);
    [return_code23,return_handle23] = sim.simxGetObjectHandle(clientID,'lf_rot_3',sim.simx_opmode_blocking);
    [return_code31,return_handle31] = sim.simxGetObjectHandle(clientID,'rb_rot_1',sim.simx_opmode_blocking);
    [return_code32,return_handle32] = sim.simxGetObjectHandle(clientID,'rb_rot_2',sim.simx_opmode_blocking);
    [return_code33,return_handle33] = sim.simxGetObjectHandle(clientID,'rb_rot_3',sim.simx_opmode_blocking);
    [return_code41,return_handle41] = sim.simxGetObjectHandle(clientID,'rf_rot_1',sim.simx_opmode_blocking);
    [return_code42,return_handle42] = sim.simxGetObjectHandle(clientID,'rf_rot_2',sim.simx_opmode_blocking);
    [return_code43,return_handle43] = sim.simxGetObjectHandle(clientID,'rf_rot_3',sim.simx_opmode_blocking);
    
    %define the toruqe parameter of the motor
    lb_rot_1_force = 500;   lf_rot_1_force = 500;  rb_rot_1_force = 500;  rf_rot_1_force = 500;
    lb_rot_2_force = 500;   lf_rot_2_force = 500;  rb_rot_2_force = 500;  rf_rot_2_force = 500;
    lb_rot_3_force = 500;   lf_rot_3_force = 500;  rb_rot_3_force = 500;  rf_rot_3_force = 500;
    %set the torque parameter to the motor
    [return_code111] = sim.simxSetJointMaxForce(clientID,return_handle11,lb_rot_1_force,sim.simx_opmode_oneshot);
    [return_code112] = sim.simxSetJointMaxForce(clientID,return_handle12,lb_rot_2_force,sim.simx_opmode_oneshot);
    [return_code113] = sim.simxSetJointMaxForce(clientID,return_handle13,lb_rot_3_force,sim.simx_opmode_oneshot);
    [return_code211] = sim.simxSetJointMaxForce(clientID,return_handle21,lf_rot_1_force,sim.simx_opmode_oneshot);
    [return_code212] = sim.simxSetJointMaxForce(clientID,return_handle22,lf_rot_2_force,sim.simx_opmode_oneshot);
    [return_code213] = sim.simxSetJointMaxForce(clientID,return_handle23,lf_rot_3_force,sim.simx_opmode_oneshot);
    [return_code311] = sim.simxSetJointMaxForce(clientID,return_handle31,rb_rot_1_force,sim.simx_opmode_oneshot);
    [return_code312] = sim.simxSetJointMaxForce(clientID,return_handle32,rb_rot_2_force,sim.simx_opmode_oneshot);
    [return_code313] = sim.simxSetJointMaxForce(clientID,return_handle33,rb_rot_3_force,sim.simx_opmode_oneshot);
    [return_code411] = sim.simxSetJointMaxForce(clientID,return_handle41,rf_rot_1_force,sim.simx_opmode_oneshot);
    [return_code412] = sim.simxSetJointMaxForce(clientID,return_handle42,rf_rot_2_force,sim.simx_opmode_oneshot);
    [return_code413] = sim.simxSetJointMaxForce(clientID,return_handle43,rf_rot_3_force,sim.simx_opmode_oneshot);
    
    pause(1);
    time = clock;
    start_time = time(5) * 60 + time(6);
    current_time = 0;
    gait_flag = 1;%1????walk??????2????trot????
    while (current_time < 100)
        t = clock;
        current_time = t(5)*60 + t(6) - start_time;
        if (current_time < 5)
            if gait_flag == 1
                lf_x = 0.1;     rb_x = -0.1;    rf_x = 0.1;     lb_x = -0.1; 
                lf_z = -0.495;  rb_z = -0.495;  rf_z = -0.495;  lb_z = -0.495;  
            end
           
            if gait_flag == 2
                lf_x = 0.1;     rb_x = 0.1;    rf_x = -0.1;     lb_x = -0.1; 
                lf_z = -0.495;  rb_z = -0.495;  rf_z = -0.495;  lb_z = -0.495;                 
            end
         [return_code1,simulation_time1] = sim.simxGetFloatSignal(clientID,'time',sim.simx_opmode_streaming);           
        else
         [return_code2,simulation_time2] = sim.simxGetFloatSignal(clientID,'time',sim.simx_opmode_streaming);
         simulation_realtime = simulation_time2 - simulation_time1;
            switch gait_flag
                 case 1
                 T = 1;
                 time1 = simulation_realtime;
                 time2 = simulation_realtime + 0.25;
                 time3 =simulation_realtime + 0.5;
                 time4 = simulation_realtime + 0.75;
                 time1 = mod(time1,T);
                 time2 = mod(time2,T);
                 time3 = mod(time3,T);
                 time4 = mod(time4,T);
                 [lf_x,lf_z] = walkGait(time1,T);
                 [rb_x,rb_z] = walkGait(time2,T);
                 [rf_x,rf_z] = walkGait(time3,T);
                 [lb_x,lb_z] = walkGait(time4,T);
                 case 2
                 T = 0.6;
                 time1 = simulation_realtime;
                 time2 = simulation_realtime + 0.3;
                 time3 =simulation_realtime ;
                 time4 = simulation_realtime + 0.3;
                 time1 = mod(time1,T);
                 time2 = mod(time2,T);
                 time3 = mod(time3,T);
                 time4 = mod(time4,T);
                 [lf_x,lf_z] = trotGait(time1,T);
                 [rb_x,rb_z] = trotGait(time3,T);
                 [rf_x,rf_z] = trotGait(time2,T);
                 [lb_x,lb_z] = trotGait(time4,T);
          
            end
        end
        [lb_rot_1_pos,lb_rot_2_pos,lb_rot_3_pos] = inversekinematics(lb_x,-0.15,lb_z); 
        [lf_rot_1_pos,lf_rot_2_pos,lf_rot_3_pos] = inversekinematics(lf_x,-0.15,lf_z); 
        [rb_rot_1_pos,rb_rot_2_pos,rb_rot_3_pos] = inversekinematics(rb_x,-0.15,rb_z); 
        [rf_rot_1_pos,rf_rot_2_pos,rf_rot_3_pos] = inversekinematics(rf_x,-0.15,rf_z);
        [return_code121] = sim.simxSetJointTargetPosition(clientID,return_handle11,-lb_rot_1_pos,sim.simx_opmode_oneshot);
        [return_code122] = sim.simxSetJointTargetPosition(clientID,return_handle12,lb_rot_2_pos,sim.simx_opmode_oneshot);
        [return_code123] = sim.simxSetJointTargetPosition(clientID,return_handle13,lb_rot_3_pos,sim.simx_opmode_oneshot);
        [return_code221] = sim.simxSetJointTargetPosition(clientID,return_handle21,lf_rot_1_pos,sim.simx_opmode_oneshot);
        [return_code222] = sim.simxSetJointTargetPosition(clientID,return_handle22,lf_rot_2_pos,sim.simx_opmode_oneshot);
        [return_code223] = sim.simxSetJointTargetPosition(clientID,return_handle23,lf_rot_3_pos,sim.simx_opmode_oneshot);
        [return_code321] = sim.simxSetJointTargetPosition(clientID,return_handle31,-rb_rot_1_pos,sim.simx_opmode_oneshot);
        [return_code322] = sim.simxSetJointTargetPosition(clientID,return_handle32,rb_rot_2_pos,sim.simx_opmode_oneshot);
        [return_code323] = sim.simxSetJointTargetPosition(clientID,return_handle33,rb_rot_3_pos,sim.simx_opmode_oneshot);
        [return_code421] = sim.simxSetJointTargetPosition(clientID,return_handle41,rf_rot_1_pos,sim.simx_opmode_oneshot);
        [return_code422] = sim.simxSetJointTargetPosition(clientID,return_handle42,rf_rot_2_pos,sim.simx_opmode_oneshot);
        [return_code423] = sim.simxSetJointTargetPosition(clientID,return_handle43,rf_rot_3_pos,sim.simx_opmode_oneshot);

    end
    sim.simxFinish(clientID);

end
