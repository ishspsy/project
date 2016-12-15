function rc1=Shift_Short(rc1)
    rc1_temp=rc1;
    rc1_temp(1:end-1,:)=rc1(2:end,:);
    rc1_temp(end,:)=rc1(1,:);
    rc1=rc1_temp;
end

