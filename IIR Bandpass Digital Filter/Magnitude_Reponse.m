% Registartion_Number = 200014B

A = 0;   % A = 0 from registration number
B = 1;   % B = 1 from registration number
C = 0;   % C = 0 from registration number

%{
Maximum passband ripple, Ap = 0.1 dB
Minimum stopband attenuation, Aa = 51 dB
Lower passband edge, Wp1 = 800 rad/s
Upper passband edge, Wp2 = 1300 rad/s
Lower stopband edge, Ws1 = 500 rad/s
Upper stopband edge, Ws2 = 1500 rad/s
Sampling frequency, Fs = 3800 rad/s
%}

Ap = 0.1 + (0.01 * A);  % Maximum passband ripple in dB
Aa = 50 + B;            % Minimum stopband attenuation in dB
Wp1 = (C * 100) + 800;  % Lower passband edge in rad/s
Wp2 = (C * 100) + 1300; % Upper passband edge in rad/s
Ws1 = (C * 100) + 500;  % Lower stopband edge in rad/s
Ws2 = (C * 100) + 1500; % Upper stopband edge in rad/s
Fs = 3800;              % Sampling frequency in rad/s

fsamp = 3800 / (2 * pi);  % Sampling frequency in Hz

% Passband and Stopband frequencies in samples/sec
% Analog specifications are in rads-1
Wp = [800 1300] / fsamp;
Ws = [500 1500] / fsamp;

% Specifications after prewarping
Wp = 2 * tan(Wp / 2) ./ (1 / fsamp);
Ws = 2 * tan(Ws / 2) ./ (1 / fsamp);

% Finding the corresponding analog filter using the Butterworth design
Rp = 0.1;  % Passband ripple in dB
Rs = 51;   % Stopband attenuation in dB
[n, Wn] = buttord(Wp, Ws, Rp, Rs, 's');  % Calculate filter order and cutoff frequencies
[num, den] = butter(n, Wn, 's');  % Design the analog Butterworth filter

% Using bilinear transform to find the filter coefficients for the digital filter
[num_d, den_d] = bilinear(num, den, fsamp);  % Bilinear transformation

% Visualizing the filter using the Filter Visualization Tool
fvtool(num_d, den_d);
