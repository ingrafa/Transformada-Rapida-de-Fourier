%Creamos un script para realizar las siguientes tareas:

%1 Construir una serie temporal (x,t) formada por n=214=16384 pares de datos,
%2 tomando un intervalo de tiempo Δt=0.4 s, o bien una frecuencia de muestreo de fs=2.5 Hz.
%El tiempo final es tfinal=16383·0.4=6553.2 s
%3 Calcular la transformada rápida de Fourier fft y la guardamos en el vector g
%4 Crear el array de frecuencias ω como en el cuadro anterior
%5 Calculamos la potencia power: el cuadrado del valor absoluto de cada elemento de g.
%6 1Representar gráficamente power en términos de la frecuencia angular ω

%serie temporal
n=2^14;
dt=0.4;
t=(0:n-1)*dt; %vector de tiempos
x=cos(t)+0.5*cos(3*t)+0.4*cos(3.5*t)+0.7*cos(4*t)+0.2*cos(6*t);

%amplitud-fase vs. frecuencias
g=fft(x);
power=abs(g).^2;
dw=2*pi/(n*dt);
w=(0:n-1)*dw; %vector de frecuencias angulares

plot(w,power)
xlabel('\omega')
ylabel('P(\omega)')
title('Espectro de potencia'

