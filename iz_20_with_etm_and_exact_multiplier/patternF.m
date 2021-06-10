clear;

%%%%%%%%%%%%%%%% (F) spike freq. adapt EXACT %%%%%%%%%%%%%%%%%%%%%%%%
subplot(1,2,1)  
a=0.01; b=0.2;  c=-65;  d=8;
V=-70;  u=b*V;
VV=[];  uu=[];
tau = 0.25; tspan = 0:tau:85;
T1=tspan(end)/10;
for t=tspan
    if (t>T1) 
        I=30;
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
title('(F) spike freq. adapt EXACT');

exact_VV =VV;

%%%%%%%%%%%%%%%% (F) spike freq. adapt APPROX %%%%%%%%%%%%%%%%%%%%%%%%

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

a=0.01; b=0.2;  c=-65;  d=8;

a=fi(2^-7 + 2^-9,1,ni+nf,nf);
a.fimath = F;
b=fi(2^-2 - 2^-5,1,ni+nf,nf);
b.fimath = F;


X = fi(2^-5 + 2^-7 ,1,ni+nf,nf);
X.fimath = F;

    V=-70;  u=b*V;
    VV=[];  uu=[];
    V=fi(V,1,ni+nf,nf);  
    u=fi(u,1,ni+nf,nf);
    V.fimath = F;
    u.fimath = F;
    tau = 0.25; tspan = 0:tau:85; %extended it from 85 to 100
    T1=tspan(end)/10;
    
        tau = fi(0.25,1,ni+nf,nf);
    tau.fimath = F;
    for t=tspan
        if (t>T1) 
            I=fi(30,1,ni+nf,nf);
        else
            I=fi(0,1,ni+nf,nf);
        end;

        ETM1 = ETM(V,V,upper_bit_count,ni,nf);
        ETM1.fimath = F;
        
%         CONST_MULT_X = ETA(ETM1*2^-5,ETM1*2^-7,ETA_upper_bit_count,2*ni,2*nf);
        CONST_MULT_X = ETA(bitshift(ETM1,-5),bitshift(ETM1,-7),...
            ETA_upper_bit_count,2*ni,2*nf);
        
%         CONST_MULT_5 = ETA(V*2^2, V,ETA_upper_bit_count,2*ni,2*nf);
        CONST_MULT_5 = ETA(bitshift(sign_extend(V,2*ni,2*nf),2), ...
            sign_extend(V,2*ni,2*nf),ETA_upper_bit_count,2*ni,2*nf);
        
        ADDER1 = ETA(CONST_MULT_X,CONST_MULT_5,ETA_upper_bit_count,2*ni,2*nf);
                
        ADDER2 = I-u;
        
        ADDER3 = INT_ADD(ADDER2,140,ni+1);
        
        ADDER4 = ETA(ADDER1,ADDER3,ETA_upper_bit_count,2*ni,2*nf);
        
        CONST_MULT_tau = bitshift(ADDER4,-2);
        
%         ADDER5 = fi(ADDER4*tau,1,ni+nf,nf)+V;
        ADDER5 = truncate(CONST_MULT_tau,ni,nf,F) + V;
        
        V = ADDER5;
        
%         CONST_MULT_b = fi(V*2^-2,1,ni+nf,nf) - fi(V*2^-5,1,ni+nf,nf);
        CONST_MULT_b = truncate(bitshift(sign_extend(V,2*ni,2*nf),-2),ni,nf,F) - ...
            truncate(bitshift(sign_extend(V,2*ni,2*nf),-5),ni,nf,F);
        
        ADDER6 = CONST_MULT_b-u;
        
%         CONST_MULT_a = fi(ADDER6*2^-7,1,ni+nf,nf) + fi(ADDER6*2^-9,1,ni+nf,nf);
        CONST_MULT_a = truncate(bitshift(sign_extend(ADDER6,2*ni,2*nf),-7),ni,nf,F) + ...
            truncate(bitshift(sign_extend(ADDER6,2*ni,2*nf),-9),ni,nf,F);
        
        CONST_MULT_tau = bitshift(CONST_MULT_a,-2);
        
%         ADDER7 = fi(CONST_MULT_a*tau,1,ni+nf,nf)+u;
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
    title('(F) spike freq. adapt APPROX');
    
    approx_VV = VV;
    
%%%%%%%%%%%%%%% ERROR ANALYSIS %%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% RSEE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

RSEE = abs((sum(abs(exact_VV.^2))-sum(abs(approx_VV.^2)))/sum(exact_VV.^2))*100;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ERRt %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

exact_spikes = find(exact_VV == 30);
approx_spikes = find(approx_VV == 30);
delta_exact = exact_spikes - [exact_spikes(2:end) 0]; delta_exact = delta_exact(1:end-1);
delta_approx = approx_spikes - [approx_spikes(2:end) 0]; delta_approx = delta_approx(1:end-1);
ERRt = abs((delta_approx-delta_exact)./delta_approx);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% MERRt %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

MERRt = sum(ERRt)/length(ERRt)*100;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

row_names = {'RSEE', 'MERRt'};
error_F = [RSEE;MERRt];
table(error_F,'RowNames',row_names)

% table(error_A,error_C,error_E,error_F,'RowNames',row_names)