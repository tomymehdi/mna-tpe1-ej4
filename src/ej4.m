function ej4(E, L, sigma)

%E tamano del s de entrenamiento (es un vector)
%E > L
%Analizar casos en que E es distinto que cols(imagen) 32,1024

%PASO 1
'Enviando imagen por canal inestable'
%h random para el primer caso en el que envio s de entrenamiento
L_aux = 5;
ganancia = 1/5;
h = ganancia*(1+randn(L_aux,1));

a = imread('lena512.bmp');
%a = 255*rand(10,10);
imwrite(uint8(a),'realimg.bmp');
%a=eye(5,5);

%Agrego una fila conocida a la imagen de longitud M, cols(imagen)
sTrainSent = 255*[rand(1,E) zeros(1,size(a,2)-E)];
sTrainSent = double(sTrainSent);
a = [ a ; sTrainSent ];

%imshow(a); % muestro la imagen original 

M = size(a,2);
P = size(a,1);
H = toeplitz([h.' zeros(1,M-L_aux)],zeros(1,M)); 
r = zeros(M,P);
N = sigma*randn(M,1); % ruido
%Envio la imagen con un s extra conocido para entrenamiendo
%Se transmite una fila de la imagen por vez
for k=1:P
    s = double(a(k,:)'); % lo que se envia
    r(:,k) = H*s+N; % lo que se recibe
    N = sigma*randn(M,1); % mas ruido
end
b = uint8(r(:,1:P-1).');
%imshow(b);
imwrite(b,'imgTrans.bmp');

% r = H*s+N
% r = S*h+N

%PASO 2
'Estimando H'
%Estimo h'_x donde x es la longitud(L) de respuesta al impulso
%Tengo r y S, uso QR para estimar h
%||S*h-r||_{2}^{2}
S = toeplitz(sTrainSent, zeros(1,L)); % S 
%Uso M para cortar sTrainSent por que si mando uno mas largo que
%cols(imagen) ya no me interesan los que sobran
sTrainReceived = double(r(:,P)); % r, lo que recibi del entrenamiento


[Q R] = ourQR(S); % S*h = r  Entonces Q'*S*h = Q'*r Entonces R*h = Q'*r
h_estimada = ecuationTriangularSolver(R,(Q'*sTrainReceived)); % Resolvemos R*h = Q'*r y usamos el hecho de que R es triangular
H_estimada = toeplitz([h_estimada.' zeros(1,M-L)],zeros(1,M)); % Obtenemos H con h

%PASO 3
'Recuperando'
%Recupero la imagen con el H_estimada
r2 = r.';


for k=1:P-1
    
    [Qr Rr]=ourQR(H_estimada);
    
    u(:,k)=ecuationTriangularSolver(Rr,(Qr)'*r(:,k));
    
    %u(:,k) = H_estimada\r(:,k); %lo que se recupera
end
%u(:,P+1) = sTrainReceived; %lo que recibi ultima linea
b2 = uint8(u.');
%imshow(b2);
imwrite(b2,'imgRec.bmp');
