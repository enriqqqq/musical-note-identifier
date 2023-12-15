% Returns frequency of each notes in an array

function f = getnotefreqs(data, divs, Fs, mode)
    len = length(divs);
    f = zeros(1,1);
    for i=1:len/2
       curr_note = data(divs(2*i-1):divs(2*i));
       curr_note = zeropadtopow2(curr_note);
       if mode == 1
           % use HPS
           f(i) = hps(curr_note, Fs, i);
       elseif mode == 2
           % use max amplitude frequency
           n = length(curr_note);
           curr_fft = abs(fft_new(curr_note));
           curr_fft = curr_fft(1:fix(n/2)+1);
           [~, I] = max(curr_fft);
           f(i) = I*Fs/n;
       end
    end
