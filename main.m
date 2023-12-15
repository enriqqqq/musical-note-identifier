[y,Fs] = audioread("audio_files\Clarinet-SFZ-20190818\samples\D3.wav"); % https://freepats.zenvoid.org/
Ts = 1/Fs;

% convert to mono from stereo and pad data
mono_y = mean(y,2);
mono_y = zeropadtopow2(mono_y);
abs_mono_y = abs(mono_y); % get absolute value

t = 0:Ts:Ts*(length(mono_y)-1); % get whole audio time interval

% Smooth data
WINDOW_SIZE = 1000;
smoothed_abs_mono_y = smoothdata(abs_mono_y, 'gaussian', WINDOW_SIZE);

% Plot time domain representation
subplot(2,1,1);
plot(t, abs_mono_y, ...
     t, smoothed_abs_mono_y);

legend("Abs(Y) mono", ...
       "Smoothed Abs(Y) mono");
title('Time Domain Representation');
xlabel('Time (s)');
ylabel('Amplitude');

% Plot frequency domain representation
subplot(2,1,2);
N = length(mono_y);
frequencies = (-Fs/2):(Fs/N):(Fs/2) - (Fs/N);
X = fftshift(fft_new(mono_y)/N); % Compute and normalize the FFT
Xbi = fftshift(fft(mono_y)/N); % Built-in FFT
plot(abs(frequencies), abs(X), abs(frequencies), abs(Xbi));

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

% Display Results
disp('Seconds         | Note');
for i=1:size(notes,2)
    curr_t_lowlim = divs(2*i-1)*Ts;
    curr_t_uplim = divs(2*i)*Ts;
    curr_note = notes{i};
    fprintf('%.4f - %.4f | %s\n', curr_t_lowlim, curr_t_uplim, curr_note);
end


