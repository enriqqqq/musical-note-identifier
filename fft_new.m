% Implementation of FFT assuming that sample's length is a power of 2
% https://www.youtube.com/watch?v=h7apO7q16V0&list=WL&index=52

function retr = fft_new(samples)
    % recursion base case
    N = length(samples);
    if(N==1)
        retr = samples;
        return;
    end

    M = fix(N/2);
    
    % pre-allocate for speed
    Xeven = zeros(M,1);
    Xodd = zeros(M,1);
    
    % divide even and odd through recursion
    for i=1:M
        Xeven(i) = samples(2*i-1);
        Xodd(i) = samples(2*i);
    end
    
    % recursion
    Feven = fft_new(Xeven);
    Fodd = fft_new(Xodd);

    % pre-allocate for speed
    freqbins = zeros(N,1);
    
    % calculate fft
    for k = 0:fix(N/2)-1
        complex_exp = exp(1i*-2*pi*k/N)*Fodd(k+1);
        freqbins(k+1) = Feven(k+1) + complex_exp;
        freqbins(k+fix(N/2)+1) = Feven(k+1) - complex_exp;
    end

    retr = freqbins;
end
