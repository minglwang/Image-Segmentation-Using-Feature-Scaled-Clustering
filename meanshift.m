function [cluster ind]=meanshift2(data,h,limit1,limit2)
[d,n]=size(data);
sigma=h^2*eye(d);
for i=1:n
t=1;x(:,t)=data(:,i);
while 1
for j=1:n
tmp1(:,j)=data(:,j)/sqrt((2*pi)^d * det(sigma))*exp(-1/2*(data(:,j)-x(:,t))'*inv(sigma)*(data(:,j)-x(:,t)));
end
sum1=sum(tmp1,2);
for j=1:n
tmp2(j)=1/sqrt((2*pi)^d * det(sigma))*exp(-1/2 * (data(:,j)-x(:,t))'*inv(sigma)*(data(:,j)-x(:,t)));
end
sum2=sum(tmp2);
x(:,t+1)=sum1/sum2;

if norm(x(:,t+1)-x(:,t))<limit1
    peak(:,i)=x(:,t+1);
    if i==1
        cluster(:,1)=peak(:,1);% the first cluster center
        ind(1)=1;
    end
    jug=false;
    for k=1:size(cluster,2)
    dist=norm(peak(:,i)-cluster(:,k));
    if norm(peak(:,i)-cluster(:,k))<limit2 % judge if the peak belongs to the existing cluster
    jug=true;
    ind(i)=k % if true return the index of cluster
    end
    end
    
    if jug==false
        cluster(:,size(cluster,2)+1)=peak(:,i);% if no existing cluster matches, the peak is a new cluster 
        ind(i)=size(cluster,2)
    end
    clear x
    break
end
t=t+1;
end
end

% find the index for data point with same value





end
