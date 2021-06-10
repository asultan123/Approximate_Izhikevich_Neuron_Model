%%%%%%%%%%%%%%% (A) tonic spiking REDUCED %%%%%%%%%%%%%%%%%%%%%%


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

a=0.03; b=0.25; c=-52;  d=0;

    V = -70;  u=b*V;
    VV=[];  uu=[];
    V=fi(V,1,ni+nf,nf);  
    u=fi(u,1,ni+nf,nf);
    V.fimath = F;
    u.fimath = F;
    
    tau = 0.2;  tspan = 0:tau:200;
    T1=20;
    tau = fi(0.2,1,ni+nf,nf);
    tau.fimath = F;
    for t=tspan
        if (t>T1) & (t < T1+5) 
            I=-15;
        else
            I=0;
        end;
        
        ETM1 = ETM(V,V,upper_bit_count,ni,nf);
        ETM1.fimath = F;
        
        CONST_MULT_X = ETA(bitshift(ETM1,-5),bitshift(ETM1,-7),...
            ETA_upper_bit_count,2*ni,2*nf);
        
        CONST_MULT_5 = ETA(bitshift(sign_extend(V,2*ni,2*nf),2), ...
            sign_extend(V,2*ni,2*nf),ETA_upper_bit_count,2*ni,2*nf);
        
        ADDER1 = ETA(CONST_MULT_X,CONST_MULT_5,ETA_upper_bit_count,2*ni,2*nf);

        % 15 bit adder 
        ADDER2 = I-u;
        
        ADDER3 = INT_ADD(ADDER2,140,ni+1);
         
        ADDER4 = ETA(ADDER1,ADDER3,ETA_upper_bit_count,2*ni,2*nf);
        
        CONST_MULT_tau = bitshift(ADDER4,-2);
        
        ADDER5 = truncate(CONST_MULT_tau,ni,nf,F) + V;
        
        V = ADDER5;
        
%         CONST_MULT_b = fi(V*2^-2,1,ni+nf,nf) - fi(V*2^-5,1,ni+nf,nf);
        CONST_MULT_tau = truncate(bitshift(sign_extend(V,2*ni,2*nf),-2),ni,nf,F) - ...
            truncate(bitshift(sign_extend(V,2*ni,2*nf),-5),ni,nf,F);
        
        ADDER6 = CONST_MULT_b-u;
        
%         CONST_MULT_a_t = fi(ADDER6*2^-6,1,ni+nf,nf) + fi(ADDER6*2^-8,1,ni+nf,nf);

        CONST_MULT_a = truncate(bitshift(sign_extend(ADDER6,2*ni,2*nf),-6),ni,nf,F) + ...
            truncate(bitshift(sign_extend(ADDER6,2*ni,2*nf),-8),ni,nf,F);
        
        CONST_MULT_tau = truncate(bitshift(sign_extend(V,2*ni,2*nf),-2),ni,nf,F) - ...
            truncate(bitshift(sign_extend(V,2*ni,2*nf),-5),ni,nf,F);

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
    title('(A) tonic spiking');

approx_VV = VV;