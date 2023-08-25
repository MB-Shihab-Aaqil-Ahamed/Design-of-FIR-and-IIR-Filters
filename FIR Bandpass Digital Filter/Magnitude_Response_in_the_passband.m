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

% Design FIR filter using Kaiser window method
fcuts = [Ws1 Wp1 Wp2 Ws2];            % Cutoff frequencies in rad/s
mags = [0 1 0];                        % Magnitude response at each band
devs = [10^(-Aa/20) 10^(-Ap/20) 10^(-Aa/20)];  % Deviation for each band
[n, Wn, beta, ftype] = kaiserord(fcuts, mags, devs, Fs);  % Filter order and Kaiser window parameters
n = n + rem(n, 2);                     % Ensure the filter order is odd for Type I FIR filter
hh = fir1(n, Wn, ftype, kaiser(n+1, beta));  % Generate the filter coefficients

% Frequency response analysis
[H, f] = freqz(hh, 1);  % Calculate the frequency response of the filter

% Normalized passband edge frequencies
Wp1_normalized = Wp1 / (Fs/2);
Wp2_normalized = Wp2 / (Fs/2);

% Plot the magnitude response within the specified passband
figure;
plot(f/pi, 20*log10(abs(H)))
title("Magnitude Response of the passband")
ax = gca;
ax.YLim = [-0.04 0.04];
ax.XLim = [Wp1_normalized Wp2_normalized];
xlabel('Normalized Frequency (\times\pi rad/sample)')
ylabel('Magnitude (dB)')
