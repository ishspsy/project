clear all
rng(1028)

sigma_set=1:0.25:2;
k_set=10:2:30;



NNN=50;

performance_set=cell(1,NNN); missing_rate=[];
parfor ddd=1:NNN

%%simulation
B=2; CCC=5; N=250; cent=cell(1,CCC); M=500; C=CCC;

for tt=1:CCC
    cent{tt}=10+10*[cos(tt*2*pi/CCC), sin(tt*2*pi/CCC)];
end

nnum=50:50:N;

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

X=1*Z*PP; X_true1=X; X=X+normrnd(0,var_noise,[N M]); X_true2=X;

X=X_true2;

X=X_true2.*(binornd(1,1-exp(-0.2*X_true2.^2))); sum(sum(abs(X)==0))/(size(X,1)*size(X,2))

Y=X; y=true_labs; [n,p]=size(X); kkk=max(true_labs); r=kkk; C=max(y); CCC=C;
in_X=X;
missing_rate=[missing_rate, sum(sum(abs(X)==0))/(size(X,1)*size(X,2))];

C = max(true_labs); CCC=C; X=in_X; Y=X; [n p]=size(X); N=n;
[n p]=size(Y); X=Y; N=n;
[Kernels_doubly, id]= func_doubly(X);

nnmi_r=[]; nnmi_rn=[];
nnmi_d=[]; nnmi_dn=[];
aari_r=[]; aari_rn=[];
aari_d=[]; aari_dn=[];
ppur_r=[]; ppur_rn=[];
ppur_d=[]; ppur_dn=[];

c_set=[0.01, 0.05,0.1,1];
lam1_set=[0.00001,0.0001, 0.001, 0.01];
lam2_set=[0.00001,0.0001, 0.001, 0.05, 0.01];
kn_set=10;
rho=0.2; c=0.1;


performance1=cell(length(c_set),length(lam1_set),length(lam2_set));

for ii=1:length(c_set)
    for jj=1:length(lam1_set);
        for kk=1:length(lam2_set);
           c=c_set(ii); lam=lam1_set(jj); lam2=lam2_set(kk);
[P2] = clus_fin_update(rho, lam, lam2, 1, c, in_X, true_labs, 0);
[nmi11, nmi22,clus_dou1,clus01]=calc2_nmis(CCC, double(P2),true_labs) ;
pu11=purity(CCC, clus_dou1, true_labs);  pu22=purity(CCC, clus01, true_labs);
tot_mpssc=[nmi11, nmi22;pu11,pu22; RandIndex(clus_dou1,true_labs),RandIndex(clus01,true_labs) ]';
performance1{ii,jj,kk}=tot_mpssc;
        end
    end
end
performance_set{ddd}=performance1;
end

save('robust_mcase2.mat', 'performance_set','missing_rate')


