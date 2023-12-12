[y,Fs] = audioread("cdepiano.wav"); % read audio
mono_y = mean(y,2); % convert to mono from stereo
Ts = 1/Fs;
t = 0:Ts:Ts*(length(mono_y)-1); % get whole audio time interval
abs_mono_y = abs(mono_y); % get absolute value

% https://www.mathworks.com/help/signal/ug/signal-smoothing.html
% Smooth data
WINDOW_SIZE = 1000;
smoothed_abs_mono_y = smoothdata(abs_mono_y, 'gaussian', WINDOW_SIZE);

% Plot time domain representation
subplot(2,1,1);
plot(t,abs_mono_y, ...
     t, smoothed_abs_mono_y);

legend("Abs(Y) mono", ...
       "Smoothed Abs(Y) mono");
title('Time Domain Representation');
xlabel('Time (s)');
ylabel('Amplitude');

% Plot frequency domain representation using built-in fft
subplot(2,1,2);
N = length(mono_y);
frequencies = (-Fs/2):(Fs/N):(Fs/2) - (Fs/N);
X = fftshift(fft(mono_y)/N); % Compute and normalize the FFT
plot(abs(frequencies), abs(X));
title('Frequency Domain Representation');
xlabel('Frequency (Hz)');
ylabel('Magnitude');

% Display the plot
sgtitle('Time and Frequency Domain Representations of Audio File');

% Get each note's time (sample) interval
divs = getnotebins(smoothed_abs_mono_y);

% Get each note's frequency
f = getnotefreqs(mono_y, divs, Fs);

% Get each note's semitone
notes = identifynotes(f);

disp('Seconds         | Note');
for i=1:size(notes,2)
    curr_t_lowlim = divs(2*i-1)*Ts;
    curr_t_uplim = divs(2*i)*Ts;
    curr_note = notes{i};
    fprintf('%.4f - %.4f | %s\n', curr_t_lowlim, curr_t_uplim, curr_note);
end


