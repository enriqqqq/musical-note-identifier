% Returns frequency of each notes in an array

function f = getnotefreqs(data, divs, Fs)
    len = length(divs);
    f = zeros(1,1);
    for i=1:len/2
       curr_note = data(divs(2*i-1):divs(2*i));
       curr_note = zeropadtopow2(curr_note);
       f(i) = hps(curr_note, Fs, i);
    end
