clear;
prompt = 'text: ';
str = input(prompt,'s');
A = dec2bin(str,8);

for i = 0:1:(size(A,1)-1)
    for j=1:1:size(A,2)/2
        B(j+i*4,1) = A(i+1,2*j-1);
        B(j+i*4,2)= A(i+1,j*2);
    end 
end
B = bin2dec(B);
f0 = 200;
f1 = 400;
f2 = 600;
f3 = 800;
F1 = 3000;
F2 = 4000;
F3 = 5000;
F = [F1 F2 F3 F1+f0 F1+f1 F1+f2 F1+f3];

for k = 1:1:7
     f=F(k);
     Amp=10;
     ts=1/44100;
     fs=44100;
     T=0.5;
     t=0:ts:T;
     y=sin(2*pi*f*t);
     sound(y,fs,16);
     pause(1);
end

 for k = 1:1:size(B,1)
     r = randi(3);
     if B(k) == 0
         freq(k) = f0+F(r);
     elseif B(k) == 1
         freq(k) = f1+F(r);
     elseif B(k) == 2
         freq(k) = f2+F(r);
     elseif B(k) == 3
         freq(k) = f3+F(r);
     end 
     f=freq(k);
     Amp=10;
     ts=1/44100;
     fs=44100;
     T=0.5;
     t=0:ts:T;
     y=sin(2*pi*f*t);
     sound(y,fs,16);
     pause(1);
 end
    
         