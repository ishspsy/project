function [Kernels2, id]= func_reg(X);
%% generate regular affinity matrices correspondng to Gaussian kernels.

[n,p]=size(X); x=X;
sigma_set=1:0.25:2;  k_set=10:2:30; 

N = size(x,1);
KK = 0;
sigma = [1:0.25:2];
Diff = sqrt(dist2(x));
[T,INDEX]=sort(Diff,2);
[m,n]=size(Diff);
allk = 10:2:30;
t=1;
for l = 1:length(allk)
        TT=mean(T(:,2:(allk(l))),2);
        Sig=(repmat(TT,1,n)+repmat(TT',n,1))/2;
        for j = 1:length(sigma)
            W=normpdf(Diff,0,sigma(j)*Sig);
            Kernels(:,:,KK+t) =W;
            t = t+1;
        end
end


Kernels2=Kernels;
parfor tts=1:55
         WW1= Kernels(:,:,tts); 
         DWW1= (max(sum(WW1),eps)).^(-0.5); 
         WW1=  diag(DWW1)*WW1*diag(DWW1);
         Kernels2(:,:,tts)=WW1;
end



function D_kernels = mex_multipleK2(val,ind,KK)

t = 1; allk = 10:2:30; sigma = [1:0.25:2];
for i = 1:length(allk)
    if allk(i)< size(val,2)
    temp = mean(val(:,1:allk(i)),2);
    temp0 = .5*(repmat(temp,1,size(val,2)) + temp(ind));
    
    for j = 1:length(sigma)
        temp = normpdf(val, 0, sigma(j)*temp0);
        D_kernels(:,:,t) = temp;
        t = t+1;
    end
    end
end
end


end