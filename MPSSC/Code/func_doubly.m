function [Kernels2, id]= func_doubly(X, k10);
%% construct multiple doubly stochastic similarity matrices using Gaussian kernels (Step 1)
%% input
% x is the n by p sequence data
% k10 is number of neighborhoods used in KNN: default is 10

%% output
% Kernels2 is the set of 55 doubly stochastic similarity matrices.
% id includes the k10 number of neighborhood for each subject.



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
         Kernels2(:,:,tts)=SK_normalize(WW1);
end


distX=mean(Kernels2,3);
[distX1, idx] = sort(distX,2,'descend');

if nargin==1
id = idx(:,2:11);
elseif nargin==2
id = idx(:,2:(k10+1));
end

end
