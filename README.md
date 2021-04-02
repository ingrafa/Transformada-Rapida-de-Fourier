# Transformada-r-pida-de-Fourier
ransformada r�pida de Fourier (I)

La transformada r�pida de Fourier FFT es un algoritmo que reduce el tiempo de c�lculo de n2 pasos a n�log2(n). El �nico requisito es que el n�mero de puntos en la serie tiene que ser una potencia de 2 (2n puntos), por ejemplo 32, 1024, 4096, etc.

Las f�rmulas con la que MATLAB calcula la transformada r�pida de Fourier Y=fft(x) y la transformada inversa y=ifft(X) son, respectivamente:
Supongamos que tenemos una se�al descrita por un conjunto de n (potencia de dos) pares de datos (tj,xj) igualmente espaciados en el tiempo, por un intervalo ?t, desde t=0 hasta tfinal=(n-1)?t. La inversa del intervalo ?t, se denomina frecuencia de muestreo fs. De modo que el vector de tiempos es t=(0:n-1)/ fs


La funci�n fft de MATLAB convierte un vector de valores de la se�al x en funci�n del tiempo t en un vector g en funci�n de la frecuencia ?.

g=fft(x)

g es un vector cuyos elementos son n�meros complejos por que guarda informaci�n acerca de de la amplitud y de la fase. Ahora tenemos que asociar cada elemento del vector g con una frecuencia, del mismo modo que hemos asociado cada elemento del vector x con un tiempo.

El intervalo de frecuencias es ??=2?/(n�?t)=2?fs/n de modo que la m�nima frecuencia es 0 y la m�xima ?max=2?fs(n-1)/n. La resoluci�n espectral ?? es inversamente proporcional al tiempo total n�?t de recogida de datos en la serie temporal.

Conocido el intervalo de tiempo ?t o la frecuencia de muestreo ?t=1/fs y el n�mero de pares de datos n (potencia de 2), creamos el vector de tiempos t y el vector de frecuencias angulares ? del siguiente modo:

>> n=length(x);
>> t=(0:n-1)*dt;
>> dw=2*pi/(n*dt);
>> w=(0:n-1)*dw;
Podemos obviar la fase y concentrarnos en la amplitud, si calculamos y representamos el cuadrado de los elementos del vector g. A P se le denomina espectro de potencia (Power spectrum)

Para ilustrar la aplicaci�n de la funci�n fft de MATLAB, vamos a analizar la se�al formada por la suma de cuatro arm�nicos de frecuencias angulares ?=1, 3, 3.5, 4 y 6 rad/s

x(t)=cos(t)+0.5�cos(3t)+0.4�cos(3.5t)+0.7�cos(4t)+0.2�cos(6t)

Recu�rdese que la transformada de Fourier de f(t)=cos(?0t) es F(?)=?[?(?-?0)+?(?+?0)]. Dos funciones delta de Dirac situados en +?0 y en -?0.

Creamos un script para realizar las siguientes tareas:

Construir una serie temporal (x,t) formada por n=214=16384 pares de datos, tomando un intervalo de tiempo ?t=0.4 s, o bien una frecuencia de muestreo de fs=2.5 Hz. El tiempo final es tfinal=16383�0.4=6553.2 s
Calcular la transformada r�pida de Fourier fft y la guardamos en el vector g
Crear el array de frecuencias ? como en el cuadro anterior
Calculamos la potencia power: el cuadrado del valor absoluto de cada elemento de g.
Representar gr�ficamente power en t�rminos de la frecuencia angular ?
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
title('Espectro de potencia')


La transformada de Fourier de la funci�n x(t) superposici�n de cinco funciones arm�nicas nos deber�a dar funciones delta ?(?) de altura infinita situadas en ?=�?0. El resultado de la aplicaci�n de la funci�n fft de MATLAB es un conjunto de picos muy estrechos y de gran amplitud.

La transformada de Fourier de cualquier se�al tiene un n�mero igual de frecuencias positivas que negativas, P(?)=P(-?). En la ventana de la representaci�n gr�fica vemos solamente frecuencias positivas, no vemos la parte negativa del espectro. En la figura de m�s abajo, vemos las componentes de frecuencias negativas en color rojo.

%serie temporal
n=2^14;
dt=0.4;
t=(0:n-1)*dt; %vector de tiempos
x=cos(t)+0.5*cos(3*t)+0.4*cos(3.5*t)+0.7*cos(4*t)+0.2*cos(6*t);

%amplitud-fase vs. frecuencias
y=fft(x);
g=fftshift(y);
power=abs(g).^2;
dw=2*pi/(n*dt);
w=(-n/2:n/2-1)*dw;

plot(w,power)
xlabel('\omega')
ylabel('P(\omega)')
grid on
title('Espectro de potencia')


As� pues, solamente la primera mitad de la ventana gr�fica muestra los picos de frecuencias correctas, la otra mitad corresponde a las frecuencias negativas.

Solamente podemos detectar los componentes de frecuencia que son menores que ?c=?/?t=?fs. Esta frecuencia l�mite se denomina frecuencia cr�tica o frecuencia de Nyquist. En el ejemplo anterior, ?c=7.85 rad/s. Luego, todas las frecuencias de los arm�nicos componentes de la se�al, ?=1, 3, 3.5, 4 y 6 rad/s son detectadas.

Si solamente queremos ver las frecuencias positivas hasta la frecuencia angular cr�tica ?c, modificamos el script :

n=2^14;
dt=0.4;
t=(0:n-1)*dt; %vector de tiempos
x=cos(t)+0.5*cos(3*t)+0.4*cos(3.5*t)+0.7*cos(4*t)+0.2*cos(6*t);

%amplitud-fase vs. frecuencias
g=fft(x);
power=abs(g).^2;
dw=2*pi/(n*dt);
w=(0:n-1)*dw; 
wc=pi/dt; %frecuencia angular cr�tica
plot(w,power)
xlim([0 wc])

xlabel('\omega')
ylabel('P(\omega)')
grid on
title('Espectro de potencia')


Si queremos distinguir entre dos frecuencias ?1 y ?2 en el espectro es necesario que ??<<|?1-?2| sea peque�o por lo que el tiempo total de muestreo de la se�al n�?t deber� ser grande. Si queremos que frecuencia cr�tica ?c sea grande entonces ?t tendr� que ser peque�o o la frecuencia de muestreo fs grande. En cualquier caso, tendremos que procesar much�simos datos n.

Efecto de la frecuencia de muestreo fs
Supongamos la siguiente funci�n y su transformada de Fourier

Para estudiar el efecto la frecuencia de muestreo fs en la Transformada R�pida de Fourier, vamos a tomar n=16 datos igualmente espaciados de la funci�n f(t) tomando una frecuencia de muestreo fs=2 Hz, es decir ?t=1/fs=0.5 s es el intervalo de tiempo entre dos muestras consecutivas de f(t). El �ltimo dato corresponde al instante (n-1)?t=15�0.5=7.5 s La frecuencia cr�tica ?c=?/?t=?fs=2?.

fs=2; %frecuencia de muestreo
n=16; %n�mero de datos
dt=1/fs;
t=(0:n-1)*dt;
x=t.*exp(-t); %muestras, datos

subplot(2,1,1)
tt=0:0.05:8;
xx=tt.*exp(-tt);
plot(tt,xx,'b',t,x,'ro','markersize',4,'markeredgecolor','r',
'markerfacecolor','r')
xlabel('t')
ylabel('x')
title('f(t)')

subplot(2,1,2)
wc=pi*fs; %frecuencia l�mite de Nyquist
ww=-4*pi:0.1:4*pi;
Fw=1./(1+1i*ww).^2;

%transformada r�pida de Fourier
y=fft(x,n);
g=fftshift(y);
dw=2*pi/(n*dt);
w=(-n/2:n/2-1)*dw;

plot(ww,abs(Fw),'b',w,abs(g)/fs,'ro','markersize',3,'markeredgecolor','r',
'markerfacecolor','r')
set(gca,'XTick',-4*pi:2*pi:4*pi)
set(gca,'XTickLabel',{'-4\pi','-2\pi','0','2\pi','4\pi'})
xlim([-4*pi,4*pi])
xlabel('\omega')
ylabel('|F(w)|')
title('Transformada')


Cambiamos la frecuencia de muestreo a fs=16 Hz, es decir ?t=1/fs=0.0625 s es el intervalo de tiempo entre dos muestras consecutivas de f(t). El n�mero n=128 de datos, por lo que el �ltimo dato corresponde al instante (n-1)?t=127�0.0625=7.9375 s. La frecuencia cr�tica ?c=?/?t=?fs=16?.

fs=16; %frecuencia de muestreo
n=128; %n�mero de datos
.............


Las frecuencias ? se extienden desde -16? a +16?, pero se muestran de -4? a +4? para comparar con el ejemplo previo.

Funci�n de Gauss
Hemos estudiado en la p�gina titulada "Propagaci�n de las ondas en un medio dispersivo" la transformada de Fourier de la funci�n cos(?0t) modulada por una funci�n de Gauss.

La transformada de Fourier no se ve afectada por la posici�n del centro del pulso t0.

En primer lugar, centramos el pulso en t0=8 y establecemos la anchura del pulso en ?2=5, tomamos ?0=10 como frecuencia angular. Dibujamos la funci�n f(t) en el intervalo 0<t<16. Aunque el pulso se extiende desde -? a +?, en el intervalo [0,16] est� definido el pulso.

Con una frecuencia de muestreo fs=8, tomamos n=128 datos, se�alamos los datos tomados como puntos de color rojo en la gr�fica f(t). El primer dato corresponde al instante t1=0 y el �ltimo dato al instante tn=(n-1)/ fs=127/8=15.875

En la parte inferior de la ventana, representamos la transformada de Fourier F(?) en el intervalo comprendido entre -?c y ?c , siendo �sta la fecuencia l�mite ?c=?fs. Calculamos la transformada r�pida de Fourier (FFT) de los datos tomados y representamos su m�dulo en dicho intervalo.

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
title('Funci�n')

subplot(2,1,2)
hold on
wc=pi*fs; %frecuencia l�mite de Nyquist
w=-wc:0.1:wc;
Fw=sqrt(2*pi*s2)*exp(-1i*w*t0).*(exp(1i*w0*t0)*exp(-(w-w0).^2*s2/2)+...
exp(-1i*w0*t0)*exp(-(w+w0).^2*s2/2))/2;

%transformada r�pida de Fourier
y=fft(ft,n);
g=fftshift(y);
dw=2*pi/(n*dt);
ww=(-n/2:n/2-1)*dw;
plot(w,abs(Fw),'b',ww,abs(g)/fs,'ro','markersize',2,
'markeredgecolor','r','markerfacecolor','r')
hold off
grid on
xlabel('\omega')
ylabel('F(\omega)')
title('Transformada')


Obtenemos dos picos situados en ?=-?0=-10 y ?=+?0=10

Si ahora centramos el pulso en t0=2 y tomamos n=32 datos con la misma frecuencia de muestreo fs=8, de modo que el primer dato corresponde al instante t1=0 y el �ltimo dato al instante tn=(n-1)/ fs=31/8=3.875, obtenemos una pobre definici�n de la transformada de Fourier tal como puede verse en la parte inferior de la figura.

t0=2;
w0=10;
s2=5;
t=0:0.05:4;
f=@(t) exp(-(t-t0).^2/(2*s2)).*cos(w0*t);

subplot(2,1,1)
hold on
plot(t,f(t),'b')
fs=8;
n=32;
dt=1/fs;
t=(0:n-1)*dt;
ft=f(t);
plot(t,ft,'ro','markersize',2,'markeredgecolor','r','markerfacecolor','r')
hold off
grid on
xlabel('t')
ylabel('f(t)')
title('Funci�n')

subplot(2,1,2)
hold on
wc=pi*fs; %frecuencia l�mite de Nyquist
w=-wc:0.1:wc;
Fw=sqrt(2*pi*s2)*exp(-1i*w*t0).*(exp(1i*w0*t0)*exp(-(w-w0).^2*s2/2)+...
exp(-1i*w0*t0)*exp(-(w+w0).^2*s2/2))/2;

%transformada r�pida de Fourier
y=fft(ft,n);
g=fftshift(y);
dw=2*pi/(n*dt);
ww=(-n/2:n/2-1)*dw;
plot(w,abs(Fw),'b',ww,abs(g)/fs,'ro','markersize',2,'markeredgecolor','r',
'markerfacecolor','r')
hold off
grid on
xlabel('\omega')
ylabel('F(\omega)')
title('Transformada')


Grado en Ingenier�a de Sistemas

Rafaelo Angamarca, Copyright � 2021
