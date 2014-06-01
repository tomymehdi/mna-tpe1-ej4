
function z = ecuationTriangularSolver (x, y)
    answerQty=size(x)(2);
    
    z=zeros(answerQty,1);
    z(answerQty)=y(answerQty)/x(answerQty,answerQty);
    for i=answerQty-1:-1:1
            aux=x(i,i+1:answerQty)*z(i+1:answerQty);
            z(i)=(y(i)-aux)/x(i,i);
    end

endfunction
