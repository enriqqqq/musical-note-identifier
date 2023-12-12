% td = 0:1/4:0.75;
% d = sin(2*pi*td);
% 
% j = fft(d)'
% l = fft_new(d)
% 
% if(j == l)
%     disp('true');
% else
%     disp('false');
% end

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

notes = {};
notes{1} = strcat(noteRanges{1,1}, string(0));
notes{2} = 'E';
notes
size(notes,2)
