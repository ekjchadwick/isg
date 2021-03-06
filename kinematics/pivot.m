function[Sopt,Se,Vopt,Ve]=pivot(Vector,Point_on_vector)
%pivot.m
% function[Sopt,Se,Vopt,Ve]=pivot(Vector,Point_on_vector)
% calculation of the optimal pivot point as published in Woltring (1990)
% In "Biomechanics of Human Movement" (Formia)
% results are correct for elbow flexion and pro/supination
% 8/12/94
% adjusted and extended for the vector at 14-10-2004
% DirkJan

V=Vector;
R=Point_on_vector;

[m,n]=size(V);

Q=zeros(3,3);s=[];d2=[];

if n>m, 
    V=V';R=R';
end

x=find(isnan(V(:,1)));
if length(x)>=1,
    V(x,:)=[];
    R(x,:)=[];
end


x=find(V(:,1)==0);
if length(x)>=1,
    V(x,:)=[];
    R(x,:)=[];
end


[m,n]=size(V);


for i=1:m,
           q=[eye(3)-V(i,:)'*V(i,:)]; 
           S(:,i)=q*R(i,:)'; 
           Q=Q+q;         
end


Q_2=Q/m;
Sopt=inv(Q_2)*mean(S')';


R_2=[Q_2-eye(3)];  % own addition
[u,s,v]=svd(R_2);  % own addition, not mathematically checked
Vopt=u(:,1);       % own addition



for i=1:m,
           q=[eye(3)-V(i,:)'*V(i,:)];
           d2(i)=[Sopt'-R(i,:)]*q*[Sopt'-R(i,:)]';
           d(i)=acos(V(i,:)*Vopt);
end

Se=mean(d2');% rms error
Ve=mean(d);

                                                                                                                            