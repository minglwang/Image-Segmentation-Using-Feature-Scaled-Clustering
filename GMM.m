function [miu re]=GMM(data,kf,alpha1,alpha2,limit)
[d,n]=size(data);% d is the number of feature, n is the number of sample 
[miu,p,sigma]=com_split(data,d,n,kf,alpha1);
logy=0;
num=0;
while 1
    prelogy=logy;
    num=num+1;
    % E-step  
    for j=1:kf
    for i=1:n
    tmpz(i,j)=p(j)/sqrt((2*pi)^d*det(sigma(:,:,j)))*exp(-1/2 * (data(:,i)-miu(:,j))'*inv(sigma(:,:,j))*(data(:,i)-miu(:,j))); 
    end
    end
    sumz=sum(tmpz,2);
    for j=1:kf
      for i=1:n
          z(i,j)=p(j)/sqrt((2*pi)^d*det(sigma(:,:,j)))*exp(-1/2 * (data(:,i)-miu(:,j))'*inv(sigma(:,:,j))*(data(:,i)-miu(:,j)))/sumz(i);
      end
    end
    
     % M-step
     for j=1:kf
         N(j)=sum(z(:,j));
         p(j)=N(j)/n;
         miu(:,j)=1/N(j)*(z(:,j)'*data');
         for i=1:n;
         tmps(:,i)=z(i,j)*(data(:,i)-miu(:,j)).*(data(:,i)-miu(:,j));
         end
         sigma(:,:,j)=diag(sum(tmps,2)/N(j))+alpha2*eye(d);
     end
    
     % stop criterion
    for j=1:kf
        for i=1:n
        tmpy(i,j)=p(j)/sqrt((2*pi)^d * det(sigma(:,:,j)))*exp(-1/2 * (data(:,i)-miu(:,j))'*inv(sigma(:,:,j))*(data(:,i)-miu(:,j)));
        end
    end
    tmpsumy=sum(tmpy,2);
    for i=1:n
    tp(i)=log(tmpsumy(i));
    end
    logy=sum(tp(i));
    if norm(logy-prelogy)<limit
        break
    end
    if num>1000
        break
    end
end
for i=1:n
[junk ind]=max(z(i,:));
re(:,i)=[data(:,i);ind];
end
end