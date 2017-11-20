% Function for plotting audio signal vs time
function[] = plot_sound(y, fs, fig_num, title)

dt = 1/fs;
t = linspace(0, length(y)/fs, length(y));

figure(fig_num)
plot(t,y')
title(title)
xlabel('time (s)')
ylable('amplitude')


end