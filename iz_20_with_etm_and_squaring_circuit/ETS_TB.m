clear;
%%%%%%%%%%%%%%% Instantiate link with modelsim %%%%%%%%%%%%%%%%%%%%%%
% 
squaring_circuit = hdlcosim_squaring_circuit_8bit;
launch_hdl_simulator_squaring_circuit_8bit;

timeout = 450;
processid = pingHdlSim(timeout);
% Check if Modelsim is ready for Cosimulation.
assert(ischar(processid),['Timeout: Modelsim took more than ', num2str(timeout),' seconds to setup,please increase the timeout in ''pingHdlSim''']);

%%%%%%%%%%%%%%% TEST BENCH %%%%%%%%%%%%%%%%%%%%%%

res = [];
range = [0];
while range(end)<128
    range = [range range(end)+rand()];
end
range = range.*-1;

for i = range
    res = [res fi(ETS(i,squaring_circuit,8,8),1,32,16)];
end
plot(res);

%%%%%%%%%%%%%%% TERMINATE MODEL SIM INSTANCE %%%%%%%%%%%%%%%%%%%%%%

clear squaring_circuit;
