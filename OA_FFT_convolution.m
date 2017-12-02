% load IR
[h, fs] = audioread('Hill_IR_trim.wav');
h = h(:,1);
%h = h';
%h =h(1:261644);
cut = 65536 - 500;
h = h(1:cut);
%h = h';

% load sample audio
[x, fs] = audioread('TestAudio_MitchellSpeaking_HPF.wav');
x = x(:,1);

% set variables

B = 500;
N = length(h)
M = length(x)
% find optimal K
%p = nextpow2(B + N - 1);
%K = pow2(18)
K = pow2(16);
%K = 1;

% calculate and add padding

Pad_length_B = abs(K - B);
Pad_length_h = abs(K - N);

Pad_B = zeros(1,Pad_length_B);
Pad_h = zeros(1,Pad_length_h);

h_padded = [h' Pad_h];

% calculate FFT zero padded IR
%FFT_h_padded = fftshift(fft(h_padded));
FFT_h_padded = fft(h_padded);

% create buffer
y_buffer = zeros(1, N + M - 1);

i = 1;
% Enter while loop: run algorithm while you're still looking at signal
% in a realtime situation, condition loop based on whether reverb is on/off

tic
while(i < M)
    % select input block and pad
    %segment_end_x = min(i + B - 1, M);
    segment_end_x = min(i + B - 1, M);
    x_curr = x(i:segment_end_x);
    x_curr_pad = [x_curr' Pad_B];
    
    % compute FFT
    %x_curr_FFT = fftshift(fft(x_curr_pad));
    x_curr_FFT = fft(x_curr_pad);
    
    % compute Y(x) = H(x)X(x)
    Y_i = FFT_h_padded(1:length(x_curr_pad)) .* x_curr_FFT;
    
    % do inverse fft
    %y_i = real(ifft(ifftshift(Y_i)));
    y_i = real(ifft(Y_i));
    
    % find end index
    segment_end_y = min(i + K - 1,N + M - 1);
    
    y_buffer(i:segment_end_y) = y_buffer(i:segment_end_y) + y_i(1:segment_end_y - i + 1);
    
    i = i + B;
end
toc
tic
%conv(x,h);
toc

figure(1)
plot_sound(y_buffer, fs, 1);
y_buffer_scaled = rescale_sound(y_buffer', 1);
plot_sound(y_buffer_scaled, fs, 2);
title('Audio signal after convolution with Hill IR')



% enter nested loop B samples


% zero pad to length K, where K >= B + N - 1

% compute FFT

% multiply both H(x)X(x)

% Compute IFFT of result (K point), of length B + N - 1

% overlap/add B samples into output buffer

% create audio file

% 
%   Algorithm 1 (OA for linear convolution)
% M = length of IR, L = subset length
%    Evaluate the best value of N and L (L>0, N = M+L-1 nearest to power of 2).
%    Nx = length(x);
%    H = FFT(h,N)       (zero-padded FFT)
%    i = 1
%    y = zeros(1, M+Nx-1) -- OUTPUT BUFFER
%    while i <= Nx  (Nx: the last index of x[n])
%        il = min(i+L-1,Nx)
%        yt = IFFT( FFT(x(i:il),N) * H, N)
%        k  = min(i+N-1,M+Nx-1)
%        y(i:k) = y(i:k) + yt(1:k-i+1)    (add the overlapped output blocks)
%        i = i+L
%    end