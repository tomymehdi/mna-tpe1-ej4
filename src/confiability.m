function z=confiability(recovered,original)
    z=0;
    recoveredCols=size(recovered)(2);
    recoveredRows=size(recovered)(1);
    for i=1:recoveredRows
        for j=1:recoveredCols
            if(recovered(i,j)==original(i,j))
              z=z+1;
            end
        endfor
    endfor    
    z=z/(recoveredCols*recoveredRows);
end   