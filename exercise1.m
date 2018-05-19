clearvars
clc

% Solar influx energy density.
S = 1423; % W/m^2.

% Time in eclipse.
t_eclipse = 22; % minutes.

% Time in sunlight.
t_sunlight = 68; % minutes.

% Cyclic variation factor.
Fc = 0.97; % When Earth's position from periphelion is 180 degrees.

% Secular degradation.
Fs = 0.7 + 0.3 * exp(-5 * 365 / 1000); % For t = 5 years.

% Solar cell efficiency (Assumption).
n = 0.28;

% Maximum sun angle incidence for near-Earth mission.
phi_s = 10; % QUESTION: HOW DO WE DETERMINE THIS VALUE?

% Power required in daylight.
p_sunlight = 330; % Watt.

% Power required in eclipse
p_eclipse = 100; % Watt.

%---------------------------------%
% 5. Required Capacity of Battery %
%---------------------------------%
% Battery is needed during eclipse.
% Power required in eclipse.
Pe = 100; % Watt.

% Battery average discharge voltage.
U_bus = 27.1; % Volt.
% QUESTION: Do we need to multiple U_bus with the transmission efficiency 
% between the battery and the load (90%)??

% Depth of charge.
dod = 0.20; % percent.

% Current yielding capability.
I = Pe / U_bus; % Amps.

% Battery's usable capacity.
C_used = I * (t_eclipse / 60) % Ah.

% Battery's rated capacity:
C_rated = C_used / dod % Ah.


%---------------------%
% 4. Solar Array Area %
%---------------------%
% 1.4 What is the required area of the solar arrays?

% The solar array must produce enough energy during the time t_sunlight
% to sustain the satellite in sunlight and also to replenish the energy
% taken from the battery during t_eclipse. 
%
% The total array output is therefore:
%   p_array = p_sunlight + p_battery
%   p_array * t_sunlight = p_sunlight * t_sunlight + p_battery * t_eclipse
%   p_array = p_sunlight + p_battery * (t_eclipse / t_sunlight)

% Calculate the necessary power p_battery to recharge the battery.
% The factor 1.2 comes about because of battery efficiency considerations.
% i.e. the recharge voltage needs to be approximately 20% higher than the
% discharge (bus) voltage:
p_battery = 1.2 * U_bus * C_used / (t_eclipse / 60);
% QUESTION: Do we need to multiple U_bus with the transmission efficiency 
% between the battery and the load (90%)??

% Can now calculate the total array output:
p_array = p_sunlight + p_battery * (t_eclipse / t_sunlight / 60); % Watt.

% Area of the array:
A = p_array / (S * n * Fs * Fc * cosd(phi_s)) % m^2.

%-----------------%
% 6. Battery Mass %
%-----------------%
% Energy Yields for Ni-H2, Li-Ion, and Ni-Cd.
u_nih2 = 60; % Wh/kg
u_liion = 120; % Wh/kg
u_nicd = 40; % Wh/kg

% Calculate battery masses in kg.
% Ni-H2
m_nih2 = (Pe * t_eclipse / 60) / (u_nih2 * dod)

% Li-Ion
m_liion = (Pe * t_eclipse / 60) / (u_liion * dod)

% Ni-Cd
m_nicd = (Pe * t_eclipse / 60) / (u_nicd * dod)