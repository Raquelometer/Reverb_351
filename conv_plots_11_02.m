% Script for testing out convolution and generating  
% plots for group assignment, due 11.2

% Read in impulse response and plot
[h Fs] = audioread('MessyRoom_Impulse.wav');
plot_sound(h, Fs, 1);
xlabel('time (s)')
title('IR Room 1')


% Read in test audio and plot
[y Fs] = audioread('TestAudio_MitchellSpeaking.wav');
plot_sound(y, Fs, 2);
xlabel('time (s)')
title('Test Audio')

% Convolve left channel and plot
y_conv_L = conv(y(:,1), h(:,1));
plot_sound(y_conv_L, Fs, 3);

% Convolve right channel 
y_conv_R = conv(y(:,2), h(:,2));


Y_CONV = [y_conv_L y_conv_R];

% Rescale convolved signal and plot
Y_CONV_SC = rescale_sound(Y_CONV);
plot_sound(Y_CONV_SC, Fs, 5);
xlabel('time (s)')
title('IR and Test Audio: Convolved and Scaled')
audiowrite('TestAudio_convolved_MessyRoom.wav', Y_CONV_SC, Fs);