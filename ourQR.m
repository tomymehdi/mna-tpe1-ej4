function [Q R] = ourQR (A)
   [rows cols]=size(A);
    Q(:,1)=A(:,1);
    Q(:,1)=Q(:,1)/norm(Q(:,1),2);
    for i=2:cols
        Q(:,i)=A(:,i);
        for k=1:i-1
            Q(:,i) = Q(:,i) - ((Q(:,i))'*Q(:,k)) * Q(:,k);
        end
        Q(:,i) = Q(:,i)/norm(Q(:,i),2);
    end
    R= (Q')*A;
end
