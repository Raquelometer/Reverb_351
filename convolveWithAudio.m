%% Read in test audio

[testAudio, ~] = audioread(testAudioName);

%% Record maximum volume 
volume = max(testAudio);

%% Convolve test audio with the IR

audioOut = conv(testAudio(:, 1), IR);


%% Set maximum volume to what it was before convolution
audioOut = audioOut ./ max(audioOut) .* volume;