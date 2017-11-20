
function[IR] = getIR(originalSineSweepName, measuredSineSweepName, cutoff)
    %% Read in audio

    [originalSineSweep, ~] = audioread(originalSineSweepName);
    [measuredSineSweep, ~] = audioread(measuredSineSweepName);
    measuredSineSweep = measuredSineSweep(:, 1);

    %% Reverse original sine sweep

    reversedSineSweep = (flip(originalSineSweep));

    %% Convolve reversed sine sweep with measured sine sweep

    IR = conv(reversedSineSweep, measuredSineSweep);
    
    %% cuttof at 130000
    IR = IR(cutoff:end);
end