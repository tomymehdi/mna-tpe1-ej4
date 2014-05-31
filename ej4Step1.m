function ej4Step1 (E, L, sigma)
%E tamano del s de entrenamiento (es un vector)
%E > L
%Analizar casos en que E es distinto que cols(imagen) 32,1024

%PASO 1
%h random para el primer caso en el que envio s de entrenamiento
L_aux = 30;
ganancia = 1/10;
h = ganancia*(1+randn(L_aux,1));

a = imread('lena512.bmp');

imshow(a) % muestro la imagen original 

M = size(a,2);
P = size(a,1);
H = toeplitz([h.' zeros(1,M-L_aux)],zeros(1,M)); 
r = zeros(M,P);


%Agrego una fila conocida a la imagen de longitud M, cols(imagen)
%En caso de que E es mayor que cols(imagen) ej:1024 que hago?
sTrainSent = [ones(1,E) zeros(1,M-E)];
a = [ a ; sTrainSent ];

%Envio la imagen con un s extra conocido para entrenamiendo
%Se transmite una fila de la imagen por vez
for k=1:(P+1)
    N = sigma*randn(M,1); % ruido
    s = double(a(k,:)'); % lo que se envia
    r(:,k) = H*s+N; % lo que se recibe
end

b = uint8(r.');
imshow(b);
imwrite(b,'imgTrans.gif');


end
