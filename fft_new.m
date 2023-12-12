% Implementation of FFT assuming that samples has even length
% https://www.youtube.com/watch?v=htCj9exbGo0
% https://www.mathworks.com/matlabcentral/answers/1713500-fft-without-built-in-functions

function retr = fft_new(samples)
    % start recursion
    N = length(samples);
    if(N==1)
        retr = samples;
        return;
    end

    M = fix(N/2);
    
    % pre-allocate for speed
    Xeven = zeros(M,1);
    Xodd = zeros(M,1);
   
    for i=1:M
        Xeven(i) = samples(2*i-1);
        Xodd(i) = samples(2*i);
    end

    Feven = fft_new(Xeven);
    Fodd = fft_new(Xodd);

    % pre-allocate for speed
    freqbins = zeros(N,1);

    for k = 0:fix(N/2)-1
        complex_exp = exp(1i*-2*pi*k/N)*Fodd(k+1);
        freqbins(k+1) = Feven(k+1) + complex_exp;
        freqbins(k+fix(N/2)+1) = Feven(k+1) - complex_exp;
    end
    
    retr = freqbins;
end