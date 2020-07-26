function rankine()


% I will start Simulation of rankine cycle in later stage. 
% Now I am going to make a structure of thermodynamics equation which are required to find the efficiency of the power plant with different temperature and pressure.

p1=8;     % pressure of the pump input(MPa)
p2=80;       % pressure of the boiler input(MPa)
p3=p2;       % pressure of the turbine input
             % tempture of pump input
t3= 700;     % superheated temperature of turbine input(K)

boiler_eff=0.3  ;
turbine_eff=0.9  ;
pump_eff= 0.8  ;
mecha_eff=0.75 ;
gen_eff=0.9  ;
mass_steam=2.3 ;
m=mass_steam  ;

%saturation temperature at P1 pressure
sat_t1=XSteam('Tsat_p',p1);
%enthalpy of saturated liquid at p1,pump input
hL1=XSteam('hL_p',p1);
%specific volume of saturated liquid at p1, pump input
vL1=XSteam('vL_p',p1);
% ideal pump work
w_pump_isentropic=m*(p2-p1)*vL1;
%actual pump work
w_pump_actual=w_pump_isentropic*pump_eff;
fprintf('w_pump_actual=%4.2f KW',w_pump_actual);
%actual enthalpy of pump output
h2a=hL1+w_pump_actual;
%saturation temperature at P2 pressure
sat_t2=XSteam('Tsat_p',p2);
%boiler output or turbine input enthalpy at p3,t3
h3=XSteam('h_pT',p3,t3);
% output of boiler
boiler_heat= m*(h3-h2a);
%heat required for producing steam or input to boiler
boiler_heat_input= boiler_heat/boiler_eff;
fprintf('\nboiler_heat_input=%4.2f KW',boiler_heat_input);
%entropy of superheated steam at p3,h3 or turbine input entropy
s3=XSteam('s_ph',p3,h3);
% if isentropic condition at turbine output
s4=s3;
%entropy of saturated liquid at p1
sL1=XSteam('sL_p',p1);
%entropy of saturated vapour at p1
sV1=XSteam('sV_p',p1);
%dryness fraction at output of turbine at ideal or isentropic condition
x_dryness=(s4-sL1)/(sV1-sL1);
fprintf('\ndryness_fraction=%4.3f',x_dryness);
%actual x
%enthalpy of saturated vapour at p1
hV1=XSteam('hV_p',p1);
%ideal output of turbine output
h4=hL1+x_dryness*(hV1-hL1);
%ideal turbine work
w_turbine_isentropic=m*(h3-h4);
%actual turbine work
w_turbine_actual= w_turbine_isentropic/turbine_eff;
%actual enthalpy of turbine output
h4a=h3+w_turbine_actual;
%net work produced
w_net=w_turbine_actual-w_pump_actual;
fprintf('\nw_net=%4.2f KW',w_net);

%actual dryness fraction
x_dryness_actual=(h4a-hL1)/(hV1-hL1);
if x_dryness_actual>1
    fprintf('\nx_dryness_actual is supersaturated =%4.3f',x_dryness_actual);
elseif (0.85<x_dryness_actual) && (x_dryness_actual<1)
    fprintf('\nx_dryness_actual is wet steam=%4.3f',x_dryness_actual);
elseif x_dryness_actual<0.85
    fprintf('\nerrosion of turbine blades for x_dryness_actual=%4.3f',x_dryness_actual);
elseif x_dryness_actual==1
    fprintf('\nx_dryness_actual is saturated steam=%4.3f',x_dryness_actual);
end

efficiency_plant= w_net/boiler_heat;
fprintf('\nefficiency_plant=%4.2f',efficiency_plant);

steam_rate= 3600*m/w_net;
fprintf('\nsteam_rate=%4.5f',steam_rate);
heat_rate=boiler_heat/w_net;
fprintf('\nheatrate=%4.2f',heat_rate);

shaft_power= w_net/mecha_eff;
fprintf('\nshaft_power=%4.2f KW',shaft_power);

electrical_power=shaft_power/gen_eff;
fprintf('\nelectrical_power=%4.2f KW',electrical_power);








