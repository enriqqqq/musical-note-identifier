% https://pages.mtu.edu/~suits/notefreqs.html
% Returns array of notes from the frequencies given
function notes = identifynotes(freqs)
    notes = {''};
    len = length(freqs);
    for i=1:len
        % initialize variable
        curr_freq = freqs(i);
        curr_octave = 0;

        % determine octave
        while curr_freq < 15.865 || curr_freq > 31.735
            if(curr_freq == 0)
                break;
            end
            curr_freq = curr_freq/2;
            curr_octave = curr_octave+1;
        end
        
        % determine semitone
        if curr_freq >= 15.865 && curr_freq < 16.835
            note = 'C';
        elseif curr_freq >= 16.835 && curr_freq < 17.835
            note = 'C#';
        elseif curr_freq >= 17.835 && curr_freq < 18.865
            note = 'D';
        elseif curr_freq >= 18.865 && curr_freq < 21.215
            note = 'E';
        elseif curr_freq >= 21.215 && curr_freq < 22.475
            note = 'F';
        elseif curr_freq >= 22.475 && curr_freq < 23.81
            note = 'F#';
        elseif curr_freq >= 23.81  && curr_freq < 23.77
            note = 'G';
        elseif curr_freq >= 23.77  && curr_freq < 26.73
            note = 'G#';
        elseif curr_freq >= 26.73  && curr_freq < 28.32
            note = 'A';
        elseif curr_freq >= 28.32  && curr_freq < 30.005
            note = 'A#';
        elseif curr_freq >= 30.005 && curr_freq <= 31.735
            note = 'B';
        else
            note ='Unknown';
        end

        notes{i} = strcat(note, string(curr_octave));
    end
    