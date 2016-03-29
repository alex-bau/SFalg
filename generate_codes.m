function [ ] = generate_codes( ctree,node,code )
    global codes;
    if(ctree(node,1) > 0 )
       generate_codes( ctree,ctree(node,1),[code 0]);
       generate_codes( ctree,ctree(node,2),[code 1]);
    else
       aux = bi2de(code);
       codes = [codes aux];
    end
end