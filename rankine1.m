
function rankine1()

%Simple Simulation of Rankine Power Cycle


p1=44;       %pressure at turbine inlet (MPa)
p2=10;     %pressure at turbine outlet(MPa)
t1=500;      %temperature at turbine inlet(Kelvin)
tsat=XSteam('Tsat_p',p1);    % saturation temperature at p1
h1=XSteam('h_pT',p1,t1);     % specific enthalpy at turbine inlet 
s1=XSteam('s_pT',p1,t1);     % specific entropy at turbine inlet
s2=s1;                       % sp. entropy at turbine exist equal to the sp. entropy at turbine inlet
sf2=XSteam('sL_p',p2);       % saturated liquid entropy at p2
sg2=XSteam('sV_p',p2);       % saturated steam entropy at p2

x2=s2-sf2/sg2-sf2;           % dryness fraction

if x2==1
    h2=XSteam('hV_p',p2);
    t2=Xsteam('Tsat_p',p2);
    hf2=XSteam('hL_p',p2);
elseif x2>1
    h2=XSteam('h_ps',p2,s2);
    t2=XSteam('Tsat_p',p2);
    hf2=XSteam('hL_p',p2);
else
    t2=XSteam('T_ps',p2,s2);
    hf2=XSteam('hL_p',p2);
    hg2=XSteam('hV_p',p2);
    h2=hf2+x*(hg2-hf2);
end
p3=p2;    % pressure at pump inlet
t3=t2;    % temperature at pump inlet
s3=sf2;   % entropy at pump inlet
h3=hf2;   %  sp. enthalpy t pump inlet
s4=s3;    % sp. entropy at pump outlet
p4=p1;    
cP=XSteam('Cp_ps',p4,s4);   % specific heat capacity at constant pressure
cV=XSteam('Cv_ps',p4,s4);   % specific heat capacity at constant volume
ac=cP/cV;                   % specific heat ratio
h4=XSteam('h_ps',p4,s4);    % sp. enthalpy at pump outlet
t4=t3*(p4/p3)^((ac-1)/ac);  %  temperature at pump outlet
t5=tsat;
h5=XSteam('hL_p',p1);      % sp. saturated liquid enthalpy at p1
s5=XSteam('sL_p',p1);      % sp. saturated liquid entropy at p1
t6=t5;
h6=XSteam('hV_p',p1);      % sp. saturated steam enthalpy at p1 
s6=XSteam('sV_p',p1);      % sp. saturated steam entropy at p1


t=linspace(10,374,500);    % temperature array

for i=1:length(t)
    s(i)=XSteam('sL_t',t(i));
    S(i)=XSteam('sV_t',t(i));
end

a=linspace(tsat,t1,500);
for i=1:length(a)
    d(i)=XSteam('s_pt',p1,a(i));
end

figure(1);
title('Rankine Power cycle____Entropy v/s Temperature'); 
plot(s,t);
hold on;
plot(S,t);
plot([s1,s2],[t1,t2]);
plot([s2,s3],[t2,t3]);
plot([s3,s4],[t3,t4]);
plot([s5,s4],[t5,t4]);
plot([s5,s6],[t5,t6]);
plot(d,a);
xlim auto;
ylim auto;
xlabel('Entropy')
ylabel('Temperature');
