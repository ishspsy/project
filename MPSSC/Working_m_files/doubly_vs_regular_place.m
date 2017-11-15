%% the code for comparisions between doubly stochastic and regular affinity matrices

rng(1028)

sigma_set=1:0.25:2;   
k_set=10:2:30; 

%missing case

nnnmi_r=[];nnnmi_rn=[];nnnmi_d=[];nnnmi_dn=[];
aaari_r=[];aaari_rn=[];aaari_d=[];aaari_dn=[];
pppur_r=[];pppur_rn=[];pppur_d=[];pppur_dn=[];
missing_rate=[];

NNN=50;

parfor ddd=1:NNN
%%simulation
B=2; CCC=5; N=150; cent=cell(1,CCC); M=500; C=CCC;

for tt=1:CCC
    cent{tt}=10+10*[cos(tt*2*pi/CCC), sin(tt*2*pi/CCC)];
end

nnum=[30,60,90,120,N];

gg_set=3*ones(1,CCC);   Z=[];
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

PP=1*rand(B,M);   var_noise=0.5;  PP(:,21:end)=0; 
lam_dec=0.03; 
X=1*Z*PP; X_true1=X; X=X+normrnd(0,var_noise,[N M]); X_true2=X;  % X=X.* (rand(N,M)>exp(-lam_dec*X.^2)); 

X=X_true2; 

X=X_true2.*(binornd(1,1-exp(-1*X_true2.^2)));  sum(sum(abs(X)==0))/(size(X,1)*size(X,2))

Y=X; y=true_labs; [n,p]=size(X); kkk=max(true_labs); r=kkk; C=max(y); CCC=C;
in_X=X;
missing_rate=[missing_rate, sum(sum(abs(X)==0))/(size(X,1)*size(X,2))];
 
C = max(true_labs); CCC=C; X=in_X; Y=X; [n p]=size(X); N=n;
[n p]=size(Y); X=Y; N=n; 
[Kernels_doubly, id]= func_doubly(X);
[Kernels_reg]= func_reg(X);

nnmi_r=[]; nnmi_rn=[];
nnmi_d=[]; nnmi_dn=[];
aari_r=[]; aari_rn=[];
aari_d=[]; aari_dn=[];
ppur_r=[]; ppur_rn=[];
ppur_d=[]; ppur_dn=[];

for tts=1:55
 
W_euc=full(Kernels_reg(:,:,tts));  W_euc_nearest=full(Kernels_doubly(:,:,tts));  

%% spectral clustering
[Clus_r,Clus_rn, Lapla3, Ueigenvecs3, UU3] = SpectralClustering_new(W_euc, CCC, 2);
[Clus_d,Clus_dn, Lapla3, Ueigenvecs3, UU3] = SpectralClustering_new(W_euc_nearest, CCC, 2); 

nmi_r=Cal_NMI(Clus_r,true_labs)  ; nmi_rn=Cal_NMI(Clus_rn,true_labs)  ;      
nmi_d= Cal_NMI(Clus_d,true_labs);  nmi_dn= Cal_NMI(Clus_dn,true_labs);  

ari_r=RandIndex(Clus_r,true_labs)  ; ari_rn=RandIndex(Clus_rn,true_labs)  ;      
ari_d= RandIndex(Clus_d,true_labs);  ari_dn= RandIndex(Clus_dn,true_labs);   

pur_r=purity(CCC,Clus_r,true_labs)  ; pur_rn=purity(CCC,Clus_rn,true_labs)  ;      
pur_d= purity(CCC,Clus_d,true_labs);  pur_dn=purity(CCC,Clus_dn,true_labs);   

nnmi_r=[nnmi_r,nmi_r]; nnmi_rn=[nnmi_rn,nmi_rn];
nnmi_d=[nnmi_d,nmi_d]; nnmi_dn=[nnmi_dn,nmi_dn];
aari_r=[aari_r,ari_r]; aari_rn=[aari_rn,ari_rn];
aari_d=[aari_d,ari_d]; aari_dn=[aari_dn,ari_dn];
ppur_r=[ppur_r,pur_r]; ppur_rn=[ppur_rn,pur_rn];
ppur_d=[ppur_d,pur_d]; ppur_dn=[ppur_dn,pur_dn];
end

nnnmi_r=[nnnmi_r;nnmi_r];nnnmi_rn=[nnnmi_rn;nnmi_rn];nnnmi_d=[nnnmi_d;nnmi_d];nnnmi_dn=[nnnmi_dn;nnmi_dn];
aaari_r=[aaari_r;aari_r];aaari_rn=[aaari_rn;aari_rn];aaari_d=[aaari_d;aari_d];aaari_dn=[aaari_dn;aari_dn];
pppur_r=[pppur_r;ppur_r];pppur_rn=[pppur_rn;ppur_rn];pppur_d=[pppur_d;ppur_d];pppur_dn=[pppur_dn;ppur_dn];
end