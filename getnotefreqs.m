% Returns frequency of each notes in an array
function f = getnotefreqs(data, divs, Fs)
    len = length(divs);
    f = zeros(1,1);
    for i=1:len/2
       curr_note = data(divs(2*i-1):divs(2*i));
       n = length(curr_note);
       curr_fft = abs(fft(curr_note));
       curr_fft = curr_fft(1:fix(n/2)+1);

       [~, I] = max(curr_fft);
       f(i) = I*Fs/n;
    end