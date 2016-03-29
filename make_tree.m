function [ctree,index] = make_tree(ctree,symbols,l,r,index)
    if(l<r)
       aux = index;
       mid = floor((l+r-1)/2);
       %Left
       index = index + 1;
       ctree(aux,1) = index;
       [ctree,index] = make_tree(ctree,symbols,l,mid,index);
       %ctree(index,3) = 0;
       ctree(index,5) = aux;

       %Right
       index = index + 1;
       ctree(aux,2) = index;
       [ctree,index] = make_tree(ctree,symbols,mid+1,r,index);
       %ctree(index,3) = 1;
       ctree(index,3);
       ctree(index,5) = aux;

    end  
    if(l==r)
        ctree(index,4) = symbols(l);
    end
end