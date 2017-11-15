function val = purity(CCC, x, y)    %x is obtained, y is true
%% Computing Purity between x and y labels

ind_set=cell(CCC,CCC);
for ii=1:CCC
    for jj=1:CCC
        ind_set{ii,jj}= intersect(find(x==ii), find(y==jj));
    end
end

val0=0;
for ii=1:CCC
    val_set=[];
    for jj=1:CCC
        val_set=[val_set,length(ind_set{ii,jj})];
    end
    val0=val0+max(val_set);
end

val=val0/length(x);
        
        
