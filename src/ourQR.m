function [Q R] = ourQR (A)
   [rows cols]=size(A);
    Q(:,1)=A(:,1);
    Q(:,1)=Q(:,1)/norm(Q(:,1),2);
    
    R(1,:)=Q(:,1)'*A;
    for i=2:rows
        if i > cols
            Q(:,i)=rand(rows,1);
        else
            Q(:,i)=A(:,i);
        end
        for k=1:i-1
            Q(:,i) = Q(:,i) - ((Q(:,i))'*Q(:,k)) * Q(:,k);
        end
        Q(:,i) = Q(:,i)/norm(Q(:,i),2);
        
        if i<=cols
            R(i,:)=Q(:,i)'*A;
        end
    end
    [Rrows Rcols] = size(R);
    R = [ R ; zeros(rows-Rrows,Rcols) ];
    
end
