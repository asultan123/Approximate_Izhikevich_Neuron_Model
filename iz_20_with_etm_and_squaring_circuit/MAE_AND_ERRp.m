%%%%%%%%%%%%%%% Instantiate link with modelsim %%%%%%%%%%%%%%%%%%%%%%

squaring_circuit = hdlcosim_squaring_circuit_8bit;
launch_hdl_simulator_squaring_circuit_8bit;

timeout = 450;
processid = pingHdlSim(timeout);
% Check if Modelsim is ready for Cosimulation.
assert(ischar(processid),['Timeout: Modelsim took more than ', num2str(timeout),' seconds to setup,please increase the timeout in ''pingHdlSim''']);

ERRp_array = [];
MAE_array = [];
for const = 140:150

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% MAE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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

    range = -100:0.1:30;
    exact_parabula = 0.04*range.^2+5*range+140;
    approx_parabula = [];
    for i = range
        V = fi(i,1,ni+nf,nf);

            ETM1 = fi(ETS(V,squaring_circuit,8,8),1,32,16);
            ETM1.fimath = F;

            CONST_MULT_X = ETA(bitshift(ETM1,-5),bitshift(ETM1,-7),...
                ETA_upper_bit_count,2*ni,2*nf);

            CONST_MULT_5 = ETA(bitshift(sign_extend(V,2*ni,2*nf),2), ...
                sign_extend(V,2*ni,2*nf),ETA_upper_bit_count,2*ni,2*nf);

            ADDER1 = ETA(CONST_MULT_X,CONST_MULT_5,ETA_upper_bit_count,2*ni,2*nf);

            ADDER3 = INT_ADD(ADDER1,const,ni+2);

            approx_parabula = [approx_parabula ADDER3];
    end

    MAE = double(abs((sum(abs(exact_parabula))-sum(abs(approx_parabula)))/length(exact_parabula)))
    MAE_array = [MAE_array MAE];
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ERRp %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    min_point_fi = fi(-65,1,ni+nf,nf);
    min_point = -65;

    exact_min_point = abs(0.04*min_point^2+5*min_point+140);

    ETM1 = fi(ETS(min_point,squaring_circuit,8,8),1,32,16);
    ETM1.fimath = F;

    CONST_MULT_X = ETA(ETM1*2^-5,ETM1*2^-7,ETA_upper_bit_count,2*ni,2*nf);

    CONST_MULT_5 = ETA(min_point_fi*2^2, min_point_fi,ETA_upper_bit_count,2*ni,2*nf);

    ADDER1 = ETA(CONST_MULT_X,CONST_MULT_5,ETA_upper_bit_count,2*ni,2*nf);

    ADDER3 = INT_ADD(ADDER1,const,ni+2);

    ERRp = abs(ADDER3) - abs(exact_min_point)
    ERRp_array = [ERRp_array ERRp];
end
%%%%%%%%%%%%%%% TERMINATE MODEL SIM INSTANCE %%%%%%%%%%%%%%%%%%%%%%

clear squaring_circuit;