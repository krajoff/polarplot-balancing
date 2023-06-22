function [amplitude, theta] = ampthetafromz(z)
% Amplitude and phase of complex
    amplitude = abs(z);
    theta = rad2deg(angle(z));
    fprintf('���������: %3.0f, ����: %3.0f', amplitude, theta);
end