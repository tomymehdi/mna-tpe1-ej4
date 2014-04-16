
function [Q R] = ourQR (A)
   [m n]=size(A);
    Q(:,1)=A(:,1);
    Q(:,1)=Q(:,1)/norm(Q(:,1),2);
    for i=2:n
        Q(:,i)=A(:,i);
        for k=1:i-1
            Q(:,i)=Q(:,i)-((A(:,i))'*Q(:,k))*Q(:,k);
        endfor
        Q(:,i)=Q(:,i)/norm(Q(:,i),2);
    endfor
    R= (Q')*A;
endfunction
