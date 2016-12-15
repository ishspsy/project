function [Mean_Return,Sharpe_Ratio,Short,Turnover,Ratio_of_Active_P,Stability] ...
    = Output(al,de,monthly_return,monthly_return_benchmark)

p=size(de,1)+1; % number of assets including benchmark

Mean_Return=zeros(1,2);
Mean_Return(1)=mean(monthly_return_benchmark)*12;
Mean_Return(2)=mean(monthly_return)*12;

Sharpe_Ratio=zeros(1,2);
Sharpe_Ratio(1)=mean(monthly_return_benchmark)/std(monthly_return_benchmark);
Sharpe_Ratio(2)=mean(monthly_return)/std(monthly_return);

Short=zeros(1,2);
Short(1)=0;
Short(2)=sum(sum(de.*(de<0)))/size(de,2);

Turnover=zeros(1,2);
Turnover(1)=0;
Turnover(2)=mean(sum(abs(de(:,2:end)-de(:,1:end-1))))+mean(abs(al(2:end)-al(1:end-1)));

Ratio_of_Active_P=zeros(1,2);
Ratio_of_Active_P(1)=0;
Ratio_of_Active_P(2)=mean(sum(abs(de)>0.0001))/(p-1);

Stability=zeros(1,2);
Stability(1)=0;
Stability(2)=mean(sum(abs((abs(de(:,2:end))>0.0001)-(abs(de(:,1:end-1))>0.0001))))/(p-1);

end

