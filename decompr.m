clear all; close all; clc;
fg  = uigetfile;
fo  = fopen(fg);
f8  = fread(fo,'bit8');
file = f8;
num_symbols = file(1);
symbols = file(2:num_symbols+1);
fclose(fo);
fo = fopen(fg);
f1 = fread(fo,'ubit1');

tree_size = 2^(log2(num_symbols)+1)-2+2*(num_symbols-2^(log2(num_symbols)));
ctree = zeros(int32(tree_size),5);
[ctree,~] = make_tree(ctree,symbols,1,num_symbols,1);
global codes;
codes = [];
generate_codes(ctree,1,codes);
aux = [];
file = [];

for i=(num_symbols+2)*8:length(f1)
   aux = [aux f1];
   for j=1:num_symbols
       if(bi2de(aux)==codes(j))
           file = [ file ; symbols(j) ];
           aux = [];
       end
   end
end

save date_dc.out file