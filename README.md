# Transformada-Rapida-de-Fourier


La transformada rápida de Fourier FFT es un algoritmo que reduce el tiempo de cálculo de n2 pasos a n·log2(n). El único requisito es que el número de puntos en la serie tiene que ser una potencia de 2 (2n puntos), por ejemplo 32, 1024, 4096, etc.

Las fórmulas con la que MATLAB calcula la transformada rápida de Fourier Y=fft(x) y la transformada inversa y=ifft(X) son, respectivamente:
Supongamos que tenemos una señal descrita por un conjunto de n (potencia de dos) pares de datos (tj,xj) igualmente espaciados en el tiempo, por un intervalo ?t, desde t=0 hasta tfinal=(n-1)?t. La inversa del intervalo ?t, se denomina frecuencia de muestreo fs. De modo que el vector de tiempos es t=(0:n-1)/ fs


La función fft de MATLAB convierte un vector de valores de la señal x en función del tiempo t en un vector g en función de la frecuencia ?.

g=fft(x)

g es un vector cuyos elementos son números complejos por que guarda información acerca de de la amplitud y de la fase. Ahora tenemos que asociar cada elemento del vector g con una frecuencia, del mismo modo que hemos asociado cada elemento del vector x con un tiempo.

El intervalo de frecuencias es ??=2?/(n·?t)=2?fs/n de modo que la mínima frecuencia es 0 y la máxima ?max=2?fs(n-1)/n. La resolución espectral ?? es inversamente proporcional al tiempo total n·?t de recogida de datos en la serie temporal.

Conocido el intervalo de tiempo ?t o la frecuencia de muestreo ?t=1/fs y el número de pares de datos n (potencia de 2), creamos el vector de tiempos t y el vector de frecuencias angulares ? del siguiente modo:

>> n=length(x);
>> t=(0:n-1)*dt;
>> dw=2*pi/(n*dt);
>> w=(0:n-1)*dw;
Podemos obviar la fase y concentrarnos en la amplitud, si calculamos y representamos el cuadrado de los elementos del vector g. A P se le denomina espectro de potencia (Power spectrum)

Para ilustrar la aplicación de la función fft de MATLAB, vamos a analizar la señal formada por la suma de cuatro armónicos de frecuencias angulares ?=1, 3, 3.5, 4 y 6 rad/s

x(t)=cos(t)+0.5·cos(3t)+0.4·cos(3.5t)+0.7·cos(4t)+0.2·cos(6t)

Recuérdese que la transformada de Fourier de f(t)=cos(?0t) es F(?)=?[?(?-?0)+?(?+?0)]. Dos funciones delta de Dirac situados en +?0 y en -?0.

Creamos un script para realizar las siguientes tareas:

Construir una serie temporal (x,t) formada por n=214=16384 pares de datos, tomando un intervalo de tiempo ?t=0.4 s, o bien una frecuencia de muestreo de fs=2.5 Hz. El tiempo final es tfinal=16383·0.4=6553.2 s
Calcular la transformada rápida de Fourier fft y la guardamos en el vector g
Crear el array de frecuencias ? como en el cuadro anterior
Calculamos la potencia power: el cuadrado del valor absoluto de cada elemento de g.
Representar gráficamente power en términos de la frecuencia angular ?
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


La transformada de Fourier de la función x(t) superposición de cinco funciones armónicas nos debería dar funciones delta ?(?) de altura infinita situadas en ?=±?0. El resultado de la aplicación de la función fft de MATLAB es un conjunto de picos muy estrechos y de gran amplitud.

La transformada de Fourier de cualquier señal tiene un número igual de frecuencias positivas que negativas, P(?)=P(-?). En la ventana de la representación gráfica vemos solamente frecuencias positivas, no vemos la parte negativa del espectro. En la figura de más abajo, vemos las componentes de frecuencias negativas en color rojo.

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


Así pues, solamente la primera mitad de la ventana gráfica muestra los picos de frecuencias correctas, la otra mitad corresponde a las frecuencias negativas.

Solamente podemos detectar los componentes de frecuencia que son menores que ?c=?/?t=?fs. Esta frecuencia límite se denomina frecuencia crítica o frecuencia de Nyquist. En el ejemplo anterior, ?c=7.85 rad/s. Luego, todas las frecuencias de los armónicos componentes de la señal, ?=1, 3, 3.5, 4 y 6 rad/s son detectadas.

Si solamente queremos ver las frecuencias positivas hasta la frecuencia angular crítica ?c, modificamos el script :

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


Si queremos distinguir entre dos frecuencias ?1 y ?2 en el espectro es necesario que ??<<|?1-?2| sea pequeño por lo que el tiempo total de muestreo de la señal n·?t deberá ser grande. Si queremos que frecuencia crítica ?c sea grande entonces ?t tendrá que ser pequeño o la frecuencia de muestreo fs grande. En cualquier caso, tendremos que procesar muchísimos datos n.

Efecto de la frecuencia de muestreo fs
Supongamos la siguiente función y su transformada de Fourier

Para estudiar el efecto la frecuencia de muestreo fs en la Transformada Rápida de Fourier, vamos a tomar n=16 datos igualmente espaciados de la función f(t) tomando una frecuencia de muestreo fs=2 Hz, es decir ?t=1/fs=0.5 s es el intervalo de tiempo entre dos muestras consecutivas de f(t). El último dato corresponde al instante (n-1)?t=15·0.5=7.5 s La frecuencia crítica ?c=?/?t=?fs=2?.

fs=2; %frecuencia de muestreo
n=16; %número de datos
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
wc=pi*fs; %frecuencia límite de Nyquist
ww=-4*pi:0.1:4*pi;
Fw=1./(1+1i*ww).^2;

%transformada rápida de Fourier
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


Cambiamos la frecuencia de muestreo a fs=16 Hz, es decir ?t=1/fs=0.0625 s es el intervalo de tiempo entre dos muestras consecutivas de f(t). El número n=128 de datos, por lo que el último dato corresponde al instante (n-1)?t=127·0.0625=7.9375 s. La frecuencia crítica ?c=?/?t=?fs=16?.

fs=16; %frecuencia de muestreo
n=128; %número de datos
.............


Las frecuencias ? se extienden desde -16? a +16?, pero se muestran de -4? a +4? para comparar con el ejemplo previo.

Función de Gauss
Hemos estudiado en la página titulada "Propagación de las ondas en un medio dispersivo" la transformada de Fourier de la función cos(?0t) modulada por una función de Gauss.

La transformada de Fourier no se ve afectada por la posición del centro del pulso t0.

En primer lugar, centramos el pulso en t0=8 y establecemos la anchura del pulso en ?2=5, tomamos ?0=10 como frecuencia angular. Dibujamos la función f(t) en el intervalo 0<t<16. Aunque el pulso se extiende desde -? a +?, en el intervalo [0,16] está definido el pulso.

Con una frecuencia de muestreo fs=8, tomamos n=128 datos, señalamos los datos tomados como puntos de color rojo en la gráfica f(t). El primer dato corresponde al instante t1=0 y el último dato al instante tn=(n-1)/ fs=127/8=15.875

En la parte inferior de la ventana, representamos la transformada de Fourier F(?) en el intervalo comprendido entre -?c y ?c , siendo ésta la fecuencia límite ?c=?fs. Calculamos la transformada rápida de Fourier (FFT) de los datos tomados y representamos su módulo en dicho intervalo.

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
plot(w,abs(Fw),'b',ww,abs(g)/fs,'ro','markersize',2,
'markeredgecolor','r','markerfacecolor','r')
hold off
grid on
xlabel('\omega')
ylabel('F(\omega)')
title('Transformada')


Obtenemos dos picos situados en ?=-?0=-10 y ?=+?0=10

Si ahora centramos el pulso en t0=2 y tomamos n=32 datos con la misma frecuencia de muestreo fs=8, de modo que el primer dato corresponde al instante t1=0 y el último dato al instante tn=(n-1)/ fs=31/8=3.875, obtenemos una pobre definición de la transformada de Fourier tal como puede verse en la parte inferior de la figura.

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
plot(w,abs(Fw),'b',ww,abs(g)/fs,'ro','markersize',2,'markeredgecolor','r',
'markerfacecolor','r')
hold off
grid on
xlabel('\omega')
ylabel('F(\omega)')
title('Transformada')


Grado en Ingeniería de Sistemas

Rafaelo Angamarca, Copyright © 2021
