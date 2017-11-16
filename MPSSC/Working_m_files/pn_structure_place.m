
%% comparisons of the target matrices of different SC methods
%% obtain the target matrices of the SC type methods


clear all
rng(56)

sigma_set=1:0.25:2;   
k_set=10:2:30;  
missing_rate=[];

B=2; CCC=10; N=250; cent=cell(1,CCC); M=500; C=CCC;

for tt=1:CCC
    cent{tt}=10+10*[cos(tt*2*pi/CCC), sin(tt*2*pi/CCC)];
end

nnum=50:50:N;
nnum=[50, 100, 150, 200,250];

gg_set=[1*ones(1,CCC-4), 1*ones(1,4)]; Z=[];
for ii=1:nnum(1);     
    Z=[Z; cent{1}+[gg_set(1)*normrnd(0,1), gg_set(1)*normrnd(0,1)]];
end;

for kk=2:length(nnum)
    for ii=nnum(kk-1)+1:nnum(kk)
            Z=[Z;cent{kk}+[gg_set(kk)*normrnd(0,1), gg_set(kk)*normrnd(0,1)]];
    end
end

true_labs=ones(nnum(1),1);
for kk=2:length(nnum)
    true_labs=[true_labs;kk*ones(nnum(kk)-nnum(kk-1),1)];
end

PP=1*rand(B,M);   var_noise=1;  PP(:,51:end)=0; 
X=1*Z*PP; X_true1=X; X=X+normrnd(0,var_noise,[N M]); X_true2=X;  % X=X.* (rand(N,M)>exp(-lam_dec*X.^2)); 

X=X_true2.*(binornd(1,1-exp(-1*X_true2.^2)));  sum(sum(abs(X)==0))/(size(X,1)*size(X,2))
Y=X; y=true_labs; [n,p]=size(X); kkk=max(true_labs); r=kkk; C=max(y); CCC=C;
in_X=X;
missing_rate=[missing_rate, sum(sum(abs(X)==0))/(size(X,1)*size(X,2))];
 
C = max(true_labs); CCC=C; X=in_X; Y=X; [n p]=size(X); N=n;
[n p]=size(Y); X=Y; N=n; 

rho=0.2; lam=0.001; lam2=0.0035; eta=1; c=0.1;
[P2,W] = clus_fin_update(rho, lam, lam2, 1, c, in_X, true_labs);
[P1] = clus_fin_update_two_step(rho, lam, lam2, 1, c, in_X, true_labs);

ind_max=find(W==max(W));  ind_min=find(W==min(W));
[Kernels, id]= func_doubly(X);
[ind_spec, ~ , Vi1]= SpectralClustering(full(Kernels(:,:,ind_min)), C, 2);
[ind_spec, ~ , Vi2]= SpectralClustering(full(Kernels(:,:,ind_max)), C, 2);


rng(36)
Vi1=Vi1*Vi1'; Vi2=Vi2*Vi2';
[Vn, ~, ~]=eig1_structure(P1, CCC);
[V2n, ~, ~]=eig1_structure(P2, CCC); 
    
 



    
