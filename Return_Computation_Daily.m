function Daily_Return=Return_Computation_Daily(Daily_Adjust_Close)

c=Daily_Adjust_Close; 

% compute daily return from daily adjusted close
r=(c(2:end,:)-c(1:end-1,:))./c(1:end-1,:);

% report output
Daily_Return=r;

end

