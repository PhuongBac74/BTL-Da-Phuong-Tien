voice = audioread('orig_input.wav'); %am thanh ghi am ban dau

fs=44100;% tan so lay mau
t=0:1/fs:0.3;

% chia file thanh 5 doan
a1 = voice(51000:125000); 
a2 = voice(125000:190000); 
a3 = voice(190000:250000); 
a4 = voice(250000:372000); 
a5 = voice(372000:584704); 

%thay doi chieu dai cua tung doan ,tao nen nhip dieu nhanh dan.
x1 = a1(1:1:length(a1));
x2 = a2(1:1.2:length(a2));
x3 = a3(1:1.4:length(a3));
x4 = a4(1:1.6:length(a4));
x5 = a5(1:1.8:length(a5));

b= [ x1 x2 x3 x4 x5];% tin hieu da co nhip dieu
%tao tan so cac not nhac A B C# D E F#
fA=440;
fB=493.88;
fCs=554.37;
fD=587.33;
fE=659.26;
fFs=739.99;
% cac gia tri bien do
A1=.1;
A2=.2;
A3=.3;
A4=.4;
A5=.5;
A6=.6;
%tin hieu nen
A= A1*sin(2*pi*fA*t);
B=A2*sin(2*pi*fB*t);
Cs=A3*sin(2*pi*fCs*t);
D=A4*sin(2*pi*fD*t);
E=A5*sin(2*pi*fE*t);
Fs=A6*sin(2*pi*fFs*t);

%tao  complex tones tu cac tin hieu nen
tone2 =[ A A E E Fs Fs E E D D Cs Cs B B A A A A E E Fs Fs E E D D];
x1=b;
x2=x1(1:length(tone2));% tuong thich do dai giua tin hieu b va tones nen
m= tone2 + x2;% tron tin hieu va tones de tao thanh "melody"

%------exprort file " melody.wav"
audiowrite('melody.wav',m,44100); 

%------thuc hien chuyen doi FFT cho tin hieu melody
N=fs; % so diem thuc hien FFT
transform = fft(m,N)/N; % thuc hien FFT
magTransform=abs(transform);
f_axis= linspace(-fs/2,fs/2,N);
plot(f_axis,fftshift(magTransform));
xlabel('Frequency (Hz)');
title(' Fast Fourier Transform of Melody');

%---- Tao va ve Spectrogram cho tin hieu melody
win = 128; 
hop = win/2;            
nfft = win;
spectrogram(m,win,hop,nfft,fs,'yaxis');
title('Spectogram of melody');



