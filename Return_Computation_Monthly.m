function Monthly_Return=Return_Computation_Monthly(Daily_Adjust_Close)

c=Daily_Adjust_Close;
c=c(1:21:end,:);

% compute monthly return from daily adjusted close
r=(c(2:end,:)-c(1:end-1,:))./c(1:end-1,:);

% report output
Monthly_Return=r;

end

