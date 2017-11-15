function [YY] = SK_normalize(XX)
%% SK algorithm used in Step 1 of MPSSC

[n p]=size(XX);
YY=XX;
err=1;

err_set=[]; rep=0;
while (err>0.001)+ (rep<100)>1.5

rep=rep+1;
Y_r=sum(YY,2); 

parfor ii=1:n
    YY(ii,:)=YY(ii,:)/Y_r(ii);
end
Y_c=sum(YY,1);
parfor ii=1:n
    YY(:,ii)=YY(:,ii)/Y_c(ii);
end
err=norm(YY-XX,'fro');
XX=YY;
%err_set=[err_set,err]
end

YY=(YY+YY')*0.5;

