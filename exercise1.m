clearvars
clc

% Solar constant.
S = 1423; % W/m^2

% Cyclic variation factor.
Fc = 0.97; % When Earth's position from periphelion is 180 degrees.

% Secular degradation.
Fs = 0.7 + 0.3 * exp(-5 * 365 / 1000); % For t = 5 years.

% Solar cell efficiency (Assumption).
n = 0.28;

% Maximum sun angle incidence for near-Earth mission.
% phi = ?

% Maximum power required (during sunlight)
p_max = 330; % W

% 1.4 What is the required area of the solar arrays? 
A = p_max / (S * n * Fs * Fc * cos(phi_s));