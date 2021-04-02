n=2^14;
dt=0.4;
t=(0:n-1)*dt; %vector de tiempos
x=cos(t)+0.5*cos(3*t)+0.4*cos(3.5*t)+0.7*cos(4*t)+0.2*cos(6*t);

%amplitud-fase vs. frecuencias
g=fft(x);
power=abs(g).^2;
dw=2*pi/(n*dt);
w=(0:n-1)*dw; 
wc=pi/dt; %frecuencia angular crítica
plot(w,power)
xlim([0 wc])

xlabel('\omega')
ylabel('P(\omega)')
grid on
title('Espectro de potencia')