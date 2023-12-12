% Get each note's time (sample) interval
% Returns an array with even amount of elements (pairs)
% divs = [n0, n1, n2, n3] 
% where n0 - n1 is the first note's time interval
% n2 - n3 is the second note's time interval

function divs = getnotebins(data)
    thresup = 0.2 * max(data);      % 20% of maximum value
    thresdown = 0.02 * max(data);   % 0.2% of maximum value
    len = length(data);
    divs = zeros(1,2);              % pre-allocation
    quiet = 1;
    j=1;
    for i=1:len
        if quiet == 1
            if(abs(data(i)) > thresup)
                divs(j) = i;
                j = j+1;
                quiet = 0;
            end
        else
            if(abs(data(i)) < thresdown)
               divs(j) = i;
               j = j+1;
               quiet = 1;
            end
        end
    end
