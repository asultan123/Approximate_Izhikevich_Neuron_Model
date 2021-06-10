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

 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% MAE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
range = -100:0.1:30;
exact_parabula = 0.04*range.^2+5*range+140;
approx_parabula = [];
for i = range
    V = fi(i,1,ni+nf,nf);
    
        TEM1 = TEM(V,V,F);
        
        CONST_MULT_X = ETA(bitshift(TEM1,-5),bitshift(TEM1,-7),...
            ETA_upper_bit_count,2*ni,2*nf);
        
        CONST_MULT_5 = ETA(bitshift(sign_extend(V,2*ni,2*nf),2), ...
            sign_extend(V,2*ni,2*nf),ETA_upper_bit_count,2*ni,2*nf);
        
        ADDER1 = ETA(CONST_MULT_X,CONST_MULT_5,ETA_upper_bit_count,2*ni,2*nf);
        
        ADDER3 = INT_ADD(ADDER1,137,ni+2);
               
        approx_parabula = [approx_parabula ADDER3];
end

MAE = double(abs((sum(abs(exact_parabula))-sum(abs(approx_parabula)))/length(exact_parabula)));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ERRp %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

min_point_fi = fi(-65,1,ni+nf,nf);
min_point = -65;

exact_min_point = abs(0.04*min_point^2+5*min_point+140);

ETM1 = ETM(min_point_fi,min_point_fi,upper_bit_count,ni,nf);
ETM1.fimath = F;

CONST_MULT_X = ETA(ETM1*2^-5,ETM1*2^-7,ETA_upper_bit_count,2*ni,2*nf);

CONST_MULT_5 = ETA(min_point_fi*2^2, min_point_fi,ETA_upper_bit_count,2*ni,2*nf);

ADDER1 = ETA(CONST_MULT_X,CONST_MULT_5,ETA_upper_bit_count,2*ni,2*nf);

ADDER3 = INT_ADD(ADDER1,140,ni+2);

ERRp = abs(ADDER3) - abs(exact_min_point);


