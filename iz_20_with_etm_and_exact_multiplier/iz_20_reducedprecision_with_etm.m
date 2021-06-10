%   This MATLAB file generates figure 1 in the paper by 
%               Izhikevich E.M. (2004) 
%   Which Model to Use For Cortical Spiking Neurons? 
%   use MATLAB R13 or later. November 2003. San Diego, CA 

function [ global_v ] = iz_20_reducedprecision_with_etm( integer_precision, fraction_precision, upper_bit_count)

     pattern = containers.Map;
    pattern('A')=1;
    pattern('B')=2;
    pattern('C')=3;
    pattern('D')=4;
    pattern('E')=5;
    pattern('F')=6;
    pattern('G')=7;
    pattern('H')=8;
    pattern('I')=9;
    pattern('J')=10;
    pattern('K')=11;
    pattern('L')=12;
    pattern('M')=13;
    pattern('N')=14;
    pattern('O')=15;
    pattern('P')=16;
    pattern('Q')=17;
    pattern('R')=18;
    pattern('S')=19;
    pattern('T')=20;
    
    ni = integer_precision;
    nf = fraction_precision;

    F = fimath('RoundingMethod', 'Floor', ...
     'OverflowAction', 'Saturate', ...
     'ProductMode', 'SpecifyPrecision', ...
     'ProductWordLength', 2*(ni+nf), ...
     'ProductFractionLength', 2*nf, ...
     'SumMode', 'SpecifyPrecision', ...
     'SumWordLength', 2*(ni+nf), ...
     'SumFractionLength', 2*nf, ...
     'CastBeforeSum', true);
     
%     F.ProductMode = 'SpecifyPrecision';
%     F.ProductWordLength = ni+nf;
%     F.ProductFractionLength = nf;
%     F.SumMode = 'SpecifyPrecision';
%     F.SumWordLength = ni+nf;
%     F.SumFractionLength = nf;

    global_v = -2000*ones(20,1601);

    %%%%%%%%%%%%%%% (A) tonic spiking %%%%%%%%%%%%%%%%%%%%%%

    subplot(5,4,1) 
    a=0.02; b=0.2;  c=-65;  d=6;
    V = -70;  u=b*V;
    VV=[];  uu=[];
    V=fi(V,1,ni+nf,nf);  
    u=fi(u,1,ni+nf,nf);
    V.fimath = F;
    u.fimath = F;
    tau = 0.25; tspan = 0:tau:100;
    T1=tspan(end)/10;
    for t=tspan
        if (t>T1) 
            I=14;
        else
            I=0;
        end;
        V = V + tau*(0.04*ETM(V,V,upper_bit_count,ni,nf)+5*V+140-u+I);
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
    title('(A) tonic spiking');
    global_v(pattern('A'),1:length(VV)) = VV;

    %%%%%%%%%%%%%%%%%% (B) phasic spiking %%%%%%%%%%%%%%%%%%%%%%%%%
    subplot(5,4,2)%  
    a=0.02; b=0.25; c=-65;  d=6;
    V=-64; u=b*V;ttt
    VV=[];  uu=[];
    V=fi(V,1,ni+nf,nf);  
    u=fi(u,1,ni+nf,nf);
    V.fimath = F;
    u.fimath = F;
    tau = 0.25;tspan = 0:tau:200;
    T1=20;
    for t=tspan
        if (t>T1) 
            I=0.5;
        else
            I=0;
        end;
        V = V + tau*(0.04*ETM(V,V,upper_bit_count,ni,nf)+5*V+140-u+I);
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
    title('(B) phasic spiking');
    global_v(pattern('B'),1:length(VV)) = VV;


    %%%%%%%%%%%%%% (C) tonic bursting %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    subplot(5,4,3)  
    a=0.02; b=0.2;  c=-50;  d=2;
    V=-70;  u=b*V;
%     Vtest = -70;
%     utest = b*Vtest;
    VV=[];  uu=[];
    V=fi(V,1,ni+nf,nf);  
    u=fi(u,1,ni+nf,nf);
    V.fimath = F;
    u.fimath = F;
    tau = 0.25; tspan = 0:tau:220;
    T1=22;
    for t=tspan
        if (t>T1) 
            I=15;
        else
            I=0;
        end;
%         Vtest = Vtest + tau*(0.04*Vtest^2+5*Vtest+140-u+I);
%         utest = utest + tau*a*(b*Vtest-utest);
        V = V + tau*(0.04*ETM(V,V,upper_bit_count,ni,nf)+5*V+140-u+I);
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
    title('(C) tonic bursting');
    global_v(pattern('C'),1:length(VV)) = VV;

    %%%%%%%%%%%%%%% (D) phasic bursting %%%%%%%%%%%%%%%%%%%%%%%%%%
    subplot(5,4,4)   
    a=0.02; b=0.25; c=-55;  d=0.05;
    V=-64;  u=b*V;
    VV=[];  uu=[];
    V=fi(V,1,ni+nf,nf);  
    u=fi(u,1,ni+nf,nf);
    V.fimath = F;
    u.fimath = F;
    tau = 0.2;  tspan = 0:tau:200;
    T1=20;
    for t=tspan
        if (t>T1) 
            I=0.6;
        else
            I=0;
        end;
        V = V + tau*(0.04*ETM(V,V,upper_bit_count,ni,nf)+5*V+140-u+I);
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
    title('(D) phasic bursting');
    global_v(pattern('D'),1:length(VV)) = VV;


    %%%%%%%%%%%%%%% (E) mixed mode %%%%%%%%%%%%%%%%%%%%%%%%%
    subplot(5,4,5) 
    a=0.02; b=0.2;  c=-55;  d=4;
    V=-70;  u=b*V;
    VV=[];  uu=[];
    V=fi(V,1,ni+nf,nf);  
    u=fi(u,1,ni+nf,nf);
    V.fimath = F;
    u.fimath = F;
    tau = 0.25; tspan = 0:tau:160;
    T1=tspan(end)/10;
    for t=tspan
        if (t>T1) 
            I=10;
        else
            I=0;
        end;
        V = V + tau*(0.04*ETM(V,V,upper_bit_count,ni,nf)+5*V+140-u+I);
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
    title('(E) mixed mode');
    global_v(pattern('E'),1:length(VV)) = VV;


    %%%%%%%%%%%%%%%% (F) spike freq. adapt %%%%%%%%%%%%%%%%%%%%%%%%
    subplot(5,4,6)  
    a=0.01; b=0.2;  c=-65;  d=8;
    V=-70;  u=b*V;
    VV=[];  uu=[];
    V=fi(V,1,ni+nf,nf);  
    u=fi(u,1,ni+nf,nf);
    V.fimath = F;
    u.fimath = F;
    tau = 0.25; tspan = 0:tau:85;
    T1=tspan(end)/10;
    for t=tspan
        if (t>T1) 
            I=30;
        else
            I=0;
        end;
        V = V + tau*(0.04*ETM(V,V,upper_bit_count,ni,nf)+5*V+140-u+I);
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
    title('(F) spike freq. adapt');
    global_v(pattern('F'),1:length(VV)) = VV;


    %%%%%%%%%%%%%%%%% (G) Class 1 exc. %%%%%%%%%%%%%%%%%%%%%%%%%%
    subplot(5,4,7)  
    a=0.02; b=-0.1; c=-55; d=6;
    V=-60; u=b*V;
%     Vtest = V;
%     utest = u;
    VV=[]; uu=[];
    V=fi(V,1,ni+nf,nf);  
    u=fi(u,1,ni+nf,nf);
    V.fimath = F;
    u.fimath = F;
    tau = 0.25; tspan = 0:tau:300;
    T1=30;
    for t=tspan
        if (t>T1) 
            I=(0.075*(t-T1)); 
        else
            I=0;
        end;
                
        V = V + tau*(0.04*ETM(V,V,upper_bit_count,ni,nf)+4.1*V+108-u+I);
        u = u + tau*a*(b*V-u);
        if V > 30
            VV(end+1)=30;
            V = c;
            u = u + d;
        else
            VV(end+1)=V;
        end;
        
        uu(end+1)=u;
        
%         if Vtest > 30
%             Vtest_t = [Vtest_t 30];
%             Vtest = c;
%             utest = utest+d;
%         else
%             Vtest_t = [Vtest_t Vtest];
%         end
%         
%         error = abs(V-Vtest);
%         error_t = [error_t error];

    end;
    plot(tspan,VV,[0 T1 max(tspan) max(tspan)],-90+[0 0 20 0]);
    axis([0 max(tspan) -90 30])
    axis off;
    title('(G) Class 1 excitable');
    global_v(pattern('G'),1:length(VV)) = VV;

    %%%%%%%%%%%%%%%%%% (H) Class 2 exc. %%%%%%%%%%%%%%%%%%%%%%%%%%
    subplot(5,4,8)  
    a=0.2;  b=0.26; c=-65;  d=0;
    V=-64;  u=b*V;
    VV=[];  uu=[];
    V=fi(V,1,ni+nf,nf);  
    u=fi(u,1,ni+nf,nf);
    V.fimath = F;
    u.fimath = F;
    tau = 0.25; tspan = 0:tau:300;
    T1=30;
    for t=tspan
        if (t>T1) 
            I=-0.5+(0.015*(t-T1)); 
        else
            I=-0.5;
        end;
        V = V + tau*(0.04*ETM(V,V,upper_bit_count,ni,nf)+5*V+140-u+I);
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
    plot(tspan,VV,[0 T1 max(tspan) max(tspan)],-90+[0 0 20 0]);
    axis([0 max(tspan) -90 30])
    axis off;
    title('(H) Class 2 excitable');
    global_v(pattern('H'),1:length(VV)) = VV;


    %%%%%%%%%%%%%%%%% (I) spike latency %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    subplot(5,4,9) 
    a=0.02; b=0.2;  c=-65;  d=6;
    V=-70;  u=b*V;
    VV=[];  uu=[];
    V=fi(V,1,ni+nf,nf);  
    u=fi(u,1,ni+nf,nf);
    V.fimath = F;
    u.fimath = F;
    tau = 0.2; tspan = 0:tau:100;
    T1=tspan(end)/10;
    for t=tspan
        if t>T1 & t < T1+3 
            I=7.04;
        else
            I=0;
        end;
        V = V + tau*(0.04*ETM(V,V,upper_bit_count,ni,nf)+5*V+140-u+I);
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
    plot(tspan,VV,[0 T1 T1 T1+3 T1+3 max(tspan)],-90+[0 0 10 10 0 0]);
    axis([0 max(tspan) -90 30])
    axis off;
    title('(I) spike latency');
    global_v(pattern('I'),1:length(VV)) = VV;


    %%%%%%%%%%%%%%%%% (J) subthresh. osc. %%%%%%%%%%%%%%%%%%%%%%%%%%%
    subplot(5,4,10) 
    a=0.05; b=0.26; c=-60;  d=0;
    V=-62;  u=b*V;
    VV=[];  uu=[];
    V=fi(V,1,ni+nf,nf);  
    u=fi(u,1,ni+nf,nf);
    V.fimath = F;
    u.fimath = F;
    tau = 0.25; tspan = 0:tau:200;
    T1=tspan(end)/10;
    for t=tspan
        if (t>T1) & (t < T1+5) 
            I=2;
        else
            I=0;
        end;
        V = V + tau*(0.04*ETM(V,V,upper_bit_count,ni,nf)+5*V+140-u+I);
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
    plot(tspan,VV,[0 T1 T1 (T1+5) (T1+5) max(tspan)],-90+[0 0 10 10 0 0],...
          tspan(220:end),-10+20*(VV(220:end)-mean(VV)));
    axis([0 max(tspan) -90 30])
    axis off;
    title('(J) subthreshold osc.');
    global_v(pattern('J'),1:length(VV)) = VV;


    %%%%%%%%%%%%%%%%%% (K) resonator %%%%%%%%%%%%%%%%%%%%%%%%
    subplot(5,4,11) 
    a=0.1;  b=0.26; c=-60;  d=-1;
    V=-62;  u=b*V;
    VV=[];  uu=[];
    V=fi(V,1,ni+nf,nf);  
    u=fi(u,1,ni+nf,nf);
    V.fimath = F;
    u.fimath = F;
    tau = 0.25; tspan = 0:tau:400;
    T1=tspan(end)/10;
    T2=T1+20;
    T3 = 0.7*tspan(end);
    T4 = T3+40;
    for t=tspan
        if ((t>T1) & (t < T1+4)) | ((t>T2) & (t < T2+4)) | ((t>T3) & (t < T3+4)) | ((t>T4) & (t < T4+4)) 
            I=0.65;
        else
            I=0;
        end;
        V = V + tau*(0.04*ETM(V,V,upper_bit_count,ni,nf)+5*V+140-u+I);
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
    plot(tspan,VV,[0 T1 T1 (T1+8) (T1+8) T2 T2 (T2+8) (T2+8) T3 T3 (T3+8) (T3+8) T4 T4 (T4+8) (T4+8) max(tspan)],-90+[0 0 10 10 0 0 10 10 0 0 10 10 0 0 10 10 0 0]);
    axis([0 max(tspan) -90 30])
    axis off;
    title('(K) resonator');
    global_v(pattern('K'),1:length(VV)) = VV;

    %%%%%%%%%%%%%%%% (L) integrator %%%%%%%%%%%%%%%%%%%%%%%%
    subplot(5,4,12) 
    a=0.02; b=-0.1; c=-55; d=6;
    V=-60; u=b*V;
    r = -60;
    VV=[];  uu=[];
    V=fi(V,1,ni+nf,nf);  
    u=fi(u,1,ni+nf,nf);
    V.fimath = F;
    u.fimath = F;
    tau = 0.25; tspan = 0:tau:100;
    T1=tspan(end)/11;
    T2=T1+5;
    T3 = 0.7*tspan(end);
    T4 = T3+10;
    for t=tspan
        if ((t>T1) & (t < T1+2)) | ((t>T2) & (t < T2+2)) | ((t>T3) & (t < T3+2)) | ((t>T4) & (t < T4+2)) 
            I=9;
        else
            I=0;
        end;
        V = V + tau*(0.04*ETM(V,V,upper_bit_count,ni,nf)+4.1*V+108-u+I);
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
    plot(tspan,VV,[0 T1 T1 (T1+2) (T1+2) T2 T2 (T2+2) (T2+2) T3 T3 (T3+2) (T3+2) T4 T4 (T4+2) (T4+2) max(tspan)],-90+[0 0 10 10 0 0 10 10 0 0 10 10 0 0 10 10 0 0]);
    axis([0 max(tspan) -90 30])
    axis off;
    title('(L) integrator');
    global_v(pattern('L'),1:length(VV)) = VV;

    %%%%%%%%%%%%%%%%% (M) rebound spike %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    subplot(5,4,13)  
    a=0.03; b=0.25; c=-60;  d=4;
    V=-64;  u=b*V;
    VV=[];  uu=[];
    V=fi(V,1,ni+nf,nf);  
    u=fi(u,1,ni+nf,nf);
    V.fimath = F;
    u.fimath = F;
    tau = 0.2;  tspan = 0:tau:200;
    T1=20;
    for t=tspan
        if (t>T1) & (t < T1+5) 
            I=-15;
        else
            I=0;
        end;
        V = V + tau*(0.04*ETM(V,V,upper_bit_count,ni,nf)+5*V+140-u+I);
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
    plot(tspan,VV,[0 T1 T1 (T1+5) (T1+5) max(tspan)],-85+[0 0 -5 -5 0 0]);
    axis([0 max(tspan) -90 30])
    axis off;
    title('(M) rebound spike');
    global_v(pattern('M'),1:length(VV)) = VV;

    %%%%%%%%%%%%%%%%% (N) rebound burst %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    subplot(5,4,14)  
    a=0.03; b=0.25; c=-52;  d=0;
    V=-64;  u=b*V;
    VV=[];  uu=[];
    V=fi(V,1,ni+nf,nf);  
    u=fi(u,1,ni+nf,nf);
    V.fimath = F;
    u.fimath = F;
    tau = 0.2;  tspan = 0:tau:200;
    T1=20;
    for t=tspan
        if (t>T1) & (t < T1+5) 
            I=-15;
        else
            I=0;
        end;
        V = V + tau*(0.04*ETM(V,V,upper_bit_count,ni,nf)+5*V+140-u+I);
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
    plot(tspan,VV,[0 T1 T1 (T1+5) (T1+5) max(tspan)],-85+[0 0 -5 -5 0 0]);
    axis([0 max(tspan) -90 30])
    axis off;
    title('(N) rebound burst');
    global_v(pattern('N'),1:length(VV)) = VV;

    %%%%%%%%%%%%%%%%% (O) thresh. variability %%%%%%%%%%%%%%%%%%%%%%%%%%
    subplot(5,4,15)  
    a=0.03; b=0.25; c=-60;  d=4;
    V=-64;  u=b*V;
    VV=[];  uu=[];
    V=fi(V,1,ni+nf,nf);  
    u=fi(u,1,ni+nf,nf);
    V.fimath = F;
    u.fimath = F;
    tau = 0.25; tspan = 0:tau:100;
    for t=tspan
       if ((t>10) & (t < 15)) | ((t>80) & (t < 85)) 
            I=1;
        elseif (t>70) & (t < 75)
            I=-6;
        else
            I=0;
        end;
        V = V + tau*(0.04*ETM(V,V,upper_bit_count,ni,nf)+5*V+140-u+I);
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
    plot(tspan,VV,[0 10 10 15 15 70 70 75 75 80 80 85 85 max(tspan)],...
              -85+[0 0  5  5  0  0  -5 -5 0  0  5  5  0  0]);
    axis([0 max(tspan) -90 30])
    axis off;
    title('(O) thresh. variability');
    global_v(pattern('O'),1:length(VV)) = VV;


    %%%%%%%%%%%%%% (P) bistability %%%%%%%%%%%%%%%%%%%%%%%%%%
    subplot(5,4,16) 
    a=0.1;  b=0.26; c=-60;  d=0;
    V=-61;  u=b*V;
    VV=[];  uu=[];
    V=fi(V,1,ni+nf,nf);  
    u=fi(u,1,ni+nf,nf);
    V.fimath = F;
    u.fimath = F;
    tau = 0.25; tspan = 0:tau:300;
    T1=tspan(end)/8;
    T2 = 216;
    for t=tspan
        if ((t>T1) & (t < T1+5)) | ((t>T2) & (t < T2+5)) 
            I=1.3;
        else
            I=0.145;
        end;
        V = V + tau*(0.04*ETM(V,V,upper_bit_count,ni,nf)+5*V+140-u+I);
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
    plot(tspan,VV,[0 T1 T1 (T1+5) (T1+5) T2 T2 (T2+5) (T2+5) max(tspan)],-90+[0 0 10 10 0 0 10 10 0 0]);
    axis([0 max(tspan) -90 30])
    axis off;
    title('(P) bistability');
    global_v(pattern('P'),1:length(VV)) = VV;


    %%%%%%%%%%%%%% (Q) DAP %%%%%%%%%%%%%%%%%%%%%%%%%%
    subplot(5,4,17) 
    a=1;  b=0.2; c=-60;  d=-21;
    V=-70;  u=b*V;
    VV=[];  uu=[];
    V=fi(V,1,ni+nf,nf);  
    u=fi(u,1,ni+nf,nf);
    V.fimath = F;
    u.fimath = F;
    tau = 0.1; tspan = 0:tau:50;
    T1 = 10;
    for t=tspan
         if abs(t-T1)<1 
            I=20;
        else
            I=0;
        end;
        V = V + tau*(0.04*ETM(V,V,upper_bit_count,ni,nf)+5*V+140-u+I);
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
    plot(tspan,VV,[0 T1-1 T1-1 T1+1 T1+1 max(tspan)],-90+[0 0 10 10 0 0]);
    axis([0 max(tspan) -90 30])
    axis off;
    title('(Q) DAP         ');
    global_v(pattern('Q'),1:length(VV)) = VV;



    %%%%%%%%%%%%%% (R) accomodation %%%%%%%%%%%%%%%%%%%%%%%%%%
    subplot(5,4,18) 
    a=0.02;  b=1; c=-55;  d=4;
    V=-65;  u=-16;
    VV=[];  uu=[];
    V=fi(V,1,ni+nf,nf);  
    u=fi(u,1,ni+nf,nf);
    V.fimath = F;
    u.fimath = F;
    II=[];
    tau = 0.5; tspan = 0:tau:400;
    for t=tspan
        if (t < 200)
            I=t/25;
        elseif t < 300
            I=0;
        elseif t < 312.5
            I=(t-300)/12.5*4;
        else
            I=0;
        end;
        V = V + tau*(0.04*ETM(V,V,upper_bit_count,ni,nf)+5*V+140-u+I);
        u = u + tau*a*(b*(V+65));

        if V > 30
            VV(end+1)=30;
            V = c;
            u = u + d;
        else
            VV(end+1)=V;
        end;
        uu(end+1)=u;
        II(end+1)=I;
    end;
    plot(tspan,VV,tspan,II*1.5-90);
    axis([0 max(tspan) -90 30])
    axis off;
    title('(R) accomodation');
    global_v(pattern('R'),1:length(VV)) = VV;

    %%%%%%%%%%%%%% (S) inhibition induced spiking %%%%%%%%%%%%%%%%%%%%%%%%%%
    subplot(5,4,19) 
    a=-0.02;  b=-1; c=-60;  d=8;
    V=-63.8;  u=b*V;
    VV=[];  uu=[];
    V=fi(V,1,ni+nf,nf);  
    u=fi(u,1,ni+nf,nf);
    V.fimath = F;
    u.fimath = F;
    tau = 0.5; tspan = 0:tau:350;
    for t=tspan
           if (t < 50) | (t>250)
            I=80;
        else
            I=75;
        end;
        V = V + tau*(0.04*ETM(V,V,upper_bit_count,ni,nf)+5*V+140-u+I);
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
    plot(tspan,VV,[0 50 50 250 250 max(tspan)],-80+[0 0 -10 -10 0 0]);
    axis([0 max(tspan) -90 30])
    axis off;
    title('(S) inh. induced sp.');
    global_v(pattern('S'),1:length(VV)) = VV;

    %%%%%%%%%%%%%% (T) inhibition induced bursting %%%%%%%%%%%%%%%%%%%%%%%%%%
    subplot(5,4,20) 
    a=-0.026;  b=-1; c=-45;  d=-2;
    V=-63.8;  u=b*V;
    VV=[];  uu=[];
    V=fi(V,1,ni+nf,nf);  
    u=fi(u,1,ni+nf,nf);
    V.fimath = F;
    u.fimath = F;
    tau = 0.5; tspan = 0:tau:350;
    for t=tspan
           if (t < 50) | (t>250)
            I=80;
        else
            I=75;
        end;
        
        V = V + tau*(0.04*ETM(V,V,upper_bit_count,ni,nf)+5*V+140-u+I);
        u = u + tau*a*(b*V-u);
        if V > 30
            VV(end+1)=30;
            V = c;
            u = u+d;
        else
            VV(end+1)=V;
        end;
        uu(end+1)=u;
    end;
    plot(tspan,VV,[0 50 50 250 250 max(tspan)],-80+[0 0 -10 -10 0 0]);
    axis([0 max(tspan) -90 30])
    axis off;
    title('(T) inh. induced brst.');
    global_v(pattern('T'),1:length(VV)) = VV;

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    set(gcf,'Units','normalized','Position',[0.3 0.1 0.6 0.8]);

end