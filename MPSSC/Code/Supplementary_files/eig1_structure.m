%%The code is published in BatzoglouLabSU/SIMLR.
%	Copyright (c) Bo Wang and Daniele Ramazzotti (2016-2017)
%  email: bowang87@stanford.edu

function [eigvec, eigval, eigval_full] = eig1_structure(A, c, isMax, isSym)


if nargin < 2
    c = size(A,1);
    isMax = 1;
    isSym = 1;
elseif c > size(A,1)
    c = size(A,1);
end;

if nargin < 3
    isMax = 1;
    isSym = 1;
end;

if nargin < 4
    isSym = 1;
end;

if isSym == 1
    A = max(A,A');
end;
[v d] = eig(A); eps=0.01; 
d = diag(d);
%d = real(d);
if isMax == 0
    [d1, idx] = sort(d);
else
    [d1, idx] = sort(d,'descend');
end;

idx1 = idx(1:c);
eigval = d(idx1);
eigvec = real(v(:,idx1));
eigvec=eigvec*eigvec';
eigvec=eigvec.*(abs(eigvec)>eps);
eigval_full = d(idx); 