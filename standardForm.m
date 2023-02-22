clc
clear all

%given params
c=[-1 2 -1 0 0 0 0];
a=[1 0 0 1 0 0 0;0 1 0 0 1 0 0;-1 1 0 0 0 1 0;-1 0 2 0 0 0 1];
b=[4 ;4;6;4];

n= size(a,2); %no. of variables= no. of cols in a
m= size(a,1); %no. of constraints= no of rows in a

if(n>=m)
    ns= nchoosek(n,m); %no of possible soln: combination(n,m)
    %non basic variable= n-m; selecting combination of (n-m) vars at a time from n vars
    t= nchoosek(1:n,m); 
end
ns
t 

sol=[];
for i=1:ns
    y=zeros(n,1);
    A= a(:,t(i,:)); %selecting the pairs in t from a
    x= A\b;
    if(x>0 & x~=inf & x~= -inf)
        y(t(i, :))=x;
        sol= [sol y];
    end
end
sol

fin=[];
for i=1:size(sol,2)
    d= c * sol(:,i);
    fin= [fin d];
end
fin

fprintf('max value= %f', max(fin));