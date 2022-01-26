clc;
clear;
%the first step is to initialize the communication%
disp('Program started');
% sim=remApi('remoteApi','extApi.h'); % using the header (requires a compiler)
sim=remApi('remoteApi'); % using the prototype file (remoteApiProto.m)
sim.simxFinish(-1); % just in case, close all opened connections
clientID=sim.simxStart('127.0.0.1',19999,true,true,5000,5);%if connect successfully,this function will return a ClinetID number(0)
%if failed to connect, it will return -1
disp(clientID);

%determine whether the client connect to the server:
if (clientID > -1)
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
    
    %define the position parameter of the motor, the unit should be radian
                   lf_rot_1_pos = 0;  rb_rot_1_pos = 0;  rf_rot_1_pos = 0;
                   lf_rot_2_pos = 0;  rb_rot_2_pos = 0;  rf_rot_2_pos = 0;
                   lf_rot_3_pos = 0;  rb_rot_3_pos = 0;  rf_rot_3_pos = 0;
    %set the position paramter of the motor
    
    %%%%%%%%%
%     posx = 0; posy = 0; posz = -0.7;
%     alpha = 0; beta = 0; gama = 0;
    pause(1);%delay one second
    while(1)
     %set the position paramter of the motor
%         [lf_AB,lb_AB,rf_AB,rb_AB] = bodypose(posx,posy,posz,alpha,beta,gama);
%         [lb_rot_1_pos,lb_rot_2_pos,lb_rot_3_pos] = inversekinematics(lb_AB(1),lb_AB(2),lb_AB(3)); 
%         [lf_rot_1_pos,lf_rot_2_pos,lf_rot_3_pos] = inversekinematics(lf_AB(1),lf_AB(2),lf_AB(3)); 
%         [rb_rot_1_pos,rb_rot_2_pos,rb_rot_3_pos] = inversekinematics(rb_AB(1),rb_AB(2),rb_AB(3)); 
%         [rf_rot_1_pos,rf_rot_2_pos,rf_rot_3_pos] = inversekinematics(rf_AB(1),rf_AB(2),rf_AB(3));
        [lb_rot_1_pos,lb_rot_2_pos,lb_rot_3_pos] = inversekinematics(-0.1,-0.3,-0.632); 
        [lf_rot_1_pos,lf_rot_2_pos,lf_rot_3_pos] = inversekinematics(-0.1,-0.3,-0.632); 
        [rb_rot_1_pos,rb_rot_2_pos,rb_rot_3_pos] = inversekinematics(-0.1,-0.3,-0.632); 
        [rf_rot_1_pos,rf_rot_2_pos,rf_rot_3_pos] = inversekinematics(-0.1,-0.3,-0.632); 
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
end
sim.simxFinish(clientID);
