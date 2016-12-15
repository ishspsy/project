function Daily_Adjust_Close=Data_Cleaning_Initial(Daily_Adjust_Close)

c=Daily_Adjust_Close; 

% find and delete assets that have empty cell
ind=find(sum(isnan(c))); 
[~,p]=size(c);
c=c(:,setdiff(1:p,ind));

% flip up down
c=flipud(c);

% report output
Daily_Adjust_Close=c;

end

