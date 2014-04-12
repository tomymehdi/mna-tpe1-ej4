function [ s r b ] = ej4(E, L, sigma)

%E tamano del s de entrenamiento (es un vector)
%E > L

%h random para el primer caso en el que envio s de entrenamiento
L = 30;
ganancia = 1/10;
h = ganancia*(1+randn(L,1));

a = imread('lena512.bmp');

imshow(a) % muestro la imagen original 

M = size(a,2);
P = size(a,1);
H = toeplitz([h.' zeros(1,M-L)],zeros(1,M)); 
r = zeros(M,P);


%Agrego una fila conocida a la imagen de longitud E
sTrainSent = ones(1,M);
a = [ a ; sTrainSent ]

%Envio la imagen con un s extra conocido para entrenamiendo
%Se transmite una fila de la imagen por vez
for k=1:(P+1)
    N = sigma*randn(M,1); % ruido
    s = double(a(k,:)'); % lo que se envia
    r(:,k) = H*s+N; % lo que se recibe
end

b = uint8(r.');
imshow(b)

% r = H*s+N
% r = S*h+N

%Estimo h'_x donde x es la longitud(L) del s de entrenamiento
%Tengo r y S, uso QR para estimar h
%||S*h-r||_{2}^{2}
S = toeplitz([sTrainSent.' zeros(1,E-L)], zeros(1,E)); % S
sTrainReceived = double(a(P+1,:)); % r

[Q R] = qr(S);


%Recupero la imagen con los distintos h'_x calculados
r2=r.'
for k=1:P
    u(:,k) = inv(H_estimada)*r2(:,k);
end
b2 = uint8(u.');
imshow(b2)