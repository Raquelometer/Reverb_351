[sound, Fs] = audioread('kick.wav');

filtered_sound = sound;

z1_right = 0;
z1_left = 0;

fc = 250;

wc = 2.*pi.*fc./Fs;

alpha = 2 + cos(wc);

b1 = alpha - sqrt(alpha.^2 - 1);

a0 = 1 - b1;

%db = 10.^(a1/20);


for i = 1:size(sound)
    
    xn = sound(i, 1);
    
    yn_1 = z1_left;
    
    yn = a0.*xn - b1.*yn_1;
    
    z1_left = yn;
    
    filtered_sound(i, 1) = yn;
    
end


for i = 1:size(sound)
    
    xn = sound(i, 2);
    
    yn_1 = z1_right;
    
    yn = a0.*xn - b1.*yn_1;
    
    z1_right = yn;
    
    filtered_sound(i, 2) = yn;
    
end

audiowrite('new_kick.wav', filtered_sound, Fs);