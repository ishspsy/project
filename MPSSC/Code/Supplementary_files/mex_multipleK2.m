function D_kernels = mex_multipleK2(val,ind,KK)
%% computing affinity matrix from Gaussian kernels

t = 1; allk = 10:2:30;  sigma = [1:0.25:2];
for i = 1:length(allk)
    if allk(i)< size(val,2)
    temp = mean(val(:,1:allk(i)),2);
    temp0 = .5*(repmat(temp,1,size(val,2)) + temp(ind));
    
    for j = 1:length(sigma)
        temp = normpdf(val, 0, sigma(j)*temp0);
        %temptemp = temp(:,1);
        %temp = .5*(repmat(temptemp,1,size(val,2)) + temptemp(ind)) - temp;
        D_kernels(:,:,t) = temp;
        t = t+1;
    end
    end
end
end