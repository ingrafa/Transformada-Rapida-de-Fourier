t0=8;
w0=10;
s2=5;
t=0:0.05:16;
f=@(t) exp(-(t-t0).^2/(2*s2)).*cos(w0*t);

subplot(2,1,1)
hold on
plot(t,f(t),'b')
fs=8;
n=128;
dt=1/fs;
t=(0:n-1)*dt;
ft=f(t);
plot(t,ft,'ro','markersize',2,'markeredgecolor','r','markerfacecolor','r')
hold off
grid on
xlabel('t')
ylabel('f(t)')
title('Función')

subplot(2,1,2)
hold on
wc=pi*fs; %frecuencia límite de Nyquist
w=-wc:0.1:wc;
Fw=sqrt(2*pi*s2)*exp(-1i*w*t0).*(exp(1i*w0*t0)*exp(-(w-w0).^2*s2/2)+...
exp(-1i*w0*t0)*exp(-(w+w0).^2*s2/2))/2;

%transformada rápida de Fourier
y=fft(ft,n);
g=fftshift(y);
dw=2*pi/(n*dt);
ww=(-n/2:n/2-1)*dw;
plot(w,abs(Fw),'b',ww,abs(g)/fs,'ro','markersize',2,'markeredgecolor','r','markerfacecolor','r')
hold off
grid on
xlabel('\omega')
ylabel('F(\omega)')
title('Transformada')
