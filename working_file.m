clear all
addpath('/Users/seyoungpark/Documents/MATLAB')
addpath('/Users/seyoungpark/Documents/MATLAB/SIMLR_real/src')
addpath('/Users/seyoungpark/Documents/MATLAB/drtoolbox')
addpath('SpectralClustering')
addpath('KPCA.1')
addpath('projcapped')
addpath('code')
addpath('code/data')


case_num=2;

sigma_set=1:0.25:2;   
k_set=10:2:30;  

nnmin=0;nnmi2n=0; 


B=2; CCC=5; N=150; cent=cell(1,CCC); M=300; adding=0; C=CCC+adding; CCC=C;
cent{1}=[0 0]; cent{2}=1*[10 10]; cent{3}=1*[-10 10]; cent{4}=1*[10 -10]; cent{5}=1*[-10 -10]; Z=[]; 
cent{6}=[20 10]; cent{7}=1*[20 20]; cent{8}=1*[-20 10]; cent{9}=1*[20 -20]; cent{10}=1*[-20 -20];

for tt=1:CCC
    cent{tt}=10*[cos(tt*2*pi/CCC), sin(tt*2*pi/CCC)];
end


nnum=[50,100,150,200,N];
nnum=[30,60,90,120,N];

gg_set=3*ones(1,CCC); 
for ii=1:nnum(1);         
    Z=[Z;cent{1}+[gg_set(1)*normrnd(0,1), gg_set(1)*normrnd(0,1)]];
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

X=X_true2; case_num=2;

if case_num==0
    X=X_true2;   
elseif case_num==1
X=X_true2.*(binornd(1,1-exp(-1*X_true2.^2)));     sum(sum(abs(X)==0))/(size(X,1)*size(X,2))
elseif case_num==2
X=X_true2.*(binornd(1,1-exp(-0.1*X_true2.^2))); sum(sum(abs(X)==0))/(size(X,1)*size(X,2))
    elseif case_num==3
X=X_true2.*binornd(1,0.8,N,M);  sum(sum(abs(X)==0))/(size(X,1)*size(X,2))
    elseif case_num==4
X=X_true2.* binornd(1,min(0.2*abs(X_true2),1)) ;      sum(sum(abs(X)==0))/(size(X,1)*size(X,2))                         %X=X_true2.*binornd(1,0.4,n,p);   %case4 , not good
    elseif case_num==5
X=X_true2.*(binornd(1,1-exp(-1*abs(X_true2))));       sum(sum(abs(X)==0))/(size(X,1)*size(X,2))  
    elseif case_num==6
X=X_true2.*(binornd(1,1-exp(-0.3*abs(X_true2))));      sum(sum(abs(X)==0))/(size(X,1)*size(X,2))  
    elseif case_num==7
X=X_true2.*binornd(1,0.9*(abs(X_true2)>mean(quantile(X_true2,0.1))));   sum(sum(abs(X)==0))/(size(X,1)*size(X,2))  
    elseif case_num==8
X=X_true2.*binornd(1,0.9*(abs(X_true2)>mean(quantile(X_true2,0.5))));   sum(sum(abs(X)==0))/(size(X,1)*size(X,2))  
    end

Y=X; y=true_labs; [n,p]=size(X); kkk=max(true_labs); r=kkk; C=max(y); CCC=C;
in_X=X;


C = max(true_labs); CCC=C; X=in_X; Y=X; [n p]=size(X); N=n;
 
 
[n p]=size(Y); X=Y; N=n; 

W_euc_orig=pdist(X); W_euc0=squareform(W_euc_orig);


W_euc_set=cell(length(sigma_set), length(k_set));  W_euc_nearest_set=cell(length(sigma_set), length(k_set));
W_euc_set_n=cell(length(sigma_set), length(k_set));  W_euc_nearest_set_n=cell(length(sigma_set), length(k_set));

for tts=1:length(sigma_set) 
    for ttk=1:length(k_set)
        sigma=sigma_set(tts); cln=k_set(ttk);    
        [IDX DDist] = knnsearch(Y,Y,'k',round(cln)); muij=mean(DDist(:,2:end),2);  logn=round(cln);
        muij=repmat(muij,[1,length(muij)])+repmat(muij',[length(muij),1]);  muij=muij*0.5; 
        W_euc=exp(-(W_euc0.^2)./(2*(muij*sigma).^2 ))./ (muij*sigma*sqrt(2*pi))  ;  
        W_ind=zeros(N,N);
        for ii=1:N
         W_ind(ii,find(W_euc(ii,:)>quantile(W_euc(ii,:),(n-logn)/n)))=1;
        end
         W_ind=(W_ind+W_ind')*0.5; W_ind(W_ind>0)=1;
         W_euc_nearest=W_euc.*W_ind;    
         W_euc_set{tts,ttk}=W_euc;  W_euc_nearest_set{tts,ttk}=W_euc_nearest;
         WW1= W_euc_set{tts,ttk}; DWW1= (max(sum(WW1),eps)).^(-0.5); WW1=  diag(DWW1)*WW1*diag(DWW1);
         W_euc_set_n{tts,ttk}=W_euc;
         WW2= W_euc_nearest_set{tts,ttk}; DWW2= (max(sum(WW2),eps)).^(-0.5); WW2=  diag(DWW2)*WW2*diag(DWW2);
         W_euc_nearest_set_n{tts,ttk}=WW2;
    end
end


W_euc_double=cell(length(sigma_set), length(k_set));  W_euc_nearest_double=cell(length(sigma_set), length(k_set));
for tts=1:length(sigma_set) 
    for ttk=1:length(k_set)
         WW1= W_euc_set{tts,ttk}; 
         DWW1= (max(sum(WW1),eps)).^(-0.5); 
         WW1=  diag(DWW1)*WW1*diag(DWW1);
         WW2= W_euc_nearest_set{tts,ttk}; 
         DWW2= (max(sum(WW2),eps)).^(-0.5); 
         WW2=  diag(DWW2)*WW2*diag(DWW2);
         W_euc_double{tts,ttk}=SK_normalize(WW1);  W_euc_nearest_double{tts,ttk}=SK_normalize(WW2);
    end
end


distXn=0;
for ii=1:(length(sigma_set)*length(k_set))
    distXn=distXn+ W_euc_nearest_double{ii}/(length(sigma_set)*length(k_set));
end
[distX1, idx] = sort(distXn,2,'descend');


c_set=[0.01, 0.05,0.1,1];
lam1_set=0.0001; 
lam2_set=lam1_set;
kn_set=5:5:80;

c=0.1; knn=10; idn = idx(:,2:(knn+1));
rho=0.2; lam=0.0001; mu=0.0001; eta=1; 
[rep, W, Pn, Q]=clus_sim_update2_2(CCC, c, 0.001, rho, lam, idn, eta, W_euc_nearest_double) ;

[Vn, temp, evs]=eig1(Pn, CCC);  lam2=0.0001; lam2=lam2_set(ilam2);    
[rep, P2n, Q, Gamma]=clus_sim_update0_3(CCC, lam2, eta, Vn*Vn');

[nmi11n, nmi22n,clus_dou1n,clus01n]=calc2_nmis(CCC, P2n,true_labs) ;     %calculate NMI



