clear;
%%%%%%%%%%%%%%% Instantiate link with modelsim %%%%%%%%%%%%%%%%%%%%%%

squaring_circuit = hdlcosim_squaring_circuit_8bit;
launch_hdl_simulator_squaring_circuit_8bit;

timeout = 450;
processid = pingHdlSim(timeout);
% Check if Modelsim is ready for Cosimulation.
assert(ischar(processid),['Timeout: Modelsim took more than ', num2str(timeout),' seconds to setup,please increase the timeout in ''pingHdlSim''']);

%%%%%%%%%%%%%%% (E) mixed mode EXACT %%%%%%%%%%%%%%%%%%%%%%%%%
subplot(1,2,1) 
a=0.02; b=0.2;  c=-55;  d=4;
V=-70;  u=b*V;
VV=[];  uu=[];
tau = 0.25; tspan = 0:tau:1000;
T1=tspan(end)/10;
for t=tspan
    if (t>T1) 
        I=10;
    else
        I=0;
    end;
    V = V + tau*(0.04*V^2+5*V+140-u+I);
    u = u + tau*a*(b*V-u);
    if V > 30
        VV(end+1)=30;
        V = c;
        u = u + d;
    else
        VV(end+1)=V;
    end;
    uu(end+1)=u;
end;
plot(tspan,VV,[0 T1 T1 max(tspan)],-90+[0 0 10 10]);
axis([0 max(tspan) -90 30])
axis off;
title('(E) mixed mode EXACT');

exact_VV = VV;

%%%%%%%%%%%%%%% (E) mixed mode APPROX %%%%%%%%%%%%%%%%%%%%%%%%%

subplot(1,2,2);

ni = 8;
nf = 8;
upper_bit_count = 8;


ETA_upper_bit_count = 18;

F = fimath('RoundingMethod', 'Nearest', ...
 'OverflowAction', 'Wrap', ...
 'ProductMode', 'SpecifyPrecision', ...
 'ProductWordLength', 2*(ni+nf), ...
 'ProductFractionLength', 2*nf, ...
 'SumMode', 'SpecifyPrecision', ...
 'SumWordLength', ni+nf, ...
 'SumFractionLength', nf, ...
 'CastBeforeSum', true);



a=0.02; b=0.2;  c=-55;  d=4;

a=fi(2^-6 + 2^-8,1,ni+nf,nf);
a.fimath = F;
b=fi(2^-2 - 2^-5,1,ni+nf,nf);
b.fimath = F;
X = fi(2^-5 + 2^-7,1,ni+nf,nf);
X.fimath = F;

V=-70;  u=b*V;
VV=[];  uu=[];
V=fi(V,1,ni+nf,nf);  
u=fi(u,1,ni+nf,nf);
V.fimath = F;
u.fimath = F;
tau = 0.25; tspan = 0:tau:1000; 
T1=tspan(end)/10;

tau = fi(0.25,1,ni+nf,nf);
tau.fimath = F;
for t=tspan
    if (t>T1) 
        I=fi(7,1,ni+nf,nf);
    else
        I=fi(0,1,ni+nf,nf);
    end;

        ETM1 = fi(ETS(V,squaring_circuit,8,8),1,32,16);
        ETM1.fimath = F;
        
        CONST_MULT_X = ETA(bitshift(ETM1,-5),bitshift(ETM1,-7),...
            ETA_upper_bit_count,2*ni,2*nf);
        
        CONST_MULT_5 = ETA(bitshift(sign_extend(V,2*ni,2*nf),2), ...
            sign_extend(V,2*ni,2*nf),ETA_upper_bit_count,2*ni,2*nf);
        
        ADDER1 = ETA(CONST_MULT_X,CONST_MULT_5,ETA_upper_bit_count,2*ni,2*nf);
        
        ADDER2 = I-u;
        
        ADDER3 = INT_ADD(ADDER2,145,ni+1);
        
        ADDER4 = ETA(ADDER1,ADDER3,ETA_upper_bit_count,2*ni,2*nf);
        
        CONST_MULT_tau = bitshift(ADDER4,-2);
        
        ADDER5 = truncate(CONST_MULT_tau,ni,nf,F) + V;
        
        V = ADDER5;
        
        CONST_MULT_b = truncate(bitshift(sign_extend(V,2*ni,2*nf),-2),ni,nf,F) - ...
            truncate(bitshift(sign_extend(V,2*ni,2*nf),-5),ni,nf,F);
        
        ADDER6 = CONST_MULT_b-u;
        
        CONST_MULT_a = truncate(bitshift(sign_extend(ADDER6,2*ni,2*nf),-6),ni,nf,F) + ...
            truncate(bitshift(sign_extend(ADDER6,2*ni,2*nf),-8),ni,nf,F);
        
        CONST_MULT_tau = bitshift(CONST_MULT_a,-2);
        
        ADDER7 = CONST_MULT_tau+u;
        
        u = ADDER7;

if V > 30
        VV(end+1)=30;
        V = fi(c,1,ni+nf,nf,F);
        u = INT_ADD(u,d,ni+1);
        u.fimath = F;
    else
        VV(end+1)=V;
    end;
    uu(end+1)=u;
end;
plot(tspan,VV,[0 T1 T1 max(tspan)],-90+[0 0 10 10]);
axis([0 max(tspan) -90 30])
axis off;
title('(E) mixed mode APPROX');

approx_VV = VV;

%%%%%%%%%%%%%%% TERMINATE MODEL SIM INSTANCE %%%%%%%%%%%%%%%%%%%%%%

clear squaring_circuit;

%%%%%%%%%%%%%%% ERROR ANALYSIS %%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% RSEE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

RSEE = abs((sum(abs(exact_VV.^2))-sum(abs(approx_VV.^2)))/sum(exact_VV.^2))*100;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ERRt %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% exact_spikes = find(exact_VV == 30);
% approx_spikes = find(approx_VV == 30);
% delta_exact = exact_spikes - [exact_spikes(2:end) 0]; delta_exact = delta_exact(1:end-1);
% delta_approx = approx_spikes - [approx_spikes(2:end) 0]; delta_approx = delta_approx(1:end-1);
% ERRt = abs((delta_approx-delta_exact)./delta_approx);
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% MERRt %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% MERRt = sum(ERRt)/length(ERRt)*100;
MERRt = 0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

row_names = {'RSEE', 'MERRt'};
error_E = [RSEE;MERRt];
table(error_E,'RowNames',row_names)

save('approx_E','approx_VV');
save('exact_E','exact_VV');
