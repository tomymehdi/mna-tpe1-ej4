function ej4Step2 (E, L, sigma)
%PASO 2
%Estimo h'_x donde x es la longitud(L) de respuesta al impulso
%Tengo r y S, uso QR para estimar h
%||S*h-r||_{2}^{2}
S = toeplitz(sTrainSent(1,1:M), zeros(1,L)); % S 
%Uso M para cortar sTrainSent por que si mando uno mas largo que
%cols(imagen) ya no me interesan los que sobran
sTrainReceived = double(a(P+1,:)); % r, lo que recibi del entrenamiento
sTrainReceived = sTrainReceived(1,1:E); %lo corto a su long correspondiente

[Q R] = qr(S); % S*h = r  Entonces Q'*S*h = Q'*r Entonces R*h = Q'*r
h_estimada = R\(Q'*sTrainReceived.'); % Resolvemos R*h = Q'*r
H_estimada = toeplitz([h_estimada.' zeros(1,M-L)],zeros(1,M)); % Obtenemos H con h


end
