function rc=Shift_Long(rc)
    rc_temp=rc;
    rc_temp(1:end-21,:)=rc(22:end,:);
    rc_temp(end-20:end,:)=rc(1:21,:);
    rc=rc_temp;
end

