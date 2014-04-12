function ej4(E, L, sigma)

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

% r = H*s+N
% r = S*h+N

%PASO 2
%Estimo h'_x donde x es la longitud(L) de respuesta al impulso
%Tengo r y S, uso QR para estimar h
%||S*h-r||_{2}^{2}
S = toeplitz(sTrainSent(1,1:M).', zeros(1,L)); % S 
%Uso M para cortar sTrainSent por que si mando uno mas largo que
%cols(imagen) ya no me interesan los que sobran
sTrainReceived = double(a(P+1,:)); % r, lo que recivi del entrenamiento
sTrainReceived = sTrainReceived(1,1:E); %lo corto a su long correspondiente

[Q R] = qr(S); % S*h = r  Entonces Q'*S*h = Q'*r Entonces R*h = Q'*r
h_estimada = R\(Q'*sTrainReceived.'); % Resolvemos R*h = Q'*r
H_estimada = toeplitz([h_estimada.' zeros(1,M-L)],zeros(1,M)); % Obtenemos H con h

%PASO 3
%Recupero la imagen con los distintos h'_x calculados
r2 = r.';
r2 = r2(1:end-1,:); % Le saco la fila de entrenamiento
for k=1:P
    u(:,k) = inv(H_estimada)*r2(:,k);
end
b2 = uint8(u);
imshow(b2);
imwrite(b2,'imgRec.gif');