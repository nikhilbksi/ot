clc 
clear all

%given params
%all b vars (rhs) have to be positive
c=[2 4 7 0 0 0]
a=[5 -7 9; -2 -6 0; 6 2 1];
b=[5; 2; 6];

%storing equality data for the 3 constraints
inequality= [0 0 1]; % (>= ~ 0) and (<= ~ 1)

s= eye(size(a,1)); %stack/surplus - identity matrix of size same to a (constraints)
t= (inequality>0); %finding which row in s has to be multiplied with -1
s(t,:)= -s(t,:);
s

a = [a s]

%given params

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