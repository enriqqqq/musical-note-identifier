% This function pads zero to samples which doesn't have a length of 2^n
% Doesn't do anything if the sample have length of 2^n
% Only accepts column vector as input

function y = zeropadtopow2(samples)
    N = length(samples);
    
    if(mod(log2(N),2) ~= 0)
        next_pow2 = 2^nextpow2(N);
        padded_samples = cat(1, samples, zeros(next_pow2 - N,1));
    else
        padded_samples = samples;
    end

    y = padded_samples;
end
