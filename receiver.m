close all;
clear all;

fs = 44100;
sampling_time = 1;    % sampling time for a symbol 
space_time = 0.5;
num_symbol = 12;
raw_total_time = (num_symbol+7)*sampling_time+10;    % raw_total_time must be greater than num_symbol*sampling_time

num_symbol = num_symbol + 7;
recObj = audiorecorder(fs,16,1); 

recordblocking(recObj, raw_total_time);

raw = getaudiodata(recObj)';

for i=1:length(raw)
    if(raw(1,i)>0.5)
        new_raw = raw(1,i:end);
        break;
    end
end

new_raw = new_raw(1,1:num_symbol*sampling_time*fs);

interval = fs*sampling_time;
symbol = ones(num_symbol-7,2);
freq = ones(1,num_symbol-7);

F1=0;
F2=0;
F3=0;
f0=0;
f1=0;
f2=0;
f3=0;


for i=1:num_symbol
    y = new_raw((i-1)*interval+1:i*interval);

    L=length(y);
    NFFT=2^nextpow2(L);
    Y=fft(y,NFFT)/L;
    Y_end =Y(1:NFFT/2+1);
    [M,I] = max(Y_end);
    f_received = I*fs/NFFT;

%     f=linspace(0,fs/2,NFFT/2+1);
%     figure; plot(f,abs(Y_end))
%     xlabel('frequency(Hz)')
%     ylabel('Magnitude')
    
    if(i == 1)
        F1 = round(f_received,0);
    elseif(i == 2)
        F2 = round(f_received,0);
    elseif(i == 3)
        F3 = round(f_received,0);
    elseif(i == 4)
        f0 = round(f_received - F1,0);
    elseif(i == 5)
        f1 = round(f_received - F1,0);
    elseif(i == 6)
        f2 = round(f_received - F1,0);
    elseif(i == 7)
        f3 = round(f_received - F1,0);
    else
        freq(1,i-7) = f_received;  
        if (f_received > F1+f0 - 60 && f_received < F1 + f0 + 60 )
            symbol(i-7,:) = '00';
        elseif (f_received > F1 + f1 - 60 && f_received < F1 + f1 + 60 )
            symbol(i-7,:) = '01';
        elseif (f_received > F1 + f2 - 60 && f_received < F1 + f2 + 60 )
            symbol(i-7,:) = '10';
        elseif (f_received > F1 + f3 - 60 && f_received < F1 + f3 + 60 )
            symbol(i-7,:) = '11';
        elseif (f_received > F2 + f0 - 60 && f_received < F2 + f0 + 60 )
            symbol(i-7,:) = '00';
        elseif (f_received > F2 + f1 - 60 && f_received < F2 + f1 + 60 )
            symbol(i-7,:) = '01';
        elseif (f_received > F2 + f2 - 60 && f_received < F2 + f2 + 60 )
            symbol(i-7,:) = '10';
        elseif (f_received > F2 + f3 - 60 && f_received < F2 + f3 + 60 )
            symbol(i-7,:) = '11';
        elseif (f_received > F3 + f0 - 60 && f_received < F3 + f0 + 60 )
            symbol(i-7,:) = '00';
        elseif (f_received > F3 + f1 - 60 && f_received < F3 + f1 + 60 )
            symbol(i-7,:) = '01';
        elseif (f_received > F3 + f2 - 60 && f_received < F3 + f2 + 60 )
            symbol(i-7,:) = '10';
        elseif (f_received > F3 + f3 - 60 && f_received < F3 + f3 + 60 )
            symbol(i-7,:) = '11';
        end
    end
end

letter = [];
for j=1:4:num_symbol-10
    if(size(letter,1)==0)
        letter = strcat(symbol(j,:),symbol(j+1,:),symbol(j+2,:),symbol(j+3,:));
        disp(char(bin2dec(letter)))
    else
        letter = strcat(symbol(j,:),symbol(j+1,:),symbol(j+2,:),symbol(j+3,:));
        disp(char(bin2dec(letter)))
    end
end



    
