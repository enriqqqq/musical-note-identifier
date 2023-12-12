% https://pages.mtu.edu/~suits/notefreqs.html
% Returns array of notes
function notes = identifynotes(freqs)
    notes = {''};
    noteRanges = {
        'C', 16.35;
        'C#', 17.32;
        'D', 18.35;
        'D#', 19.45;
        'E', 20.60;
        'F', 21.83;
        'F#', 23.12;
        'G', 24.50;
        'G#', 25.96;
        'A', 27.50;
        'A#', 29.14;
        'B', 30.87;
    };
    
    len = length(freqs);
    for i=1:len
        curr_freq = freqs(i);
        curr_octave = 0;
        while curr_freq < 16.35 || curr_freq > 30.87
            curr_freq = curr_freq/2;
            curr_octave = curr_octave+1;
        end

        lower_notewidth = (noteRanges {2,2} - noteRanges{1,2})/2;
 
        % find corresponding note
        for j=1:size(noteRanges,1) % 12 semitones
            upper_notewidth = (noteRanges{j+1,2} - noteRanges{j,2})/2;
            
            lower_l = noteRanges{j,2} - lower_notewidth;
            upper_l = noteRanges{j,2} + upper_notewidth;
            
            % note found
            if curr_freq >= lower_l && curr_freq < upper_l
                notes{i} = strcat(noteRanges{j,1}, string(curr_octave));
                break;
            end
            
            % if not found go to next semitone
            lower_notewidth = upper_notewidth;
        end
    end