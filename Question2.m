clc
clear
close all
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%mychat=xlsread('optimizer.data.xlsx');
%seq1=mychat(102:111,1:100);
filename = 'book2.xlsx';
sheet = 1;
xlRange = 'A4:C363';
St = xlsread(filename,sheet,xlRange);
% mychat = xlsread('book2.xlsx');
% St = mychat('A4:C363');
[n,m]=size(St);
s=zeros(72,95);
for i=1:n
    s(St(i,1),St(i,2))=St(i,3);
end
seq1=s;
[m, n]=size(seq1);
f=[ones(n,1);ones(n,1)];

s_eq=[seq1 -seq1];
b_eq=zeros(m,1);

%lb1=mychat(1:100,1);
Lt=xlsread(filename,'A410:B450');
[nl,ml]=size(Lt);
l1=zeros(95,1);
for i=1:nl
    l1(Lt(i,1))=Lt(i,2);
end
lb1=l1;
%ub1=mychat(113:212,1);
Ut=xlsread(filename,'A367:B406');
[nu,mu]=size(Ut);
u1=zeros(95,1);
for i=1:nu
    u1(Ut(i,1))=Ut(i,2);
end
ub1=u1;
 s_ineq=[eye(n,n) -eye(n,n);-eye(n,n) eye(n,n);-eye(n,n) zeros(n,n);zeros(n,n) -eye(n,n) ];
b_ineq=[ub1;-lb1;zeros(n,1);zeros(n,1)];

options = optimoptions('linprog','Algorithm','dual-simplex','Display','iter');
[v,fval,exitflag,output,lambda]= linprog(f,s_ineq,b_ineq,s_eq,b_eq,[],[],options);

for i=1:n
    k(i)=v(i)-v(i+95);
end

t=sum(k==0)