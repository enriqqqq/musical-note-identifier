% Returns frequency of each notes in an array
function f = getnotefreqs(data, divs, Fs)
    len = length(divs);
    f = zeros(1,1);
    for i=1:len/2
       curr_note = data(divs(2*i-1):divs(2*i));
       curr_note = zeropadtopow2(curr_note);
       n = length(curr_note);
       frequencies = (-Fs/2):(Fs/n):(Fs/2) - (Fs/n);
       X = fftshift(fft(curr_note)/n); % Compute and normalize the FFT
       frequencies = abs(frequencies);
       [~,I] = max(X);
       f(i) = frequencies(I);
       plot(abs(frequencies), abs(X));
       % curr_fft = abs(fft_new(curr_note));
       % curr_fft = curr_fft(1:fix(n/2)+1);
       % [~, I] = max(curr_fft);
       % f(i) = I*Fs/n;
    end