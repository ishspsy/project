function [Kernels2]= func_Laplacian(X, k10);
%% Compute regular Laplacian matrix using Gaussian kernels.

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
end

