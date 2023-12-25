clc; clear; close;
[y,Fs] = audioread("audio_files\MultipleNotes_1.wav");
Ts = 1/Fs;
[~, cols] = size(y);

if cols == 1 % single channel (mono)
    audio = y;
else % multiple channels
    % convert to mono
    audio = mean(y,2);
end

% convert to mono from stereo and pad data
audio = zeropadtopow2(audio);
abs_audio = abs(audio); % get absolute value
t = 0:Ts:Ts*(length(audio)-1); % get whole audio time interval

% Smooth data
WINDOW_SIZE = 1000;
smoothed_abs_audio = smoothdata(abs_audio, 'gaussian', WINDOW_SIZE);

% Plot time domain representation
subplot(2,1,1);
plot(t, abs_audio, ...
     t, smoothed_abs_audio);

legend("Abs(Y) mono", ...
       "Smoothed Abs(Y) mono");
title('Time Domain Representation');
xlabel('Time (s)');
ylabel('Amplitude');

% Plot frequency domain representation
subplot(2,1,2);
N = length(audio);
frequencies = (-Fs/2):(Fs/N):(Fs/2)-(Fs/N);
X = fftshift(fft_new(audio)/N); % Compute and normalize the FFT
plot(abs(frequencies), abs(X));

title('Frequency Domain Representation');
xlabel('Frequency (Hz)');
ylabel('Magnitude');

% Display the plot
sgtitle('Time and Frequency Domain Representations of Audio File');

% Get each note's time (sample) interval
divs = getnotebins(smoothed_abs_audio);

% Get each note's frequency
f = getnotefreqs(audio, divs, Fs);

% Get each note's semitone
notes = identifynotes(f);

% Display Results
header_str = sprintf('%-18s | %-4s | %s', 'Seconds', 'Note', 'Frequency');
disp(header_str);

for i=1:size(notes,2)
    curr_t_lowlim = divs(2*i-1)*Ts;
    curr_t_uplim = divs(2*i)*Ts;
    curr_note = notes{i};
    curr_freq = f(i);
    curr_interval_str = sprintf('%.4f - %.4f', curr_t_lowlim, curr_t_uplim);
    fprintf('%-18s | %-4s | %.4f\n', curr_interval_str, curr_note, curr_freq);
end
