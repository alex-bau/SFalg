clear all; close all; clc;
fg  = uigetfile;
fo  = fopen(fg);
f8  = fread(fo,'ubit8');
file = f8;
symbols = [];
%%Construirea vectorului de simboluri

for i = 1:length(f8)
    x = 1;
    for j = 1:length(symbols)
        if(symbols(j) == file(i))
           x = 0; 
           j = length(symbols) + 1;
        end
    end
    if(x)
       symbols = [symbols file(i)]; 
    end
end

%%Declararea arborelui
num_symbols = length(symbols);
tree_size = 2^(log2(num_symbols)+1)-2+2*(num_symbols-2^(log2(num_symbols)));
ctree = zeros(int32(tree_size),5);

%%Numararea elementelor
symbols = [symbols ; zeros(1,num_symbols)];
for i=1:length(f8)
    for j=1:num_symbols
       if(file(i)== symbols(1,j))
           symbols(2,j) = symbols(2,j) + 1;
       end
    end
end

%%Sortare vector

aux = [symbols(2,1:num_symbols)' symbols(1,1:num_symbols)'];
symbols = sortrows(aux,[-1 2]);
%%Creare arbore
[ctree,~] = make_tree(ctree,symbols(1:num_symbols,2),1,num_symbols,1);
for i=1:tree_size
   if(ctree(i,2)~=0)
      ctree(ctree(i,2),3) = 1; 
   end
end
ctree(int32(tree_size+1),5) = ctree(int32(tree_size),5);
%%make_tree(arbore,alfabet,left,right,nod_curent)
global codes;
codes = [];
generate_codes(ctree,1,codes);
codes = de2bi(codes);

cfile = [];
aux = [];
[~,y] = size(codes);

for i=1:length(file)
   for j=1:num_symbols
       if(symbols(j,2)==file(i))
           aux = [aux codes(j,1:y)];
           aux
           symbols(j,2)
           j = num_symbols+1;
       end
   end
   if(length(aux)>8)
      cfile = [ cfile ; aux(1:8) ];
      aux = aux(9:length(aux));
   end
end
aux = [zeros(1,8-length(aux)) aux];
cfile = [cfile ; aux];
cfile = bi2de(fliplr(cfile));
cfile
cfile = [num_symbols;symbols(1:num_symbols,2);cfile];
fclose('all');
fg  = uigetfile;
fo  = fopen(fg);
fwrite(fo,cfile);
fclose('all');
ftesto = fopen('data.out');
ftest8 = fread(ftesto,'ubit8');
'Marime fisier normal'
[x,~] = size(f8)
'Marime fisier comprimat'
[x,~] = size(ftest8)