function f = hps(audio, Fs, note_index)
    % Apply a window function (e.g., Hamming window)
    windowed_audio = audio .* hamming(length(audio));
    
    % Calculate the magnitude spectrum
    spectrum = abs(fft_new(windowed_audio));
    spectrum = spectrum(1:fix(length(spectrum)/2)+1);
    
    % Get peaks that is higher than threshold
    a_threshold = max(spectrum) * 0.37; % 37% of max magnitude

    [peaks_mag, ~] = findpeaks(spectrum);
    peaks = peaks_mag(peaks_mag >= a_threshold);

    % Determine the amount of times to down sample
    peaks_amount = length(peaks) + 1;
    if(peaks_amount < 9)
        max_downsample = peaks_amount;
    else
        max_downsample = 8;
    end
    
    figure;
    sub_r = max_downsample + 1;
    subplot(sub_r, 1, 1);
    plot(spectrum);

    % Initialize the HPS spectrum and down sampled spectrum
    hps_spectrum = spectrum;
    
    % Compute Harmonic Product Spectrum
    for i = 2:max_downsample
        % down sample by i
        downsampled_spectrum = downsample(spectrum, i);

        % pad extra zero to match length
        downsampled_spectrum = [downsampled_spectrum;...
            zeros(length(hps_spectrum)...
            - length(downsampled_spectrum), 1)];
        
        % product
        hps_spectrum = hps_spectrum .* downsampled_spectrum;

        subplot(sub_r,1,i);
        plot(downsampled_spectrum);
    end
    
    subplot(sub_r,1,sub_r);
    plot(hps_spectrum);
    title('Product Result')

    str_title = sprintf("HPS of Note %d", note_index);
    sgtitle(str_title);

    % Find the index of the maximum value in the HPS spectrum
    [~, max_index] = max(hps_spectrum);
    
    % Convert the index to frequency (in Hz)
    f = Fs * max_index / length(audio);
end
